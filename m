From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: [PATCH - RME MADI/RayDAT/AIO support 1/1] Add
	support for RME	MADI, RayDAT and AIO
Date: Sun, 9 Jan 2011 20:17:06 +0100
Message-ID: <20110109191706.GR2250@ltw.loris.tv>
References: <1294598579-6392-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id 07BB1243A9
	for <alsa-devel@alsa-project.org>; Sun,  9 Jan 2011 20:17:16 +0100 (CET)
Received: from localhost (ltw.loris.tv [127.0.0.1])
	by ltw.loris.tv (Postfix) with ESMTP id E1E911AC637
	for <alsa-devel@alsa-project.org>; Sun,  9 Jan 2011 20:17:11 +0100 (CET)
Received: from ltw.loris.tv ([127.0.0.1])
	by localhost (ltw.loris.tv [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ArohIAmVr7Sw for <alsa-devel@alsa-project.org>;
	Sun,  9 Jan 2011 20:17:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1294598579-6392-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

On Sun, Jan 09, 2011 at 07:42:59PM +0100, Adrian Knoth wrote:

Hi!

> Code taken from http://wiki.linuxproaudio.org/index.php/App:hdspmixer_64

A few words: the patch works for my RayDAT, but I have no idea if it's
still working with all the other cards.

I can test it against my Multiface next week, but it probably makes
sense if others could verify it on their hardware, especially all those
cards I don't have.

I'll hopefully come up with a follow-up patch to snd-hdspm next week
when I find more time. It will add RayDAT and AIO support to the kernel
drivers.


Cheers

-- 
mail: adi@thur.de  	http://adi.thur.de	PGP/GPG: key via keyserver
