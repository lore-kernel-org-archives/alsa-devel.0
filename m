From: bgoswami@codeaurora.org
Subject: Query regarding possibility of PM QoS unvote/vote when
 substream Pause/Resume called
Date: Wed, 21 Jun 2017 10:58:24 -0700
Message-ID: <d5d9ba80a37f6216ab93391313c9b22d@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id B8C972664EB
 for <alsa-devel@alsa-project.org>; Wed, 21 Jun 2017 19:58:26 +0200 (CEST)
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

   Current ALSA core implementation has PM QoS vote/unvote calls in 
snd_pcm_hw_params() and snd_pcm_hw_free().

  However, this might have an implication in terms of power, as PM QoS 
vote would still be valid for that substream, even when the substream is 
paused. Especially for those cases, where, to avoid missing the QoS, one 
or more CPU cores might be prevented from entering into lower power mode 
(or power-collapse), as it might take longer to bring those cores out of 
power collapse. This might be specially more prominent when the period 
size is smaller.

   So, in an effort to optimize power (by whatever smaller amount), I was 
wondering, if it is better to remove the PM QoS vote 
(pm_qos_remove_request) when Pause (SNDRV_PCM_TRIGGER_PAUSE_PUSH) is 
called from user space (using IOCTL) for a particular substream.
  Similarly, PM QoS vote can be added (pm_qos_add_request) back, when 
user space (using IOCTL) calls Resume (SNDRV_PCM_TRIGGER_PAUSE_RELEASE) 
for that same substream.

  I am looking for opinions from subject matter experts, to see if the 
proposed approach might have any unintended side-effects or any known 
limitation that I might be missing.


Thanks and Regards,
Banajit Goswami

The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
