From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] ASoC: Intel: Skylake: Uninitialized variable
	in probe_codec()
Date: Thu, 20 Apr 2017 13:17:02 +0300
Message-ID: <20170420101702.nlq3537xumrseu26@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id E904D2666EC
 for <alsa-devel@alsa-project.org>; Thu, 20 Apr 2017 12:17:23 +0200 (CEST)
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
To: Liam Girdwood <lgirdwood@gmail.com>, Jeeja KP <jeeja.kp@intel.com>
Cc: alsa-devel@alsa-project.org, Dharageswari R <dharageswari.r@intel.com>, Lukas Wunner <lukas@wunner.de>, Vinod Koul <vinod.koul@intel.com>, Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>, Jayachandran B <jayachandran.b@intel.com>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Yong Zhi <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org

My static checker complains that if snd_hdac_bus_get_response() returns
-EIO then "res" is uninitialized.  Fix this by initializing it to -1 so
that the error is handled correctly.

Fixes: d8c2dab8381d ("ASoC: Intel: Add Skylake HDA audio driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 0c57d4eaae3a..6df3b317a476 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -512,7 +512,7 @@ static int probe_codec(struct hdac_ext_bus *ebus, int addr)
 	struct hdac_bus *bus = ebus_to_hbus(ebus);
 	unsigned int cmd = (addr << 28) | (AC_NODE_ROOT << 20) |
 		(AC_VERB_PARAMETERS << 8) | AC_PAR_VENDOR_ID;
-	unsigned int res;
+	unsigned int res = -1;
 
 	mutex_lock(&bus->cmd_mutex);
 	snd_hdac_bus_send_cmd(bus, cmd);
