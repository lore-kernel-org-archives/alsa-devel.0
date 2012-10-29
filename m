From: irfanks <irfan.shaikh@sasken.com>
Subject: snd_pcm_sw_params_set_start_threshold() functionality
Date: Mon, 29 Oct 2012 16:50:06 +0530
Message-ID: <508E6666.5080402@sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta-blr1.sasken.com (mta-blr1.sasken.com [203.200.200.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 2408D265302
 for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2012 12:20:09 +0100 (CET)
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
List-Id: alsa-devel@alsa-project.org

Hello,

             snd_pcm_sw_params_set_start_threshold() API description 
explains, "PCM is automatically started when playback frames available 
to PCM are >= threshold"

              I want to know,  whether above pre-buffering(threshold) 
mechanism is only during the start of playback ?
OR
             Also if my playback device goes to XRUN state, Again next 
time when i prepare my playback device using snd_pcm_prepare(). Again 
the prebuffering (threshold) will occur since i have set 
snd_pcm_sw_params_set_start_threshold() to N periods in software params.


Best Regards,
Thanks in advance,
Irfan...
