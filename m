From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v1 5/6] ASoC: codecs: msm8916-wcd-analog:
 add MBHC support
Date: Thu, 27 Jul 2017 11:03:36 +0100
Message-ID: <a8b3c03b-e08f-f876-08ef-40f8aa7eaad4@linaro.org>
References: <20170726193530.wkv5awgeupbrrsxp@workotop.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 98FBA266A8A
 for <alsa-devel@alsa-project.org>; Thu, 27 Jul 2017 12:03:40 +0200 (CEST)
Received: by mail-wm0-f50.google.com with SMTP id c184so102593155wmd.0
 for <alsa-devel@alsa-project.org>; Thu, 27 Jul 2017 03:03:40 -0700 (PDT)
In-Reply-To: <20170726193530.wkv5awgeupbrrsxp@workotop.localdomain>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Damien Riegel <damien.riegel@savoirfairelinux.com>, Srinivas Kandagatla <srinivas.kandagatlaatlinaro.org@workotop.localdomain>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


Thanks Damien, for testing the patchset.

On 26/07/17 20:35, Damien Riegel wrote:
> [Sorry for breaking the thread, but I don't have the initial message to
> reply to.]
> 
> I tried your patchset and faced some issues regarding removal detection:
> the driver detects headphone and microphone removal as soon as I press a
> button on the headset.
> 


I will try to reproduce this on my end and hopefully fix it in next version.


--srini
> evtest logs:
> 
> 	[Headset insertion]
> Event: time 10207.841157, type 1 (EV_KEY), code 226 (KEY_MEDIA), value 1
> Event: time 10207.841157, -------------- SYN_REPORT ------------
> Event: time 10208.039105, type 1 (EV_KEY), code 226 (KEY_MEDIA), value 0
> Event: time 10208.039105, -------------- SYN_REPORT ------------
> Event: time 10208.075519, type 5 (EV_SW), code 2 (SW_HEADPHONE_INSERT), value 1
> Event: time 10208.075519, type 5 (EV_SW), code 4 (SW_MICROPHONE_INSERT), value 1
> Event: time 10208.075519, -------------- SYN_REPORT ------------
> 	[Pressing Volume up Button]
> Event: time 10210.590403, type 1 (EV_KEY), code 115 (KEY_VOLUMEUP), value 1
> Event: time 10210.590403, type 5 (EV_SW), code 2 (SW_HEADPHONE_INSERT), value 0
> Event: time 10210.590403, type 5 (EV_SW), code 4 (SW_MICROPHONE_INSERT), value 0
> Event: time 10210.590403, -------------- SYN_REPORT ------------
> Event: time 10210.719560, type 1 (EV_KEY), code 115 (KEY_VOLUMEUP), value 0
> Event: time 10210.719560, -------------- SYN_REPORT ------------
> 	[Unplugging]
> Event: time 10221.926156, type 1 (EV_KEY), code 226 (KEY_MEDIA), value 1
> Event: time 10221.926156, -------------- SYN_REPORT ------------
> Event: time 10222.026466, type 1 (EV_KEY), code 226 (KEY_MEDIA), value 0
> Event: time 10222.026466, -------------- SYN_REPORT ------------
> 
> 
> Also, the KEY_MEDIA is wrongly reported but I don't see that every time,
> I think it depends on how fast I plug in the headset. Anyway, I think
> that can easily be filtered out by testing the presence of the
> microphone.
> 
> 
> Regards,
> 
