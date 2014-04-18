From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH] ASoC: cs42l51: Fix SOC_DOUBLE_R_SX_TLV
 shift values for ADC, PCM, and Analog kcontrols
Date: Fri, 18 Apr 2014 16:21:18 +0200
Message-ID: <20140418162118.1586ffd1@skate>
References: <1395243602-18012-1-git-send-email-brian.austin@cirrus.com>
 <20140417162625.21d072e7@skate>
 <alpine.DEB.2.02.1404171007510.9674@heelrod>
 <20140418112355.4c1fe3ac@skate>
 <alpine.DEB.2.02.1404180851570.9674@heelrod>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (top.free-electrons.com [176.31.233.9])
 by alsa0.perex.cz (Postfix) with ESMTP id 0003826089A
 for <alsa-devel@alsa-project.org>; Fri, 18 Apr 2014 16:21:20 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1404180851570.9674@heelrod>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, paul.handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org

Dear Brian Austin,

On Fri, 18 Apr 2014 09:00:35 -0500, Brian Austin wrote:

> My regmap output maps correctly too. Weird.

Indeed, weird. Thanks a lot for doing all this testing.

> So lets get a few versions of some things to see what and where things 
> went wrong.
> 
> What kernel version?

3.15-rc1

> Alsa-lib version?

1.0.26. This is not the latest, but certainly not that old either.

> What distro are you using?

Custom root filesystem built with Buildroot 2013.05.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
