From: Andoru <aekkusu@gmail.com>
Subject: High CPU usage on the default device,
	low CPU usage on a specific device
Date: Wed, 1 Nov 2017 23:04:49 +0200
Message-ID: <CAHuHXNBCv1CAhtMw-K7S0Y-8EoVQsOu0vnJXh05_JTDS50djdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f170.google.com (mail-ot0-f170.google.com
 [74.125.82.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 902C7266AE1
 for <alsa-devel@alsa-project.org>; Wed,  1 Nov 2017 22:05:11 +0100 (CET)
Received: by mail-ot0-f170.google.com with SMTP id c47so101131otj.6
 for <alsa-devel@alsa-project.org>; Wed, 01 Nov 2017 14:05:11 -0700 (PDT)
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

As the title says, I'm having a bit of an issue with ALSA, and the high CPU
(~15-20%) usage in some cases. So far on the default device, I've only
noticed this with VLC and foobar2000 (through Wine), but there are other
apps/games that might have the same problem. It's just easy to tell if an
app/ALSA uses too much CPU if you just play some audio files and you don't
have anything else that might need the extra CPU power, like rendering the
video stream or render the graphics. I can fix the high CPU usage in VLC if
I switch the audio sub-device from the Default to a specific one (in my
case: Analog Front Speakers). There is no change in the audio quality, but
the resources used instantly decrease. The only problem with this is that I
can no longer play/hear any audio from other apps/games (so basically VLC
monopolises the card). Also, this is not possible under Wine, so I can't
achieve the same thing for foobar2000, or other Windows apps/games.
I haven't made any custom config files for ALSA, except to disable the HDMI
audio output (so that the normal analogue output is used by default in all
apps/games), and I've done that in /etc/modprobe.d/intel-disable-hdmi.conf
with this as it's content:

_______________________________________________________________________
options snd_hda_intel enable=0,1
_______________________________________________________________________

The soundcard that I'm using is an integrated one, and it's a Realtek
ALC887-VD.
Does anyone know what I could do to fix this issue, while still being able
to play multiple streams of audio at the same time?
