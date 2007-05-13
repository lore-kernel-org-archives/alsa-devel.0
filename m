From: Lorenz Kolb <alsa-dev@lkmail.de>
Subject: embedded sound architecture question
Date: Sun, 13 May 2007 12:02:13 +0200
Message-ID: <4646E225.2000602@lkmail.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pm1.terions.de (pm1.terions.de [83.137.96.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FCAC24633
	for <alsa-devel@alsa-project.org>;
	Sun, 13 May 2007 12:03:03 +0200 (CEST)
References: 1178743654.29464.1.camel@localhost
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2007-05-09 at 14:20 -0700, John L. Utz III wrote:
 > On Wed, 09 May 2007 22:47:34 +0200
 > "Joachim F=F6rster" <mls.JOFT at gmx.de> wrote:
 > > My question is: Does the architecture described below make sense/is
 > > reasonable with ALSA and Linux?
 >
 > i think you might have to answer an earlier question first; 'does it
 > make sense to call this an ac97 controller?' I dont recall seeing a
 > ring buffer as part of the ac97 standard. i'd suggest that you take the
 > time to flesh out completely how the ring buffer is supposed to replace
 > dma and ram while still presenting an ac97 set of verbs because i am
 > stuck with the gut feeling that you will some important things will
 > have to be really different.

Hi, I am the "Hardware-Guy" in the project.

And I am quite sure there is no limitation on what to built into the =

AC'97 controller (from a specs point of view)
The controller's job in the AC'97 standard is afaik mainly a parallel to =

serial conversion. As the codec's link is serial.
But I am not quite sure, if you do understand: we have complete control =

of what the hardware-part does. So our main idea is: presenting some =

sort of "dedicated" RAM to the system.
So what does memory mean for a system: it is a bunch of addresses =

offering both a read() and a write() (maybe also a burst_read() and =

burst_write()).
The only question is: will Linux-kernel be able to see our dedicated =

memory as memory and does this way make sense for ALSA.
It is not a question of "is this possible for a AC'97 controller?".
We are not building a simple/stupid AC'97 controller as it can be found =

on billions of mainboards, but in some parts it sticks to the rules of =

AC'97 (at least in case of the interface towards the codec, as the codec =

is an AC'97). So actually it is an AC'97 controller, as it drives an =

AC'97 codec.
So what are the benefits of the idea not using "normal" DMA?
Each write/read to memory normally "freezes" the CPU, either because the =

CPU does this read/write or because the Bus is occupied. Having an =

dedicated memory in the controller avoids this quite well. The CPU =

freezes only whenever it writes data to the controller's memory (or =

reads from it). Accessing the memory from the controller does not have =

an effect on the bus and thus neither cpu nor memory nor bus become =

occupied.
The main reason why we do not want to rely on the cpu is because it is =

for an embedded system. So we do not talk about giga-hertz. We talk =

about a system with a 100 MHz bus architecture and a PowerPC with 300 =

MHz. And the system has more tasks than only playing some audio...
So the design goal is minimizing the system load while offering a =

maximum of features (with an affordable amount of logic).

Greetings,

Lorenz Kolb
