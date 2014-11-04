From: Qais Yousef <qais.yousef@imgtec.com>
Subject: [RFC] AXD Audio Processing IP ALSA support - Questions
Date: Tue, 4 Nov 2014 09:48:18 +0000
Message-ID: <5458A0E2.4010602@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 02A4E260684
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 10:48:21 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Vinod Koul <vinod.koul@intel.com>, Neil Jones <neil.jones@imgtec.com>, Lars-Peter Clausen <lars@metafoo.de>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Hi,

I have several questions on the best way to add AXD support in ALSA.

The discussion of the previous patch can be found here:

https://lkml.org/lkml/2014/10/28/465

Questions:

1- What is the best example to follow to add a simple mp3 support for 
AXD? The only one I find is in sst-mfld-platform-compress.c in 
sound/soc/intel directory but it's a bit confusing. I think because it's 
sharing code with several other sst drivers/platforms.

I find the documentation for compress_offload generally lacking. Is 
there a plan to improve on that? Being a new comer to ALSA framework 
api, I'm confused what is the correct way to do things :-/

So far I know I need to call snd_soc_register_card(). I thought 
snd_compress_register() (from compress_driver.h) is how you add 
compressed nodes to the card but apparently not. It looks like I need to 
define a compress_dai? Hmmm.

2- Is tinycompress the only userland support for compress_offload? Is 
there anyone working on gstreamer and omx plugins to support that?

Would tinycompress be part of alsa-utils and alsa-libs in the future? I 
know it needs more work at the moment but it'd be nice if 
compress_offload support is part of the standard alsa-utils and alsa-libs.

3- Can we get an example of how transcoding (back to disk) is supposed 
to be working?

4- How can we reconfigure complex audio effect components (like shelving 
filters) which need filter co-effecient changes to be applied all at 
once atomically to avoid instability?

My plan is to add mp3 driver first then build on that to add the rest of 
the features. Hopefully I can minimise the amount of work that needs 
doing (due to me doing it wrongly) and get features upstream sooner.

Thanks,
Qais
