From: "Pils Bert" <pilsbert@gmx.net>
Subject: M-Audio Audiophile 24/96 (snd-ice1712) lacks ADCs
Date: Thu, 06 Dec 2012 01:24:12 +0100
Message-ID: <20121206002412.104860@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.23])
 by alsa0.perex.cz (Postfix) with SMTP id 8F0F6265179
 for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2012 01:24:15 +0100 (CET)
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


Hi guys,

I have a problem with my M-Audio Audiophile 24/96 soundcard: There are no ADC volume sliders present neither in alsamixer nor in envy24control. But instead there are also DAC sliders on the capture page in alsamixer?! But changing them doesn't have an effect on the H/W input gain.

I read on website that some other users had the same problem (but it seams to be a rare problem).

First of all my card has been correctly detected as Audiophile 24/96. But in /sys/module/snd_ice1712/parameters/model are only null values. I loaded the module with the model=audiophile parameter, but no ADCs appear. Second I skimmed over the module source code and found the lines

	case ICE1712_SUBDEVICE_AUDIOPHILE:
		ice->num_total_dacs = 2;
		ice->num_total_adcs = 2;
		break;

in __devinit snd_ice1712_delta_init(struct snd_ice1712 *ice) in delta.c
So the module says there have to be 2 ADCs...

I also disabled my onboard soundcard (HDA Intel), but no ADCs appear.

Maybe its some hardware configuration problem?

Moreover, I had to edit my .asoundrc file in order to play and capture audio anyway (so no 'out of the box' experience here...):

pcm.audiophile {
   type hw
   card 1
   device 0
}

pcm.analog {
   type plug
   slave.pcm audiophile
   ttable.0.0 1 # H/W 1
   ttable.1.1 1 # H/W 2
}

I'm using plain ALSA 1.0.25 (without pulseaudio) on Debian Testing (Linux Rowdy 3.2.0-4-amd64 #1 SMP Debian 3.2.32-1 x86_64 GNU/Linux)

Maybe some of you guys have an good idea ;)

Best regards,

Jannik
