From: Tobias Hansen <Tobias.Hansen@physik.uni-hamburg.de>
Subject: About TASCAM US-122 mkII support
Date: Mon, 07 Dec 2009 17:41:15 +0100
Message-ID: <4B1D302B.5040002@physik.uni-hamburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.physnet.uni-hamburg.de (MAIL.PHYSnet.uni-hamburg.de
	[134.100.106.230])
	by alsa0.perex.cz (Postfix) with ESMTP id BB91D244FD
	for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2009 17:41:22 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, delaossa@mail.desy.de
List-Id: alsa-devel@alsa-project.org

Alberto Martinez de la Ossa <delaossa@mail.desy.de> wrote:

> Hello,
> I have just got the TASCAM US-122 mkI 
> <http://www.tascam.com/products/us-122mkII.html>I audio/midi interface, 
> which seemed to me a great product and a good deal.
> The problem is that I use a linux system (ubuntu-studio karmic) for 
> music production and the interface can not be recognized when plugged.
> Among other reasons I chose this device because I thought it would work 
> in linux:
> There were alsa drivers for its predecessors, the us-122 
> <http://alsa.opensrc.org/Tascam_US-122>  and the us-122l 
> <http://www.pps.jussieu.fr/%7Esmimram/tascam/> models.
> The latter, thanks to Karsten Wiese who wrote a patch for the us-122l 
> version, which was latter included by default in newer alsa-firmware 
> releases.
> 
> Unfortunately, the new model (US-122 mkII), the one I have, is not 
> supported yet.
> I have even tried to get it replaced by the previous us-122l model, but 
> it is not available anymore in the music store -> http://www.justmusic.de
> On the other hand, the "linux specialist" of the music store told me 
> that a new linux driver for the us-122 mkII is been prepared,
> although he doesn't know when it will be ready.
> Being you the experts I have found in the web in regards with ALSA and 
> TASCAM usb interfaces, I have decided to directly ask you about this.
> I would really appreciate any information about the topic.

Hi,

I know that the US-144 MKII has a different Product ID (8020) than the US-144 (800F), so the US-122 MKII probably also has another one than the US-122L. If you post your output of lsusb with the device plugged in, I could make a patch that adds these both IDs to the us122l driver for testing if that suffices.

I don't know if you are familiar with compiling kernel modules etc. If you need more detailed instructions, you can join the discussion at http://forum.ubuntuusers.de/topic/tascam-us-144 in either German or English (I know desy.de doesn't necessarily mean you speak German) or send a mail.

By the way, I suspect the "linux specialist" at that shop is good in making things up, because Tascam has never provided any Linux drivers and he can't really know what the Linux people do on their own.

Best regards, Tobias Hansen
