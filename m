From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001572]: Simultaneous sound from speakers and headphone
Date: Wed, 22 Mar 2006 21:01:10 +0100
Message-ID: <3d90238848d74f0e9d2e67044f2c99fe@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5168513B
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 21:01:10 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1572> 
======================================================================
Reported By:                mjsb
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1572
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo Linux
Kernel Version:             2.1.13-gentoo-r3
======================================================================
Date Submitted:             11-17-2005 16:31 CET
Last Modified:              03-22-2006 21:01 CET
======================================================================
Summary:                    Simultaneous sound from speakers and headphone
Description: 
I cannot ear headphones without having sound from front speakers
simultaneously.
Volume of headphones is adjusted by front speakers and when muting front
speakers also mutes headphones.
(in MS Windows, inserting headphones automatically disables sound from
front speakers)

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001663 LW20 bugs with headphone input, realtek...
======================================================================

----------------------------------------------------------------------
 mjsb - 03-22-06 20:44 
----------------------------------------------------------------------
Just tried alsa-driver-1.0.11rc4 and it gives the same results as the CVS
obtained earlier today: Doesnt work :(

The LG LW20 has different pin assignments from the model LG m1.

Using model=test I found that
Green (headphones) = In-4 Pin = 0x1b
Blue (Line-Out) = In-3 Pin = 0x1a
Red (Mic) = In-1 Pin = 0x18
Headphones work on all these jacks if set to HP.

Front speakers work if FrontPin=LineOut=0x14, and volume control works
HDA_CODEC_VOLUME(,0x0c,,)


I'm trying to write up a new model 'lg_lw20' on patch_realtek.c based on
model 'lg' and already have it working, but there is a problem I dont
understand yet. It has the opposite behaviour of the 'lg': speakers work,
but headphones dont.

Here is the relevant part of the code:
/* 2,4,6 channel modes */
static struct hda_verb alc880_lglw20_ch2_init[] = {
	/* set line-in and mic-in to input */
	{ 0x1b, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP },
	{ 0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN },
	{ 0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80 },
	{ }
};

static struct hda_verb alc880_lglw20_ch4_init[] = {
	/* set line-in to out and mic-in to input */
	{ 0x1b, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP },
	{ 0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP },
	{ 0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80 },
	{ }
};

static struct hda_verb alc880_lglw20_ch6_init[] = {
	/* set line-in and mic-in to output */
	{ 0x1b, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP },
	{ 0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP },
	{ 0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP },
	{ }
};

static struct hda_channel_mode alc880_lglw20_ch_modes[3] = {
	{ 2, alc880_lglw20_ch2_init },
	{ 4, alc880_lglw20_ch4_init },
	{ 6, alc880_lglw20_ch6_init },
};

static struct snd_kcontrol_new alc880_lglw20_mixer[] = {
	/* FIXME: surround, center and LFE are incorrect */
	/* FIXME: Mic, Line, InternalMic needs to be checked/fixed */
	HDA_CODEC_VOLUME("Master Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
	HDA_BIND_MUTE("Master Playback Switch", 0x0c, 2, HDA_INPUT),
	HDA_CODEC_VOLUME("Surround Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
	HDA_BIND_MUTE("Surround Playback Switch", 0x0c, 2, HDA_INPUT),
	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x0d, 1, 0x0,
HDA_OUTPUT),
	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x0d, 2, 0x0, HDA_OUTPUT),
	HDA_BIND_MUTE_MONO("Center Playback Switch", 0x0d, 1, 2, HDA_INPUT),
	HDA_BIND_MUTE_MONO("LFE Playback Switch", 0x0d, 2, 2, HDA_INPUT),
	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x06, HDA_INPUT),
	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x06, HDA_INPUT),
	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x0b, 0x07, HDA_INPUT),
	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x0b, 0x07, HDA_INPUT),
	{
		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
		.name = "Channel Mode",
		.info = alc_ch_mode_info,
		.get = alc_ch_mode_get,
		.put = alc_ch_mode_put,
	},
	{ } /* end */
};

static struct hda_verb alc880_lglw20_init_verbs[] = {
	/* set capture source to mic-in */
	{0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
	{0x08, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
	{0x09, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
	/* mute all amp mixer inputs */
	{0x0b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(5)},
	{0x0b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(6)},
	{0x0b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(7)},
	/* line-in to input */
	{0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
	{0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
	/* built-in mic */
	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
	/* speaker-out */
	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
	/* mic-in to input */
	{0x11, AC_VERB_SET_CONNECT_SEL, 0x01},
	{0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
	{0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
	/* HP-out */
	{0x13, AC_VERB_SET_CONNECT_SEL, 0x03},
	{0x1b, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
	{0x1b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
	/* jack sense */
	{0x1b, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | 0x1},
	{ }
};

/* toggle speaker-output according to the hp-jack state */
static void alc880_lglw20_automute(struct hda_codec *codec)
{
	unsigned int present;

	present = snd_hda_codec_read(codec, 0x1b, 0,
				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
	snd_hda_codec_amp_update(codec, 0x14, 0, HDA_OUTPUT, 0,
				 0x80, present ? 0x80 : 0);
	snd_hda_codec_amp_update(codec, 0x14, 1, HDA_OUTPUT, 0,
				 0x80, present ? 0x80 : 0);
}

static void alc880_lglw20_unsol_event(struct hda_codec *codec, unsigned
int res)
{
	/* Looks like the unsol event is incompatible with the standard
	 * definition.  4bit tag is placed at 28 bit!
	 */
	if ((res >> 28) == 0x01)
		alc880_lglw20_automute(codec);
}

----------------------------------------------------------------------
 tiwai - 03-22-06 21:01 
----------------------------------------------------------------------
Err, did you try my patch above (alc880-lg-lw-model.diff) ??

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-17-05 16:31 mjsb           New Issue                                    
11-17-05 16:31 mjsb           Distribution              => Gentoo Linux    
11-17-05 16:31 mjsb           Kernel Version            => 2.1.13-gentoo-r3
11-17-05 16:33 mjsb           Issue Monitored: mjsb                        
12-08-05 21:23 mjsb           Note Added: 0006962                          
01-16-06 11:19 mjsb           Note Added: 0007685                          
01-19-06 18:27 rlrevell       Relationship added       has duplicate 0001663
01-21-06 03:24 mjsb           Note Added: 0007730                          
01-21-06 03:25 mjsb           File Added: HPoff-speakeron                    
01-21-06 03:25 mjsb           File Added: HPon-speakeroff                    
01-21-06 03:30 mjsb           Note Edited: 0007730                         
01-25-06 11:47 blackr2d       Issue Monitored: blackr2d                    
01-25-06 11:56 blackr2d       Note Added: 0007778                          
01-25-06 11:59 blackr2d       Note Edited: 0007778                         
01-25-06 12:00 blackr2d       Note Edited: 0007778                         
01-25-06 12:36 blackr2d       Note Edited: 0007778                         
02-14-06 05:36 richardfish    Issue Monitored: richardfish                    
02-14-06 05:37 richardfish    Note Added: 0008069                          
02-16-06 13:49 mjsb           Note Added: 0008096                          
03-01-06 18:00 mpt            Issue Monitored: mpt                         
03-15-06 15:36 tiwai          Note Added: 0008552                          
03-22-06 01:33 crissi         Note Added: 0008766                          
03-22-06 01:33 crissi         Issue Monitored: crissi                      
03-22-06 01:42 rlrevell       Note Added: 0008768                          
03-22-06 01:44 rlrevell       Note Added: 0008769                          
03-22-06 01:55 crissi         Note Added: 0008772                          
03-22-06 01:58 rlrevell       Note Added: 0008773                          
03-22-06 02:09 crissi         Note Added: 0008774                          
03-22-06 02:25 rlrevell       Note Added: 0008777                          
03-22-06 02:26 rlrevell       Note Deleted: 0008768                        
03-22-06 02:26 rlrevell       Note Deleted: 0008773                        
03-22-06 02:26 rlrevell       Note Deleted: 0008769                        
03-22-06 02:27 rlrevell       Note Deleted: 0008777                        
03-22-06 02:27 crissi         Note Added: 0008778                          
03-22-06 02:30 rlrevell       Note Added: 0008780                          
03-22-06 14:25 mjsb           Note Added: 0008855                          
03-22-06 15:06 mjsb           Note Added: 0008856                          
03-22-06 15:53 tiwai          Note Added: 0008860                          
03-22-06 19:17 tiwai          Note Added: 0008867                          
03-22-06 19:18 tiwai          File Added: alc880-lg-lw-model.diff               
    
03-22-06 20:44 mjsb           Note Added: 0008868                          
03-22-06 21:01 tiwai          Note Added: 0008870                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
