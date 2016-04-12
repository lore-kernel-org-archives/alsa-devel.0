From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 05/11] ASoC: hdac_hdmi: Add multichannel
 support
Date: Tue, 12 Apr 2016 07:25:33 -0500
Message-ID: <570CE93D.6000109@linux.intel.com>
References: <1460437293-8509-1-git-send-email-subhransu.s.prusty@intel.com>
 <1460437293-8509-6-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 91A8C265158
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 14:25:37 +0200 (CEST)
In-Reply-To: <1460437293-8509-6-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, lgirdwood@gmail.com, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org


  
-	/* Only stereo supported as of now */
-	cvt->params.channels_min = cvt->params.channels_max = 2;
+	chans = get_wcaps(hdac, cvt->nid);
+	chans = get_wcaps_channels(chans);
+
+	cvt->params.channels_min = 2;
+
+	if (chans <= 16) {
+		cvt->params.channels_max = chans;
+		if (chans > hdmi->chmap.channels_max)
+			hdmi->chmap.channels_max = chans;
+	}t


Are you sure about this? HDMI can only handle 8 channels in Layout 2. 
There's no support for 16 ch.
