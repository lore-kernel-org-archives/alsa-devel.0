From: Mariusz Ceier <mceier+kernel@gmail.com>
Subject: [PATCH 0/1] sound/hda/hdac_stream: Avoid NULL pointer dereference
Date: Mon, 11 Mar 2019 21:53:56 +0100
Message-ID: <20190311205357.7573-1-mceier+kernel@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Ravindra Lokhande <rlokhande@nvidia.com>, Sameer Pujar <spujar@nvidia.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mohan Kumar D <mkumard@nvidia.com>, Keyon Jie <yang.jie@linux.intel.com>, Mariusz Ceier <mceier+kernel@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Seems like commit 9b6f7e7a296e17990aae298c809b001e99ddd151 introduced
NULL pointer dereference for ca0132 codec. 
When ca0132 loads firmware, snd_hdac_stream_start is called with
azx_dev->substream being NULL.

This patch calls snd_hdac_get_stream_stripe_ctl only when
azx_dev->substream is not NULL. Even if I'm not sure if this is correct,
since it might be that ca0132 codec does something wrong, with this
change NULL pointer dereference doesn't happen and ca0132 works again on
my system with Recon3Di.


Mariusz Ceier (1):
  sound/hda/hdac_stream: Avoid NULL pointer dereference

 sound/hda/hdac_stream.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.21.0
