From: Donn Washburn <n5xwb@comcast.net>
Subject: Todays GIT system of alsa
Date: Thu, 12 Jan 2012 21:51:12 -0600
Message-ID: <4F0FAA30.8000106@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qmta13.emeryville.ca.mail.comcast.net
	(qmta13.emeryville.ca.mail.comcast.net [76.96.27.243])
	by alsa0.perex.cz (Postfix) with ESMTP id 3AE1B24502
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2012 04:51:17 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel elist <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hey Group;

I wish to let you know that todays GIT set of files fixed openSuSEs 11.4 
and 12.1 problem that I have been having.  That was a loss of 
pots/adjustments and mixed mute controls on kmix, gmixer and 
pavucontrol.   All of mixers work.  The system required snd-hda-intel 
module.  The system is a
ASUS M4A87TD Mother board and sound VIA VT1818 High Definition Audio 8 
Channel Codec.

lsmod | less
snd_pcm_oss            42358    0
snd_mixer_oss          18292    1 snd_pcm_oss
snd_seq                    49875    0
snd_seq_device         14530    1 snd_seq
snd_hda_intel            29539    10
snd_hda_codec         105907  3 
snd_hda_codec_hdmi,snd_hda_codec_via,snd_hda_intel
snd_hwdep               13604    1 snd_hda_codec
snd_pcm                   81432    7 
snd_pcm_oss,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec
snd_timer                  25525    5 snd_seq,snd_pcm
snd_pcm_oss,snd_mixer_oss,snd_seq,snd_seq_device,snd_hda_codec_hdmi,
snd_hda-codec_via,snd_hda_soundcore              15165  1 snd


Thanks again

-- 
73 de Donn Washburn
307 Savoy Street    Email:" n5xwb@comcast.net "
Sugar Land, TX 77478 LL# 1.281.242.3256
Ham Callsign N5XWB   HAMs : " n5xwb@arrl.net "
VoIP via Skype:n5xwbg  BMWMOA #:4146 Ambassador
       " http://counter.li.org " #279316
