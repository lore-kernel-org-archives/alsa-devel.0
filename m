From: Anton Yashin <fynjy-007@yandex.ru>
Subject: Re: Problem with PPH plugin
Date: Wed, 20 Jan 2010 22:24:46 +0000 (UTC)
Message-ID: <loom.20100120T231250-50@post.gmane.org>
References: <hj4rap$ofp$2@ger.gmane.org> <s5hr5pljj7a.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F84B245E3
	for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2010 23:30:14 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.50) id 1NXj3s-0007e0-FK
	for alsa-devel@alsa-project.org; Wed, 20 Jan 2010 23:30:04 +0100
Received: from 95-29-8-170.broadband.corbina.ru ([95.29.8.170])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2010 23:30:04 +0100
Received: from fynjy-007 by 95-29-8-170.broadband.corbina.ru with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2010 23:30:04 +0100
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

Takashi Iwai <tiwai <at> suse.de> writes:

> 
> Hm, this is a horrible combination for debugging: a binary-only app
> plugin from another app....  The backtrace shows the function: that's
> good.  But, it shows the very first line of the function.  So, it
> can't tell where actually hits.  It makes hard to guess...
> 
> And, I can't reproduce the bug.
> 
> The reporter can try the following, at least:
>  - uninstall alsa-plugins package to see whether it's a speexrate
>    plugin issue
>  - update packages from OBS multimedia:audio:libs repo, to be sure,
>    whether the problem got fixed in the later versions
> 
> Takashi
> 

Hi and thanks for the advice. Yes the issue is present only if a package
"alsa-plugins" installed. The problem also occurs after the upgrade packages
http://download.opensuse.org/repositories/multimedia:/libs/openSUSE_11.2/ . I
also added information to the alsa bugtracker.
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4878

Anton
