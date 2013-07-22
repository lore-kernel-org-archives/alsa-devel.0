From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH 1/6] ASoC: sirf: add sirf platform driver
	which provides DMA
Date: Mon, 22 Jul 2013 08:06:55 +0800
Message-ID: <CAGsJ_4yJoYJdRjZiVOPYgOA+kxGyU9eKjWQFK1B_AnQ6-7BDjg@mail.gmail.com>
References: <1374232042-26088-1-git-send-email-Baohua.Song@csr.com>
 <1374232042-26088-2-git-send-email-Baohua.Song@csr.com>
 <20130719161252.GK9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f176.google.com (mail-qc0-f176.google.com
 [209.85.216.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 979CE261661
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2013 02:07:16 +0200 (CEST)
Received: by mail-qc0-f176.google.com with SMTP id z10so3278750qcx.7
 for <alsa-devel@alsa-project.org>; Sun, 21 Jul 2013 17:07:15 -0700 (PDT)
In-Reply-To: <20130719161252.GK9858@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, Workgroup.Linux@csr.com, Rongjun Ying <Rongjun.Ying@csr.com>, Barry Song <Baohua.Song@csr.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

2013/7/20 Mark Brown <broonie@kernel.org>:
> On Fri, Jul 19, 2013 at 07:07:17PM +0800, Barry Song wrote:
>
>> index 0000000..3678aed
>> --- /dev/null
>> +++ b/sound/soc/sirf/Kconfig
>> @@ -0,0 +1,4 @@
>> +config SND_SIRF_SOC
>> +     tristate "Platform DMA driver for the SiRF SoC chips"
>> +     depends on ARCH_SIRF && SND_SOC
>> +     select SND_SOC_DMAENGINE_PCM
>
> Does this have any actual platform build dependencies or can this be
> ARCH_SIRF || COMPILE_TEST?

it depends on SIRF as it is specific to SiRFSoC, but i think it would
be good to have " || COMPILE_TEST"

-barry
