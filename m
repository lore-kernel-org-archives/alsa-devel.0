From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Headset VMID ramp fix
Date: Fri, 8 May 2009 17:23:22 +0300
Message-ID: <20090508172322.53be8d2c.jhnikula@gmail.com>
References: <1241763077-6851-1-git-send-email-peter.ujfalusi@nokia.com>
	<1241763077-6851-2-git-send-email-peter.ujfalusi@nokia.com>
	<20090508094044.0c85e86a.jhnikula@gmail.com>
	<200905081456.50445.peter.ujfalusi@nokia.com>
	<20090508165501.954a61e7.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f175.google.com (mail-ew0-f175.google.com
	[209.85.219.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 650FA1038F2
	for <alsa-devel@alsa-project.org>;
	Fri,  8 May 2009 16:21:56 +0200 (CEST)
Received: by ewy23 with SMTP id 23so2091662ewy.32
	for <alsa-devel@alsa-project.org>; Fri, 08 May 2009 07:21:55 -0700 (PDT)
In-Reply-To: <20090508165501.954a61e7.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "anuj.aggarwal@ti.com" <anuj.aggarwal@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "getarunks@gmail.com" <getarunks@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 8 May 2009 16:55:01 +0300
Jarkko Nikula <jhnikula@gmail.com> wrote:

> Would it be possible that pop is not caused by the HS output but
> inside the chip, like from DAC?
> 
Seems to be not the case. Pops are there even if I put msleep(250)
before and after playing with the HS.

A digital scope would definitely help here to see are there ramp and is
the coupling configuration correct.


-- 
Jarkko
