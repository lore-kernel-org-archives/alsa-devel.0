From: alex dot baldacchino dot alsasub at gmail dot com
	<alex.baldacchino.alsasub@gmail.com>
Subject: Via Codecs: playback_multi_pcm_prep_0() might do
 something unneded in redirected mode - or something else could be wrong.
Date: Thu, 30 Jun 2011 18:49:21 +0200
Message-ID: <BANLkTimgFU70vRBsdYUArjUY4-8Lm7TK1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8BBBC10384A
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Jun 2011 18:49:21 +0200 (CEST)
Received: by wyh21 with SMTP id 21so1858938wyh.38
	for <alsa-devel@alsa-project.org>; Thu, 30 Jun 2011 09:49:21 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Raymond Yau <superquad.vortex2@gmail.com>, Takashi Iwai <tiwai@suse.de>, lydiawang <lydiawang@viatech.com.cn>
List-Id: alsa-devel@alsa-project.org

I've got a doubt about the following piece of code:

...
	if (mout->hp_nid && mout->hp_nid != nids[HDA_FRONT]
	    && !spec->hp_independent_mode)
		/* headphone out will just decode front left/right (stereo) */
		snd_hda_codec_setup_stream(codec, mout->hp_nid, stream_tag,
					   0, format);


In redirected mode, if mout->hp_nid is not the same as the front dac,
headphone jack (spec->autocfg.hp_pins[0]) is connected to it (get
inputs from the front dac) one way or the other, so it would seem
useless to make a different dac work on the same stream, given its
output is being, let me say, 'discarded'. Moreover,
via_independent_hp_put() always cleans that stream up for hp_nid in
similar conditions:

...
	if (spec->multiout.hp_nid && spec->multiout.hp_nid
	    != spec->multiout.dac_nids[HDA_FRONT])
		snd_hda_codec_setup_stream(codec, spec->multiout.hp_nid,
					   0, 0, 0);


This means that switching Independent HP mode on and off while playing
something would prevent the dac corresponding to hp_nid from decoding
that stream any further, whereas a simple printk tells me
playback_multi_pcm_prep_0 is called just once at the beginning of the
streaming. A simple test showed me that piece of code isn't needed in
my case (VT2020) and I'd guess that's the same for most codecs, if not
all (not yet tested commenting out that block, though): starting with
Independent HP mode 'ON', that block isn't executed
(!spec->hp_independent_mode is false), but switching it to 'OFF' while
playing I get sound out of my headset connected to my case front audio
panel; I can do it repeatedly and always works.

Though not extremely frequent, I think such a scenario could happen in
"real world use", for instance, I can think of someone turning off
Independent HP mode while playing, then turning off a speaker system
because of someone complaining for loud sound (or asking for silence),
or just by mistake, because thinking redirected mode were active while
it wasn't.

Therefore, if there were any codecs requiring for stream being setup
for hp_nid while in redirected mode, to work properly, that could be
made clear in playback_multi_pcm_prep_0(), just to make the code a bit
clearer, and, most important, via_independent_hp_put should be
corrected to take that into account (and perhaps infos on current
stream(s) should be recorded somewhere, to do that).

Regards.
