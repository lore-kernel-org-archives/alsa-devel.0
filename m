From: Carlo Caione <carlo@endlessm.com>
Subject: Re: [asoc:topic/intel 41/42]
 sound/soc/intel/boards/bytcr_rt5651.c:325:2: error: implicit declaration of
 function 'rt5651_set_jack_detect'
Date: Fri, 27 Oct 2017 09:48:06 +0100
Message-ID: <CAL9uMOFjwVX21wRJ8Ze+fv2YAv3Cq+njf37kAV1OnwAcf3WvHA@mail.gmail.com>
References: <201710270442.UI1o2xEl%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f196.google.com (mail-ua0-f196.google.com
 [209.85.217.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DC3B267456
 for <alsa-devel@alsa-project.org>; Fri, 27 Oct 2017 10:48:07 +0200 (CEST)
Received: by mail-ua0-f196.google.com with SMTP id z4so4365290uaz.5
 for <alsa-devel@alsa-project.org>; Fri, 27 Oct 2017 01:48:07 -0700 (PDT)
In-Reply-To: <201710270442.UI1o2xEl%fengguang.wu@intel.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 26, 2017 at 9:21 PM, kbuild test robot
<fengguang.wu@intel.com> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/intel
> head:   2fe30129b0a6a8ddf71c46c8fb4524cb89739bc0
> commit: d9f8f9b2f3e2b95875cd59ae5c3276e4662e7513 [41/42] ASoC: intel: byt: Add headset jack
> config: i386-allmodconfig (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         git checkout d9f8f9b2f3e2b95875cd59ae5c3276e4662e7513
>         # save the attached .config to linux build tree
>         make ARCH=i386
>
> All errors (new ones prefixed by >>):
>
>    sound/soc/intel/boards/bytcr_rt5651.c: In function 'byt_rt5651_init':
>>> sound/soc/intel/boards/bytcr_rt5651.c:325:2: error: implicit declaration of function 'rt5651_set_jack_detect' [-Werror=implicit-function-declaration]
>      rt5651_set_jack_detect(codec, &priv->jack);
>      ^~~~~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors

Hey Mark,
should I ignore this? It looks like the kbuild robot is angry for the
missing declaration that is added in a different commit on a different
merging branch.

-- 
Carlo Caione
