From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 1/7] sound: Replace timespec with timespec64
Date: Thu, 21 Sep 2017 12:02:20 +0200
Message-ID: <CAK8P3a0FJ3HV7-HJqG+kO_pVs5CQTj7o=U9spoGeDW0HK2+FfQ@mail.gmail.com>
References: <cover.1505973912.git.baolin.wang@linaro.org> <5ebd5e37e8f1bf2675996cf56538179b743bc95b.1505973912.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5ebd5e37e8f1bf2675996cf56538179b743bc95b.1505973912.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Ingo Molnar <mingo@kernel.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, SF Markus Elfring <elfring@users.sourceforge.net>, Dan Carpenter <dan.carpenter@oracle.com>, jeeja.kp@intel.com, Vinod Koul <vinod.koul@intel.com>, dharageswari.r@intel.com, guneshwor.o.singh@intel.com, Bhumika Goyal <bhumirks@gmail.com>, gudishax.kranthikumar@intel.com, Naveen M <naveen.m@intel.com>, hardik.t.shah@intel.com, Arvind Yadav <arvind.yadav.cs@gmail.com>, fabf@skynet.be, Mark Brown <broonie@kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 21, 2017 at 8:18 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
> Since timespec is not year 2038 safe on 32bit system, and we need to
> convert all timespec variables to timespec64 type for sound subsystem.
>
> This patch is used to do preparation for following patches, that will
> convert all structures defined in uapi/sound/asound.h to use 64-bit
> time_t.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Looks good to me. This could perhaps be split up further, but it
seems small enough to get merged as a single patch.

     Arnd
