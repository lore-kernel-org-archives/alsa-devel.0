From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Audio Mini Summit 2015, 8th October, Dublin
Date: Mon, 12 Oct 2015 18:21:22 +0200
Message-ID: <561BDE02.9070709@perex.cz>
References: <20151004231752.GA22609@sirena.org.uk>
 <20151007152047.GQ12635@sirena.org.uk> <561679FE.3060809@metafoo.de>
 <56167DBF.9090106@metafoo.de> <5617C133.1080006@metafoo.de>
 <s5hlhb8lbi7.wl-tiwai@suse.de> <561BD7BB.2090200@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id B06D62625EE
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2015 18:21:22 +0200 (CEST)
Received: from server.perex-int.cz (server.perex-srv.cz [172.16.0.20])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 90F0B149F34
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2015 18:21:22 +0200 (CEST)
Received: from t510.perex-int.cz (localhost [127.0.0.1])
 by server.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id
 662EB8518A
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2015 18:21:22 +0200 (CEST)
In-Reply-To: <561BD7BB.2090200@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 12.10.2015 v 17:54 Lars-Peter Clausen napsal(a):

> E.g. I'd consider parameter refining a vital part of ALSA and the core
> functionality of it is rather compact. But it provides a lot of helper
> functions of which only some are going to be used if you built a reduced
> kernel. So rather then completely disabling parameter refining use LTO to
> remove the unused helper functions.

I agree. It sounds like perfect solution for optimized kernel builds.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
