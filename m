Return-Path: <SRS0=uo8V=AL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C955C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Jun 2020 00:24:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02C4920781
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Jun 2020 00:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aLChd2Tz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C4920781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6E07B84C;
	Tue, 30 Jun 2020 02:23:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6E07B84C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593476675;
	bh=IwfVoihKiCPtKEr9iEuOX2nY9fGeyH6z2ZPlid8nSo0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aLChd2TzItKk3lG+ibHxiAiWUocy+w9ZeiqPgTAb5QU+NsLRrLd2y6FUlWLQoHQR1
	 7NHK1CSu8m8BkHJc3cJhXyZqU9EuabvQcpWA+cBpCo03yN8FilHfscgkV3CZ2ncJL8
	 +3FodJzD2AWyncGo2oOe9VNGIac4BFCp9QlFuAeU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 028BCF8020C;
	Tue, 30 Jun 2020 02:23:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A633AF80217; Tue, 30 Jun 2020 02:23:43 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 35A03F800BA
 for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2020 02:23:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 35A03F800BA
IronPort-SDR: WV1Bjmaycp/b3kGjDEppUbvY1ZjsioEJ4vM0Fw45PaOV3rlhUvDIZVVoXU9r6RmJfvmsz7b853
 ucPfVQT/YwwQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="126237163"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; d="scan'208";a="126237163"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2020 17:23:30 -0700
IronPort-SDR: bMskWNo2Ka9qzWD8not8UvRsMkfnaDFWxRTCIXQojHgCptZgDcijIB/fWmMP2HiUmJjkISGLtk
 g9Un35mB2baw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; d="scan'208";a="386540984"
Received: from joycetoh-desk.sc.intel.com ([172.25.206.187])
 by fmsmga001.fm.intel.com with ESMTP; 29 Jun 2020 17:23:30 -0700
From: Harsha Priya <harshapriya.n@intel.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de
Subject: [PATCH v2] ALSA: hda/hdmi: Add Intel silent stream support
Date: Mon, 29 Jun 2020 17:23:26 -0700
Message-Id: <1593476606-24147-1-git-send-email-harshapriya.n@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: kai.vehmanen@intel.com, Harsha Priya <harshapriya.n@intel.com>,
 Emmanuel Jillela <emmanuel.jillela@intel.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

External HDMI receivers have analog circuitry that needs to be powered-on
when exiting standby, and a mechanism to detect PCM v. IEC61937 data.
These two steps take time and up to 2-3 seconds of audio may be muted
when starting playback.

Intel hardware can keep the link active with a 'silent stream', so that
the receiver does not go through those two steps when valid audio is
transmitted. This mechanism relies on an info packet and preventing the
codec from going to D3, which will increase the platform static power
consumption. The info packet assumes a basic 2ch stereo, and the silent
stream is enabled when connecting a monitor. In case of format changes the
detection of PCM v. IEC61937 needs to be re-run. In this case there is no
way to avoid the 2-3s mute.

The silent stream is enabled with a Kconfig option, as well as a kernel
parameter should there be a need to override the build time default.
This approach is used based on the power_save capability as an example,
but in the future, it may be used with a kcontrol, depending on
UCM support for HDaudio legacy.

Silent stream is supported in Intel platforms Skylake and beyond.
Tested HDMI plug-out plug-in from Intel Cometlake based Chromebook
connected to few different monitors.

Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Signed-off-by: Emmanuel Jillela <emmanuel.jillela@intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
Change History:

v2:
- Kconfig symbol depends on SND_HDA_INTEL.
- Added valid eld check to along side of silent stream enable check,
  under which silent stream is enabled.
- Error prints added for codec power up, power down functions.
- The silent stream is enabled with a Kconfig/module parameter
  following the power_save capability as an example. But in the future,
  it may be used with a kcontrol, depending on UCM support for HDaudio legacy.

v1:
- Initial version.

 sound/pci/hda/Kconfig      | 16 ++++++++++++++
 sound/pci/hda/patch_hdmi.c | 45 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 7ba542e45a3d..1c4758d58fc3 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -232,4 +232,20 @@ config SND_HDA_POWER_SAVE_DEFAULT
 
 endif
 
+config SND_HDA_INTEL_HDMI_SILENT_STREAM
+	bool "Enable Silent Stream always for HDMI"
+	depends on SND_HDA_INTEL
+	help
+	  Intel hardware has a feature called 'silent stream', that
+	  keeps external HDMI receiver's analog circuitry powered on
+	  avoiding 2-3 sec silence during playback start. This mechanism
+	  relies on an info packet and preventing the codec from going to
+	  D3. (increasing the platform static power consumption when a
+	  HDMI receiver is plugged-in). 2-3 sec silence at the playback
+	  start is expected whenever there is format change. (default is
+	  2 channel format).
+	  Say Y to enable Silent Stream feature.
+
+endif
+
 endmenu
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index fbd7cc6026d8..68b81ea176c6 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -42,6 +42,11 @@ static bool enable_acomp = true;
 module_param(enable_acomp, bool, 0444);
 MODULE_PARM_DESC(enable_acomp, "Enable audio component binding (default=yes)");
 
+static bool enable_silent_stream =
+IS_ENABLED(CONFIG_SND_HDA_INTEL_HDMI_SILENT_STREAM);
+module_param(enable_silent_stream, bool, 0644);
+MODULE_PARM_DESC(enable_silent_stream, "Enable Silent Stream for HDMI devices");
+
 struct hdmi_spec_per_cvt {
 	hda_nid_t cvt_nid;
 	int assigned;
@@ -1634,21 +1639,61 @@ static void hdmi_present_sense_via_verbs(struct hdmi_spec_per_pin *per_pin,
 	snd_hda_power_down_pm(codec);
 }
 
+static void silent_stream_enable(struct hda_codec *codec,
+			struct hdmi_spec_per_pin *per_pin)
+{
+	codec_dbg(codec, "hdmi: enabling silent stream for NID %d\n",
+			per_pin->pin_nid);
+
+	mutex_lock(&per_pin->lock);
+	if (!per_pin->channels)
+		per_pin->channels = 2;
+	hdmi_setup_audio_infoframe(codec, per_pin, per_pin->non_pcm);
+	mutex_unlock(&per_pin->lock);
+}
+
 /* update ELD and jack state via audio component */
 static void sync_eld_via_acomp(struct hda_codec *codec,
 			       struct hdmi_spec_per_pin *per_pin)
 {
 	struct hdmi_spec *spec = codec->spec;
 	struct hdmi_eld *eld = &spec->temp_eld;
+	bool monitor_prev, monitor_next;
 
 	mutex_lock(&per_pin->lock);
 	eld->monitor_present = false;
+	monitor_prev = per_pin->sink_eld.monitor_present;
 	eld->eld_size = snd_hdac_acomp_get_eld(&codec->core, per_pin->pin_nid,
 				      per_pin->dev_id, &eld->monitor_present,
 				      eld->eld_buffer, ELD_MAX_SIZE);
 	eld->eld_valid = (eld->eld_size > 0);
 	update_eld(codec, per_pin, eld, 0);
+	monitor_next = per_pin->sink_eld.monitor_present;
 	mutex_unlock(&per_pin->lock);
+
+	/*
+	 * Power-up will call hdmi_present_sense, so the PM calls
+	 * have to be done without mutex held.
+	 */
+
+	if (enable_silent_stream && eld->eld_valid) {
+		int pm_ret;
+
+		if (!monitor_prev && monitor_next && eld->eld_valid) {
+			pm_ret = snd_hda_power_up_pm(codec);
+			if (pm_ret < 0)
+				codec_err(codec,
+				"Monitor plugged-in, Failed to power up codec ret=[%d]\n",
+				pm_ret);
+			silent_stream_enable(codec, per_pin);
+		} else if (monitor_prev && !monitor_next && !eld->eld_valid) {
+			pm_ret = snd_hda_power_down_pm(codec);
+			if (pm_ret < 0)
+				codec_err(codec,
+				"Monitor plugged-out, Failed to power down codec ret=[%d]\n",
+				pm_ret);
+		}
+	}
 }
 
 static void hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
-- 
2.17.1

