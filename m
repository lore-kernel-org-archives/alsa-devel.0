From: Raffaele Recalcati <lamiaposta71@gmail.com>
Subject: ASoC: Davinci Voice codec compliant to arago kernel
	for dm365
Date: Fri, 16 Jul 2010 11:47:17 +0200
Message-ID: <AANLkTikCvdLdcKP3J_djiTqUUQM3MOEh+3QHVFo6r8Fk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id DDEAB24431
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Jul 2010 11:47:18 +0200 (CEST)
Received: by iwn39 with SMTP id 39so2017919iwn.38
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2010 02:47:18 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Cc: alsa-devel@alsa-project.org, arago-devel@gforge.ti.com
List-Id: alsa-devel@alsa-project.org

Hi Miguel,
I've used successfully the patches below on top of 2.6.34 Kevin Hilman
kernel for davinci
http://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-davinci.git

Now I need to backport your patches to arago kernel
http://arago-project.org/git/projects/linux-davinci.git
that means 2.6.32-rc1
I use able adapt your patches to it, but I guess that there are many changes
from 2.6.32-rc1 to 2.6.34 ...
Can you tell me what is the best thing to do?
I'm afraid you'll tell me that I need to rewrite completely your patches to
be really compliant to 2.6.32-rc1.

Here you are a not working log:
aplay tone1KHzMono_8000.wav
Playing WAVE 'tone1KHzMono_8000.wav' : Signed 16 bit Little Endian, Rate
8000 Hz, Mono
davinci_pcm_prepare - 203
davinci_pcm_enqueue_dma - 77: period=2000,dma_offset=0,dma_pos=-2044854272

davinci_pcm: audio_set_dma_params_play channel = 79 dma_ptr = 861e0000
period_size=7d0
davinci_pcm_enqueue_dma - 84: data_type=0
davinci_pcm_enqueue_dma - 77:
period=2000,dma_offset=2000,dma_pos=-2044852272
davinci_pcm: audio_set_dma_params_play channel = 79 dma_ptr = 861e07d0
period_size=7d0
davinci_pcm_enqueue_dma - 84: data_type=0
aplay: pcm_write:1528: write error: Input/output error
Thanks,
Raffaele


---------------

Author: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Date:   Thu Mar 11 09:32:21 2010 -0600

    MFD: DaVinci Voice Codec

    This is the MFD driver for the DaVinci Voice codec, it has two clients:

    * Voice codec interface
    * Voice codec CQ93VC

    Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>
    Acked-by: Samuel Ortiz <sameo@linux.intel.com>
    Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
    Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

commit 94a532f7156582ec7459f21baa4de6665773974a
Author: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Date:   Thu Mar 11 09:32:59 2010 -0600

    ASoC: DaVinci: CQ93VC Voice Codec

    Currently the DM365 is the only SoC that includes this Voice Codec.

    Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>
    Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
    Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

commit 80a6609eeb0995732318c7ab672767e39a111f3b
Author: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Date:   Thu Mar 11 09:32:42 2010 -0600

    ASoC: DaVinci: Voice Codec Interface

    This patch adds the support for the interface needed by the DaVinci
    Voice Codec CQ93VC.

    Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>
    Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
    Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>




-- 
www.opensurf.it
