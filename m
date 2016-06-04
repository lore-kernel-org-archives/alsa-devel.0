From: Alan Young <consult.awy@gmail.com>
Subject: Improving status timestamp accuracy
Date: Sat, 4 Jun 2016 10:31:49 +0100
Message-ID: <5752A005.2050309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
 by alsa0.perex.cz (Postfix) with ESMTP id BEC052606D6
 for <alsa-devel@alsa-project.org>; Sat,  4 Jun 2016 11:31:50 +0200 (CEST)
Received: by mail-wm0-f49.google.com with SMTP id z87so21904636wmh.0
 for <alsa-devel@alsa-project.org>; Sat, 04 Jun 2016 02:31:50 -0700 (PDT)
Received: from [192.168.11.11] (175.64.199.146.dyn.plus.net. [146.199.64.175])
 by smtp.googlemail.com with ESMTPSA id
 d86sm3607788wmh.4.2016.06.04.02.31.49
 for <alsa-devel@alsa-project.org> (version=TLSv1/SSLv3 cipher=OTHER);
 Sat, 04 Jun 2016 02:31:49 -0700 (PDT)
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

I am looking at ways to get more accurate status timestamp information 
for various SoC drivers. The data that is obtained by snd_pcm_status(). 
One route would be to implement the more accurate timestamp mechanisms 
that currently are only available for HDA and Skylake (which I think is 
the SoC version of HDA).

Looking at the code however, I think that may be unnecessary, at least 
for my purposes. It may not actually be practical in many cases.

A call to snd_pcm_status() result in snd_pcm_update_hw_ptr0() being 
called. This gets the current output position (pos) via 
substream->ops->pointer(substream) and then makes all the other 
calculations based on the result. In theory, the result of 
substream->ops->pointer() could be sample accurate but in practice it is 
very unlikely to be better than period accurate. In fact, if I read it 
right, it will just about always be accurate to the point of the last 
period interrupt. Even when a DMA driver claims support of 
DMA_RESIDUE_GRANULARITY_BURST, it is often the case that the actual 
granularity is a period.

The consequence of all that is that, for most drivers, the accuracy of a 
status report is period time. The result values, tstamp & audio_tstamp, 
are calculated using the current time and the pos estimate from above.

snd_pcm_update_hw_ptr0() is also called when there is a DMA interrupt. 
At that time the calculate results will be accurate, or at worst 
consistently inaccurate (there could be a constant offset). It would be 
useful if a snd_pcm_status() call would simply return the results from 
the point of the last interrupt, and not try to estimate a current value 
based on the inaccurate substream->ops->pointer() result. It could 
either: (a) return the result from the time of the last interrupt, in 
which case tstamp would be in the past and driver_tstamp would be now; 
or (b) update audio_tstamp based on the elapsed time since it was 
recorded. (b) effectively abandons the idea that a current position 
report will be accurate outside of an interrupt callback but, even if it 
is, doing so is unlikely to result in any loss of accuracy in practice 
(assuming a drift of better than 40ppm and period time < 100ms).

Any comments on either of these approaches? I guess (b) is more 
compatible with the current model.

Alan.
