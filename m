From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [REPOST] opti93x: conversion to use cs4231 library
Date: Wed, 30 Jan 2008 01:43:02 +0100
Message-ID: <479FC816.5060405@keyaccess.nl>
References: <20080126104411.50c2035f.krzysztof.h1@poczta.fm>
	<s5hd4rl6f4h.wl%tiwai@suse.de> <479E804E.7070500@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F03110393D
	for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2008 01:42:35 +0100 (CET)
In-Reply-To: <479E804E.7070500@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel <alsa-devel@alsa-project.org>, Krzysztof Helt <krzysztof.h1@poczta.fm>
List-Id: alsa-devel@alsa-project.org

On 29-01-08 02:24, Rene Herman wrote:

> Needs this additionally to compile (against 2.6.24 at least, but this is 
> normally always required). Will test tomorrow.

931 and 933 work and 930 (a non-PnP chip) is being a royal pain in the ass 
again. With the new code, I haven't yet been able to get it to work -- no 
IRQ is firing. However, I also experienced this _once_ with the old driver 
so I'm not sure what's going on. When I now try to reproduce with the old 
one, I can't. Maybe a timing difference.

Will need further testing -- I have no time in the next few days.

Rene.
