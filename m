From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH 2/3] ASoC: DaVinci: pcm,
 rename variables in prep for ping/pong
Date: Tue, 29 Sep 2009 15:09:12 -0700
Message-ID: <4AC28588.9030802@boundarydevices.com>
References: <1251761505-11353-1-git-send-email-troy.kisky@boundarydevices.com>	<1251761505-11353-2-git-send-email-troy.kisky@boundarydevices.com>	<20090902220152.GB4495@sirena.org.uk>	<4A9F0A8C.1040509@boundarydevices.com>	<B85A65D85D7EB246BE421B3FB0FBB59301DD6102A3@dbde02.ent.ti.com>	<4AA0113D.9030605@boundarydevices.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DD74F519@dbde02.ent.ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DDAB3EB5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth00.csee.onr.siteprotect.com
	(smtpauth00.csee.onr.siteprotect.com [64.26.60.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 7EC00103823
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Sep 2009 00:09:29 +0200 (CEST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DDAB3EB5@dbde02.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Nori, Sekhar" <nsekhar@ti.com>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> 
> Troy, do you have any theory yet on why your patch should permanently swap
> channels?
> 
Memory in 16 bit samples
L1,R1,L2,R2

Shifting out in 16 bit samples
L1,R1,L2,R2


Memory in 32 bit samples
R1L1,R2L2,R3L3

Shifting out in 32 bit samples
R1L1,R2L2

Codec sees 16 bit samples
R1,L1,R2,L2
