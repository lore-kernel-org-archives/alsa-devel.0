From: Thomas Richter <thor@math.tu-berlin.de>
Subject: Mono output on emu10k1 with alsa broken
Date: Wed, 1 May 2013 21:36:45 +0000 (UTC)
Message-ID: <loom.20130501T232933-467@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id E6CF9260856
 for <alsa-devel@alsa-project.org>; Wed,  1 May 2013 23:37:51 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1UXeiO-0004kT-3M
 for alsa-devel@alsa-project.org; Wed, 01 May 2013 23:37:28 +0200
Received: from p4FC12FBE.dip0.t-ipconnect.de ([79.193.47.190])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Wed, 01 May 2013 23:37:28 +0200
Received: from thor by p4FC12FBE.dip0.t-ipconnect.de with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Wed, 01 May 2013 23:37:28 +0200
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

Trying to configure mono (one channel) output on emu10k1 hardware using the
alsa version that comes with kernel 3.9 is broken. Instead of expecting mono
samples, the alsa callback expects twice as many stereo samples. Not getting
the required number of samples then causes a buffer underrun, and sound gets
interrupted or messed up. In fact, what the audio hardware does is that it
plays not only the buffer, but also the data "behind the buffer", causing
wierd noises.

The channel count is setup as

channels = 1;


snd_pcm_hw_params_malloc(&HWParms);

snd_pcm_open(&SoundStream,CardName,SND_PCM_STREAM_PLAYBACK,SND_PCM_NONBLOCK
| SND_PCM_ASYNC);

snd_pcm_hw_params_set_channels_min(SoundStream,HWParms,&channels);

snd_pcm_hw_params_set_channels_max(SoundStream,HWParms,&channels);

snd_pcm_hw_params_set_channels_first(SoundStream,HWParms,&channels);

plus error checking. Then, a bit later, the number of configured channels is
verified:

snd_pcm_hw_params_get_channels(HWParms,&channels);

channels is at this point still 1, i.e. the driver accepted the mono output,
but does then not play correctly.

Note that the same call sequence works for stereo, and it also works for
mono for other underlying hardware drivers, i.e. mono output works on
snd-hda-intel, for example. It does not on emu10k1.
