Return-Path: <SRS0=RGWB=OY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC7EC433EF
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Oct 2021 22:56:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15F95613AC
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Oct 2021 22:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 15F95613AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D3E0F165E;
	Tue,  5 Oct 2021 00:55:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D3E0F165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633388163;
	bh=G/CPEwGPEc3GBs2RgLfQTwrLdwmrS+K/xXqoFUbO2pA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CHcHN/KS+H5DHbhWhpCGoTUTTz6U6fnt5cJHBItsw1C7RA687W5lbA7Rsxa/GNrhi
	 u1PUeXXa3bjLn7D4bwa4rJzZCuTGKA+H96Ity96of9k/yZWjTfN1I8MxJD+u5M3sMW
	 p1q96iCFrc3CmWkzPgm2g4c3alE6752tTYME+1JA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E23C9F8032D;
	Tue,  5 Oct 2021 00:55:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5AC71F80249; Tue,  5 Oct 2021 00:55:10 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9F8F3F80171
 for <alsa-devel@alsa-project.org>; Tue,  5 Oct 2021 00:55:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F8F3F80171
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="205727413"
X-IronPort-AV: E=Sophos;i="5.85,347,1624345200"; d="scan'208";a="205727413"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Oct 2021 15:54:59 -0700
X-IronPort-AV: E=Sophos;i="5.85,347,1624345200"; d="scan'208";a="559011846"
Received: from ksgonzal-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.181.38])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Oct 2021 15:54:57 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [RFC PATCH v2 0/5] ASoC: soc-pcm: fix trigger race conditions with
 shared BE
Date: Mon,  4 Oct 2021 17:54:36 -0500
Message-Id: <20211004225441.233375-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, tiwai@suse.de,
 Sameer Pujar <spujar@nvidia.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, Gyeongtaek Lee <gt82.lee@samsung.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
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

We've been adding a 'deep buffer' PCM device to several SOF topologies
in order to reduce power consumption. The typical use-case would be
music playback over a headset: this additional PCM device provides
more buffering and longer latencies, leaving the rest of the system
sleep for longer periods. Notifications and 'regular' low-latency
audio playback would still use the 'normal' PCM device and be mixed
with the 'deep buffer' before rendering on the headphone endpoint. The
tentative direction would be to expose this alternate device to
PulseAudio/PipeWire/CRAS via the UCM SectionModifier definitions.

That seemed a straightforward topology change until our automated
validation stress tests started reporting issues on SoundWire
platforms, when e.g. two START triggers might be send and conversely
the STOP trigger is never sent. The SoundWire stream state management
flagged inconsistent states when the two 'normal' and 'deep buffer'
devices are used concurrently with rapid play/stop/pause monkey
testing.

Looking at the soc-pcm.c code, it seems that the BE state
management needs a lot of love.

a) there is no consistent protection for the BE state. In some parts
of the code, the state updates are protected by a spinlock but in the
trigger they are not. When we open/play/close the two PCM devices in
stress tests, we end-up testing a state that is being modified. That
can't be good.

b) there is a conceptual deadlock: on stop we check the FE states to
see if a shared BE can be stopped, but since we trigger the BE first
the FE states have not been modified yet, so the TRIGGER_STOP is never
sent.

This patchset suggests a transition from a spinlock to a mutex, an
extended protection when walking through the BE list, and the use of a
refcount to decide when to trigger the BE. With these patches I am
able to run our entire validation suite without any issues with this
new 'deep buffer' topology, and no regressions on existing solutions [1]

One might ask 'how come we didn't see this earlier'? The answer is
probably that the .trigger callbacks in most implementations seems to
perform DAPM operations, and sending the triggers multiple times is
not an issue. In the case of SoundWire, we do use the .trigger
callback to reconfigure the bus using the 'bank switch' mechanism. It
could be acceptable to tolerate a trigger multiple times, but the
deadlock on stop cannot be fixed at the SoundWire layer alone.

I chose to send this patchset as an RFCv2 to gather more feedback and
make use others know about DPCM issues. We're going to spend more time
on this but if others can provide feedback/test results it would be
greatly appreciated.

Opens:

1) is this the right solution? The DPCM code is far from simple, has
notions such as SND_SOC_DPCM_UPDATE_NO and 'trigger_pending' that I
have no background on.

2) There are other reports of kernel oopses [2] that seem related to
the lack of protection. I'd be good to confirm if this patchset solve
these problems as well.

[1] https://github.com/thesofproject/linux/pull/3146
[2] https://lore.kernel.org/alsa-devel/002f01d7b4f5$c030f4a0$4092dde0$@samsung.com/

changes since RFC v1:
Removed unused function
Removed exported symbols only used in soc-pcm.c, used static instead
Use a mutex instead of a spinlock
Protect all for_each_dpcm_be() loops
Fix bugs introduced in the refcount

Pierre-Louis Bossart (5):
  ASoC: soc-pcm: remove snd_soc_dpcm_fe_can_update()
  ASoC: soc-pcm: don't export local functions, use static
  ASoC: soc-pcm: replace dpcm_lock with dpcm_mutex
  ASoC: soc-pcm: protect for_each_dpcm_be() loops with dpcm_mutex
  ASoC: soc-pcm: test refcount before triggering

 include/sound/soc-dpcm.h |  17 +----
 include/sound/soc.h      |   2 +-
 sound/soc/soc-core.c     |   2 +-
 sound/soc/soc-pcm.c      | 153 ++++++++++++++++++++++++++-------------
 4 files changed, 108 insertions(+), 66 deletions(-)

-- 
2.25.1

