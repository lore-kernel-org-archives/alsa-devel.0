From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Does Gravis Classic driver work?
Date: Wed, 3 Sep 2008 21:31:53 +0200
Message-ID: <20080903213153.f3feda45.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 450DF103821
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Sep 2008 21:25:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
Cc: Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I have acquired an unknown clone of the GF1 classic card.

I load the snd-gusclassic driver with
modprobe snd-gusclassic port=0x220

and the /proc/asound/cards says
 0 [G37            ]: GUS - Gravis UltraSound Classic (3.7)
                      Gravis UltraSound Classic (3.7) at 0x220, irq 5, dma 5&5

The alsamixer works. I set maximum volume for the PCM and master controls.

The aplay -l says:
**** List of PLAYBACK Hardware Devices ****
card 0: G37 [Gravis UltraSound Classic (3.7)], device 0: GF1 [GF1 (synth)]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

but the aplay -L says nothing.

the aplay with the .wav file does not play.
aplay /usr/share/sounds/alsa/Front_Center.wav
ALSA lib pcm.c:2144:(snd_pcm_open_noupdate) Unknown PCM default
aplay: main:545: audio open error: No such file or directory

I have tried to follow the alsa wiki but it has not helped (btw, there is no
driver the "gusclassic" listed, only the "gus"). Could you point me to
any piece of information how to set up the card?

The card works with DOS game with Miles (?) drivers.

Regards,
Krzysztof

----------------------------------------------------------------------
Teraz taniej na zagraniczne komorki!
Sprawdz >> http://link.interia.pl/f1ef7 
