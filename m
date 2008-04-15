From: Wolfgang Woehl <tito@rumford.de>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Tue, 15 Apr 2008 17:03:18 +0200
Message-ID: <200804151703.19003.tito@rumford.de>
References: <20080411204610.GA32413@tango.0pointer.de>
	<4800FC14.3060804@superbug.co.uk>
	<200804122025.57165.faber@faberman.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 229CD246E8
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Apr 2008 17:03:25 +0200 (CEST)
In-Reply-To: <200804122025.57165.faber@faberman.de>
Content-Disposition: inline
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

Florian Faber:

> To be honest, I think I would then insert a switch in the RME
> driver that will enable the outputs only after the RME mixer
> application has been started.

That is already the case, at least with the HDSP 9652 and the 
Multiface. No audio from RME gear until you run hdspmixer.
