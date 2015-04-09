From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: Intel: do cast earlier in
	sst_cdev_tstamp()
Date: Thu, 9 Apr 2015 12:02:39 +0300
Message-ID: <20150409090239.GA17605@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 27BBD2651D2
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2015 11:02:57 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

My static checker complains about these because it looks like the
multiply can overflow and then we cast to a larger data type.  I don't
think this is a problem, but it's also harmless to do the cast earlier
so let's silence the static checker warning.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/intel/atom/sst/sst_drv_interface.c b/sound/soc/intel/atom/sst/sst_drv_interface.c
index 718838b..7b50a9d 100644
--- a/sound/soc/intel/atom/sst/sst_drv_interface.c
+++ b/sound/soc/intel/atom/sst/sst_drv_interface.c
@@ -381,7 +381,7 @@ static int sst_cdev_tstamp(struct device *dev, unsigned int str_id,
 	tstamp->copied_total = fw_tstamp.ring_buffer_counter;
 	tstamp->pcm_frames = fw_tstamp.frames_decoded;
 	tstamp->pcm_io_frames = div_u64(fw_tstamp.hardware_counter,
-			(u64)((stream->num_ch) * SST_GET_BYTES_PER_SAMPLE(24)));
+			(u64)stream->num_ch * SST_GET_BYTES_PER_SAMPLE(24));
 	tstamp->sampling_rate = fw_tstamp.sampling_frequency;
 
 	dev_dbg(dev, "PCM  = %u\n", tstamp->pcm_io_frames);
