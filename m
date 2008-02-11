From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Re: 1.0.16 snd-aoa driver
Date: Mon, 11 Feb 2008 21:35:17 +0100
Message-ID: <20080211203517.GA3546@aragorn.home.lxtec.de>
References: <20080210232728.GA10710@aragorn.home.lxtec.de>
	<s5h1w7jwn3b.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpout.hostsharing.net (smtpout.hostsharing.net [83.223.95.98])
	by alsa0.perex.cz (Postfix) with ESMTP id 19D881038EE
	for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2008 21:35:32 +0100 (CET)
Received: from h01.hostsharing.net (h01.hostsharing.net [212.42.230.152])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtpout.hostsharing.net (Postfix) with ESMTP id 33A4B2000065
	for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2008 21:35:27 +0100 (CET)
Received: from mail.home.lxtec.de (p5B14522D.dip.t-dialin.net [91.20.82.45])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by h01.hostsharing.net (Postfix) with ESMTP id 03B2418119D9D
	for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2008 21:35:27 +0100 (CET)
Received: from localhost ([127.0.0.1])
	by mail.home.lxtec.de with esmtp (Exim 4.69 1 (LXTEC))
	id 1JOfN7-000186-VV
	for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2008 21:35:25 +0100
Received: from mail.home.lxtec.de ([127.0.0.1])
	by localhost (mail.home.lxtec.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E1zkpIS04lsF for <alsa-devel@alsa-project.org>;
	Mon, 11 Feb 2008 21:35:23 +0100 (CET)
Received: from aragorn.home.lxtec.de ([192.168.200.203] ident=Debian-exim)
	by mail.home.lxtec.de with esmtps (Exim 4.69 1 (LXTEC))
	id 1JOfN5-00017v-DL
	for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2008 21:35:23 +0100
Content-Disposition: inline
In-Reply-To: <s5h1w7jwn3b.wl%tiwai@suse.de>
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

On Mon, 11 Feb 2008 the mental interface of
Takashi Iwai told:

[...]
> Is this a regression after the version update?  If yes, try to set the
> environment variable LIBASOUND_DEBUG=1.  This will give you more
> verbose debug messages regarding parameter setting.

Found a miss configured compile option. Sorry for the noise :)

Elimar

-- 
  Do you smell something burning or ist it me?
