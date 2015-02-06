From: Barry Song <21cnbao@gmail.com>
Subject: Re: [alsa-devel] [PATCH baohua] ASoC: sirf: atlas7:
 atlas7_iacc_dai_ops can be static
Date: Fri, 6 Feb 2015 10:35:55 +0800
Message-ID: <CAGsJ_4wWfRse_Ba5Xx7y07v7RvbQZ9++W9z2w0VDeLjbenoqsQ@mail.gmail.com>
References: <201502060130.hszyNa1F%fengguang.wu@intel.com> <20150205170352.GA49811@snb>
 <20150205171159.GY21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150205171159.GY21293@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: kbuild test robot <fengguang.wu@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Rongjun Ying <rongjun.ying@csr.com>, kbuild-all@01.org, Barry Song <Barry.Song@csr.com>
List-Id: alsa-devel@alsa-project.org

2015-02-06 1:11 GMT+08:00 Mark Brown <broonie@kernel.org>:
> On Fri, Feb 06, 2015 at 01:03:52AM +0800, kbuild test robot wrote:
>> sound/soc/sirf/atlas7-iacc.c:168:24: sparse: symbol 'atlas7_iacc_dai_ops' was not declared. Should it be static?
>
> This file isn't in an upstream tree, should this patch have been sent
> upstream (I suspect non-upstream trees may need a bit of filtering in
> the scripts)?

the file is new and under developing. so no patch for it yet. is it
possible to modify kbuild script?

>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

-barry
