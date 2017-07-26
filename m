From: Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: Re: [alsa-devel] [PATCH v1 5/6] ASoC: codecs: msm8916-wcd-analog:
 add MBHC support
Date: Wed, 26 Jul 2017 15:35:30 -0400
Message-ID: <20170726193530.wkv5awgeupbrrsxp@workotop.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatlaatlinaro.org@workotop.localdomain>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

[Sorry for breaking the thread, but I don't have the initial message to
reply to.]

I tried your patchset and faced some issues regarding removal detection:
the driver detects headphone and microphone removal as soon as I press a
button on the headset.

evtest logs:

	[Headset insertion]
Event: time 10207.841157, type 1 (EV_KEY), code 226 (KEY_MEDIA), value 1
Event: time 10207.841157, -------------- SYN_REPORT ------------
Event: time 10208.039105, type 1 (EV_KEY), code 226 (KEY_MEDIA), value 0
Event: time 10208.039105, -------------- SYN_REPORT ------------
Event: time 10208.075519, type 5 (EV_SW), code 2 (SW_HEADPHONE_INSERT), value 1
Event: time 10208.075519, type 5 (EV_SW), code 4 (SW_MICROPHONE_INSERT), value 1
Event: time 10208.075519, -------------- SYN_REPORT ------------
	[Pressing Volume up Button]
Event: time 10210.590403, type 1 (EV_KEY), code 115 (KEY_VOLUMEUP), value 1
Event: time 10210.590403, type 5 (EV_SW), code 2 (SW_HEADPHONE_INSERT), value 0
Event: time 10210.590403, type 5 (EV_SW), code 4 (SW_MICROPHONE_INSERT), value 0
Event: time 10210.590403, -------------- SYN_REPORT ------------
Event: time 10210.719560, type 1 (EV_KEY), code 115 (KEY_VOLUMEUP), value 0
Event: time 10210.719560, -------------- SYN_REPORT ------------
	[Unplugging]
Event: time 10221.926156, type 1 (EV_KEY), code 226 (KEY_MEDIA), value 1
Event: time 10221.926156, -------------- SYN_REPORT ------------
Event: time 10222.026466, type 1 (EV_KEY), code 226 (KEY_MEDIA), value 0
Event: time 10222.026466, -------------- SYN_REPORT ------------


Also, the KEY_MEDIA is wrongly reported but I don't see that every time,
I think it depends on how fast I plug in the headset. Anyway, I think
that can easily be filtered out by testing the presence of the
microphone.


Regards,
-- 
Damien
