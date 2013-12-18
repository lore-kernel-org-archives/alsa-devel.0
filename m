From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: mmp-pcm: config pcm slave via
 generic dmaengine
Date: Wed, 18 Dec 2013 11:14:36 +0100
Message-ID: <52B1758C.1020903@metafoo.de>
References: <1387268544-31222-1-git-send-email-zhouqiao@marvell.com>
 <20131217124954.GY3185@sirena.org.uk> <52B062EC.2050605@metafoo.de>
 <52B138CE.3000800@marvell.com> <52B167F4.1080806@metafoo.de>
 <20131218110318.GC28455@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-044.synserver.de (smtp-out-038.synserver.de
 [212.40.185.38])
 by alsa0.perex.cz (Postfix) with ESMTP id A2C5C261646
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2013 12:13:41 +0100 (CET)
In-Reply-To: <20131218110318.GC28455@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "haojian.zhuang@gmail.com" <haojian.zhuang@gmail.com>, Qiao Zhou <zhouqiao@marvell.com>, "zhangfei.gao@gmail.com" <zhangfei.gao@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 12/18/2013 12:03 PM, Mark Brown wrote:
> On Wed, Dec 18, 2013 at 10:16:36AM +0100, Lars-Peter Clausen wrote:
> 
>> +#ifdef CONFIG_CPU_MMP2
>> +	/*
>> +	 * Temporary hack until we have a generic gen_pool lookup
>> +	 * infrastructure.
>> +	 */
>> +	if (!pool)
>> +		pool = sram_get_gpool("asram");
>> +#endif
> 
> I worry about what this'd do on a multiplatform kernel - it seems
> unlikely that someone has a pool with the same name but that sounds like
> famous last words.  Nothing in mainline does though so...

The sram_get_gpool() function is mmp2 specific. It basically iterates a list
of available pools. Those pools are registered by mmp2 platform code. So on
a multiplatform kernel not booting mmp2 it will always return NULL since no
pools have been registered.

- Lars
