From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: amixer and mono
Date: Fri, 1 Aug 2008 17:32:00 -0400
Message-ID: <9e4733910808011432x232cec34t282aec253053a073@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 5AF5524567
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Aug 2008 23:32:01 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so761877ywk.2
	for <alsa-devel@alsa-project.org>; Fri, 01 Aug 2008 14:32:00 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Amixer says my device is mono:

root@phyCORE-MPC5200B-tiny:~ amixer
Simple mixer control 'PCM',0
  Capabilities: pvolume pvolume-joined
  Playback channels: Mono
  Limits: Playback 0 - 1023
  Mono: Playback 942 [92%]
root@phyCORE-MPC5200B-tiny:~

That's coming from the Volume control....

                if (snd_mixer_selem_has_playback_volume(elem) ||
                    snd_mixer_selem_has_playback_switch(elem)) {
                        printf("%sPlayback channels:", space);
                        if (snd_mixer_selem_is_playback_mono(elem)) {
                                printf(" Mono");
                        } else {

The device's master volume control controls all channels through one
value. The device really is stereo. You use biquads if you want to
process the channels differently.

What do I do about this?

-- 
Jon Smirl
jonsmirl@gmail.com
