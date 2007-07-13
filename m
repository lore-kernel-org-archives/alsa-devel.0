From: Steffen Schulz <pepe_ml@gmx.net>
Subject: hda-intel on latext macbook pro
Date: Fri, 13 Jul 2007 06:32:42 +0200
Message-ID: <20070713043242.GA16479@cbg.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.rz.ruhr-uni-bochum.de (mx1.rz.ruhr-uni-bochum.de
	[134.147.32.86]) by alsa0.perex.cz (Postfix) with SMTP id 94A7C243E5
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jul 2007 06:32:43 +0200 (CEST)
Received: from cbg.dyndns.org (knox_zi408.hm.ruhr-uni-bochum.de [10.0.52.70])
	by mulch.hm.ruhr-uni-bochum.de (Postfix) with ESMTP id D8758F522
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jul 2007 06:32:43 +0200 (CEST)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,


I wrote about a week ago about the problems with alsa on the latest
macbook pro (rev3, with santa-rosa).

As I described, model=w2jc sort of works for the macbooks.
Front Mic and LineIn work. The LineIn can be configured to LineOut
by setting 2-Channe to 6-Channel. I've seen where this is done in the
code and it is also possible to have a working Mic in this
configuration.

As I have no idea how the driver or auto-detection or driver
development/reverse engineering usually works, I tried to brute force
the mixer controls. I found two more mute switches, one for the front
speakers and one for the LineOut.

But I was unable to activate the normal headphone output.
Is there anyone here who can give me a hint what to search for?

I noticed that when the Mic is disabled with the code that switches
between 2ch and 6ch, the Mic control do not work anymore. Maybe it is
the same for the headphone controls and some other settings?


This is what I got so far:


[ALC882_MBP] = {
        .mixers = { alc882_mbp_mixer, alc882_chmode_mixer },
        .init_verbs = { alc882_init_verbs, alc882_eapd_verbs,
                        alc880_gpio1_init_verbs },
        .num_dacs = ARRAY_SIZE(alc882_dac_nids),
        .dac_nids = alc882_dac_nids,
        .num_channel_mode = ARRAY_SIZE(alc880_threestack_modes),
        .channel_mode = alc880_threestack_modes,
        .need_dac_fix = 1,
        .input_mux = &alc882_capture_source,
        .dig_out_nid = ALC882_DIGOUT_NID,
        .dig_in_nid = ALC882_DIGIN_NID,
        },

static struct snd_kcontrol_new alc882_mbp_mixer[] = {
   HDA_CODEC_VOLUME("Master Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
   HDA_BIND_MUTE   ("Master Playback Switch", 0x0c, 2, HDA_INPUT),
   HDA_CODEC_MUTE  ("Front Speaker Switch", 0x14, 0x00, HDA_OUTPUT),
   HDA_CODEC_MUTE  ("Line Out Switch", 0x1a, 0x00, HDA_OUTPUT),
   HDA_CODEC_VOLUME("CD Playback Volume", 0x0b, 0x04, HDA_INPUT),
   HDA_CODEC_MUTE  ("CD Playback Switch", 0x0b, 0x04, HDA_INPUT),
   HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x02, HDA_INPUT),
   HDA_CODEC_MUTE  ("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
   HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
   HDA_CODEC_MUTE  ("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
   HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
   .
   .
   .[many controls that seem to do nothing]
   .
   { }
};


I have no audio CD and no SPDIF-hardware, but the other controls do
as they advertised.

I would appreciate hints on finding the headphone controls. Hardware
information can be seen in my last posts to the list.


/Steffen
-- 
Bildet Olsenbanden!
