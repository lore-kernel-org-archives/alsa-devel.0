From: Kai Vehmanen <kvehmanen@eca.cx>
Subject: Re: safe support for rewind in ALSA
Date: Sun, 21 Feb 2010 12:06:41 +0200 (EET)
Message-ID: <alpine.DEB.1.10.1002211155420.3327@ecabase.localdomain>
References: <6160a5131002010920j4417a34ai9f410fb500f7f305@mail.gmail.com>
	<20100201180139.GC15509@sirena.org.uk>
	<alpine.LNX.2.00.1002011903330.25340@eeebox2.perex-int.cz>
	<alpine.DEB.1.10.1002012239220.3125@ecabase.localdomain>
	<alpine.DEB.1.10.1002012328440.3125@ecabase.localdomain>
	<4f3252891002081459q29f02414hf168a596ab641995@mail.gmail.com>
	<alpine.DEB.1.10.1002092242540.3125@ecabase.localdomain>
	<4f3252891002100519h132fddb8t1f2bc56e97bf5c40@mail.gmail.com>
	<4B72B665.3060903@ladisch.de>
	<4f3252891002102252vb6d7a94l76fb78e33da37775@mail.gmail.com>
	<4B73AFD5.4080205@ladisch.de>
	<alpine.LNX.2.00.1002110822480.19278@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gw03.mail.saunalahti.fi (gw03.mail.saunalahti.fi
	[195.197.172.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F157243C1
	for <alsa-devel@alsa-project.org>; Sun, 21 Feb 2010 11:10:00 +0100 (CET)
In-Reply-To: <alpine.LNX.2.00.1002110822480.19278@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Hi,

On Thu, 11 Feb 2010, Jaroslav Kysela wrote:

>> However, PA ignores the sound card's interrupts and is woken up by its
>> own timer.
>
> PA can drive the wake-ups using avail_min sw parameter. If this value is
> high enough, no userspace wake up is called, only interrupt is processed
> and internal ring buffer pointers in the driver are updated.

but that's unfortunately not enough. AFAIK glitch-free aims, among other 
things, to minimize power usage for battery powered devices, and to do 
that, you need to minimize hardware interrupts [1]. And for that, 
avail_min won't help.

[1] this is exactly the same thing that is driving Linux tickless
     development:
     http://www.lesswatts.org/projects/tickless/

PS I do agree that avail_min is a very useful, and often overlooked
    feature, of ALSA. But in this specific case it won't help...
