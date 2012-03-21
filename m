From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 3/3] ASoC: omap-mcbsp: Add period size
	protection mode
Date: Wed, 21 Mar 2012 10:32:11 +0200
Message-ID: <4F69920B.4010701@bitmer.com>
References: <1332242021-7494-1-git-send-email-peter.ujfalusi@ti.com>
	<1332242021-7494-4-git-send-email-peter.ujfalusi@ti.com>
	<4F68AE51.808@bitmer.com> <4F698B56.6030502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 87C64104408
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2012 09:32:14 +0100 (CET)
In-Reply-To: <4F698B56.6030502@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/21/2012 10:03 AM, Peter Ujfalusi wrote:
> On 03/20/2012 06:20 PM, Jarkko Nikula wrote:
>> I don't think this is going to solve the actual problem here where
>> custom asound.conf was required.
> 
> I also suggested to use custom asound.conf. For Pandora it does exist,
> but the argument was that it need to be specifically created/copied to
> any new OS being ported to the HW.
> 
>> IMHO custom sysfs is even worse option and very hard to remove afterwards.
> 
> Well, for system integration's point of view I would prefer the sysfs
> file. If this is needed by the distribution/use case it can be enabled,
> disabled in runtime. In my view it poses less hassle for distributions.
> 
Problem with custom sysfs is that no generic distribution is going to
use it but problem can be triggered there. IMHO for tailored
distribution point of view custom sysfs setting is no better than custom
asound.conf.

I'm half thinking shall we leave this broken if we cannot figure out any
automatic kernel based sulution to this?

-- 
Jarkko
