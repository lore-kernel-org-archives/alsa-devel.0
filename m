From: phaniu@codeaurora.org
Subject: ALSA Core: Sound Card registration (CPU --> CODEC_1
	--> CODEC_2)
Date: Wed, 3 Sep 2014 21:56:23 -0000
Message-ID: <097246a95335e0f482317cf23d598cf7.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.11.231])
 by alsa0.perex.cz (Postfix) with ESMTP id A598626578D
 for <alsa-devel@alsa-project.org>; Wed,  3 Sep 2014 23:56:26 +0200 (CEST)
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
Cc: plai@codeaurora.org
List-Id: alsa-devel@alsa-project.org

Hi,

We have a question regarding how sound card can be registered for the
following scenario:

CPU connecting to Audio CODEC_1 and then CODEC_1 connecting to another
Audio CODEC_2 (over some bus like i2c). CODEC_1 can be represented as a
codec_dai and can be registered to ASoC framework (with
snd_soc_register_codec()) during system boot up. However, for end-to-end
audio to work on this system, we also need CODEC_2 somehow registered to
ASoC framework so that audio path on CODEC_2 can configured.

Could you please let us know if CODEC_2 can also registered as another dai
and if yes, how it can be achieved ? Or is there any other way to
probe_defer sound card registration till CODEC_2 is enumerated on the bus.
In this case, to what component of the sound card dailink structure, the
Audio CODEC_2 can be represented ?

Please share your thoughts on this.

Best Regards,
Phani

The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
