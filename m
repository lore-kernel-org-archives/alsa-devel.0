From: "Dmitry Baikov" <dsbaikov@gmail.com>
Subject: Re: 1.0.13 and indigoio
Date: Thu, 14 Dec 2006 20:05:32 +0300
Message-ID: <70a871c80612140905h4244ff84p4b403017ea3faafd@mail.gmail.com>
References: <70a871c80610050536w2968cd52n32a5960899b4e90b@mail.gmail.com>
	<70a871c80610060712k2f04c1bbpa73fd1473f840871@mail.gmail.com>
	<70a871c80610060802n22a3f184g8b206b11bd0608de@mail.gmail.com>
	<20061009224039.74f7af57.pochini@shiny.it>
	<70a871c80610100914v309f4519w97cc21a774c35a63@mail.gmail.com>
	<20061012222126.77234cde.pochini@shiny.it>
	<70a871c80610131257l2e71a705tbc41ec44f3a882bd@mail.gmail.com>
	<70a871c80610260654n3e51e3bmab48254af79f01eb@mail.gmail.com>
	<70a871c80611011851k77e3f8ddhd57866f0eb59504e@mail.gmail.com>
	<20061104215343.4ce48211.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061104215343.4ce48211.pochini@shiny.it>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Giuliano Pochini <pochini@shiny.it>
Cc: tiwai@suse.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

After some time of watching and experimenting, the things are this:

Indigo IO is always inserted into cardbus slot, sometimes it fails at
boot time with

[    8.580000] PCI: Enabling device 0000:07:00.0 (0000 -> 0002)
[    8.580000] ACPI: PCI Interrupt 0000:07:00.0[A] -> GSI 18 (level,
low) -> IRQ 16
[    8.790000] Echoaudio Indigo IO: probe of 0000:07:00.0 failed with error -5

It can be cured with unloading alsa driver and replugging the card:

[ 3445.790000] pccard: card ejected from slot 0
[ 3445.821000] PCMCIA: socket c1b4a428: *** DANGER *** unable to
remove socket power
[ 3449.018000] pccard: CardBus card inserted into slot 0
[ 3449.041000] PCI: Enabling device 0000:07:00.0 (0000 -> 0002)
[ 3449.041000] ACPI: PCI Interrupt 0000:07:00.0[A] -> GSI 18 (level,
low) -> IRQ 16
[ 3449.122000] Card registered: Indigo IO rev.0 (DSP56361) at 0x54000000 irq 16

After this, card works.

Manual reservation of memory regions does not change anything.

It is a problem I can live with, but something is definitely wrong here.

Regards,
Dmitry.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
