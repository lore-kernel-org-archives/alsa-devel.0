From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] [v3] ASoC: cs4270: use the built-in
	register cache support
Date: Mon, 10 Jan 2011 16:37:43 -0600
Message-ID: <4D2B8A37.5070900@freescale.com>
References: <1294687713-16433-1-git-send-email-timur@freescale.com>
	<20110110223400.GE5886@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe001.messaging.microsoft.com
	[65.55.88.11]) by alsa0.perex.cz (Postfix) with ESMTP id 86919103944
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 23:39:21 +0100 (CET)
In-Reply-To: <20110110223400.GE5886@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: dp@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
>> > Mark, I don't have power-management support working on my hardware, so I can't
>> > test cs4270_soc_resume(), but I have a suspicion that the call to
>> > i2c_smbus_write_byte_data() should be replaced with codec->hw_write().
> Like Liam said snd_soc_cache_sync() is probably what you're looking for
> here.

Unfortunately, since I can't test any power management stuff on the 8610, I
can't test any changes.  I have to rely on the author of power management code
to do that.

-- 
Timur Tabi
Linux kernel developer at Freescale
