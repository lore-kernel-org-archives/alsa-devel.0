From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [kbuild-all] [asoc:topic/generic-dmaengine 1/1]
 sound/soc/soc-generic-dmaengine-pcm.c:435:5: error: 'struct dmaengine_pcm'
 has no member named 'component'
Date: Thu, 22 Feb 2018 11:03:54 -0300
Message-ID: <CAOMZO5BV34+qFPfztPnEfG7hUZmVRdkgvBK6_ZXZ3Q=gFa6KFA@mail.gmail.com>
References: <201802222109.jb3Hsy4Y%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
 [209.85.218.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 67575267736
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 15:03:57 +0100 (CET)
Received: by mail-oi0-f67.google.com with SMTP id a207so3744997oii.10
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 06:03:57 -0800 (PST)
In-Reply-To: <201802222109.jb3Hsy4Y%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 22, 2018 at 10:28 AM, kbuild test robot
<fengguang.wu@intel.com> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/generic-dmaengine
> head:   f0b3bdbd5c63c3f69f3b6a869355c676d22fd348
> commit: f0b3bdbd5c63c3f69f3b6a869355c676d22fd348 [1/1] ASoC: soc-generic-dmaengine-pcm: Add a DMA debugfs_prefix entry
> config: i386-randconfig-x004-201807 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         git checkout f0b3bdbd5c63c3f69f3b6a869355c676d22fd348
>         # save the attached .config to linux build tree
>         make ARCH=i386
>
> All errors (new ones prefixed by >>):
>
>    sound/soc/soc-generic-dmaengine-pcm.c: In function 'snd_dmaengine_pcm_register':
>>> sound/soc/soc-generic-dmaengine-pcm.c:435:5: error: 'struct dmaengine_pcm' has no member named 'component'
>      pcm->component.debugfs_prefix = "dma";

This error happens because topic/generic-dmaengine misses the following commit:

commit be7ee5f32a9a4eba881d18e85d58e9a03a9cca99
Author: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date:   Mon Jan 29 02:41:09 2018 +0000

    ASoC: soc-generic-dmaengine-pcm: replace platform to component

    Now platform can be replaced to component, let's do it.

    Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    Signed-off-by: Mark Brown <broonie@kernel.org>
