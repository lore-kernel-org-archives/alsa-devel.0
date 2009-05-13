From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: Intel HDA fix for Macbook 3,1 and newer
Date: Wed, 13 May 2009 18:40:43 +0300
Message-ID: <4A0AE9FB.7010502@pardus.org.tr>
References: <4A0AD9BE.7070808@letorbi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pardus.org.tr (comar.uludag.org.tr [193.140.100.220])
	by alsa0.perex.cz (Postfix) with ESMTP id E18401038BB
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 17:40:41 +0200 (CEST)
In-Reply-To: <4A0AD9BE.7070808@letorbi.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Le Torbi <public@letorbi.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Le Torbi wrote:
> Hi guys,
>
> I'm new to this list and never contributed anything to such a big
> open-source project like ALSA, so please forgive me if I make some
> newbie mistakes.
> But back the the important stuff: I own a MacBook 3,1 and experienced
> some sound issues with this. I didn't have no sound, but the sound was
> quite low in quality and volume. After some research and a lot of wrong
> ways I stumbled upon bug 0004086 "MacBook 4,1 sounds tinny or not at all
> " in the ALSA bug tracking system
> (https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4086) and
> managed to fix it.
> Any details can be found in the bug report as well as a link to my
> patch. My questions now are:
>
> 1. Could an exprineced ALSA-Coder check my patch for bugs or "newbie 
> code glitches"?
> 2. What do I have to do, to get my patch in the official code repository?
>   
Cool! I have a MacbookPro5,1 and the same problems. With mbp3 the sound
quality is very bad.
I posted an e-mail to the list few days ago but didn't have any replies
so far.

I resolved the problem by playing with codec PINs using the tool
hda-analyzer. That trick should
be reflected to a patch but I'm a real newbie and don't have time for it.

So if you want that your code to be reviewed, attach the unified patch
(diff -u) between the latest patch_realtek.c and your patched version.

Regards,
Ozan Caglayan
