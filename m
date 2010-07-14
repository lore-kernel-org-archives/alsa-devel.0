From: David Henningsson <launchpad.web@epost.diwic.se>
Subject: Re: Which project to choose?
Date: Wed, 14 Jul 2010 17:06:25 +0200
Message-ID: <4C3DD271.6040003@epost.diwic.se>
References: <1279062131.24837.22.camel@localhost.localdomain>
	<AANLkTildhplqQxzk7mBMc5IW_3bwAVDDrRe5UDpJXIS6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch-smtp02.sth.basefarm.net (ch-smtp02.sth.basefarm.net
	[80.76.149.213]) by alsa0.perex.cz (Postfix) with ESMTP id 89C4B2413A
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Jul 2010 17:06:36 +0200 (CEST)
Received: from c83-254-141-16.bredband.comhem.se ([83.254.141.16]:40230
	helo=[192.168.8.103])
	by ch-smtp02.sth.basefarm.net with esmtp (Exim 4.68)
	(envelope-from <launchpad.web@epost.diwic.se>) id 1OZ3XY-0002HH-8D
	for alsa-devel@alsa-project.org; Wed, 14 Jul 2010 17:06:30 +0200
In-Reply-To: <AANLkTildhplqQxzk7mBMc5IW_3bwAVDDrRe5UDpJXIS6@mail.gmail.com>
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

2010-07-14 13:13, Raymond Yau skrev:

> localhost pulseaudio[24553]: alsa-util.c:   appl_ptr     : 735801008
> localhost pulseaudio[24553]: alsa-util.c:   hw_ptr       : 735846184
> 
> This is underrun as you can see appl_ptr is behing hw_ptr

Ehm, isn't that a ring buffer? I e, there is nothing wrong with appl_ptr
being less than hw_ptr.

> However PA server had disabled the underrun detection.

Please clarify. If you're talking about my patch (disable underruns in
alsa-plugins) here, it has nothing to do with this situation (PA
complaining about its back-end).

The situation above probably isn't even an underrun.

// David
