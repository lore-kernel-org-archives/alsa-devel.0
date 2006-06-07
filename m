From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002167]: Not all channel useable /
	Mixersettings on FujitsuSiemens Amilo M1437G (IntelHDA -
	Realtec ALC880)
Date: Wed, 7 Jun 2006 11:42:19 +0200
Message-ID: <eb12cef9474db3661af937e755df9da0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 415AB114
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Jun 2006 11:42:19 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2167> 
======================================================================
Reported By:                der_sprengmeister
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2167
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.16
======================================================================
Date Submitted:             05-27-2006 21:22 CEST
Last Modified:              06-07-2006 11:42 CEST
======================================================================
Summary:                    Not all channel useable / Mixersettings on
FujitsuSiemens Amilo M1437G (IntelHDA - Realtec ALC880)
Description: 
Not all channel are available, nor the mixer shows the correct settings.
For example: "Headphone" controlls the Internal speaker, many
switches/controller (e.g. IEC958) is not available.
======================================================================

----------------------------------------------------------------------
 der_sprengmeister - 06-07-06 11:21 
----------------------------------------------------------------------
I have improved changes on the z71v-model for Realtec ALC880 on Fujitsu
Siemens AmiloM 1437G

new: Mic is now FrontMic
     4 new inputs (but I don't know, what the inputs are)   :-(
     (I hope, some other people can probe)

Here the new hack:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#define ALC880_Z71V_HP_DAC 0x03
                                                                          
                                                                 
/* fixed 2 channels */
static struct hda_channel_mode alc880_2_jack_modes[1] = {
        { 2, NULL }
};
                                                                          
                                                                 
/* changed by der_sprengmeister@yahoo.com :-) */ 

static struct snd_kcontrol_new alc880_z71v_mixer[] = {

	HDA_CODEC_VOLUME("Front Playback Volume", 0x0d, 0x0, HDA_OUTPUT),
	HDA_BIND_MUTE("Front Playback Switch", 0x0d, 2, HDA_INPUT),
	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
	HDA_BIND_MUTE("Headphone Playback Switch", 0x0c, 2, HDA_INPUT),
	HDA_CODEC_VOLUME("CD Playback Volume", 0x0b, 0x04, HDA_INPUT),
	HDA_CODEC_MUTE("CD Playback Switch", 0x0b, 0x04, HDA_INPUT),
	HDA_CODEC_VOLUME("PC Speaker Playback Volume", 0x0b, 0x05, HDA_INPUT),
	HDA_CODEC_MUTE("PC Speaker Playback Switch", 0x0b, 0x05, HDA_INPUT),
        HDA_CODEC_VOLUME("FrontMic Playback Volume", 0x0b, 0x1,
HDA_INPUT),
        HDA_CODEC_MUTE("FrontMic Playback Switch", 0x0b, 0x1, HDA_INPUT),
        HDA_CODEC_VOLUME("inp1 Playback Volume", 0x0b, 0x06, HDA_INPUT),
        HDA_CODEC_MUTE("inp1 Playback Switch", 0x0b, 0x06, HDA_INPUT),
	HDA_CODEC_VOLUME("inp2 Playback Volume", 0x0b, 0x02, HDA_INPUT),
	HDA_CODEC_MUTE("inp2 Playback Switch", 0x0b, 0x02, HDA_INPUT),
	HDA_CODEC_VOLUME("inp3 Playback Volume", 0x0b, 0x0, HDA_INPUT),
	HDA_CODEC_MUTE("inp3 Playback Switch", 0x0b, 0x0, HDA_INPUT),
        HDA_CODEC_VOLUME("inp4 Playback Volume", 0x0b, 0x07, HDA_INPUT),
        HDA_CODEC_MUTE("inp4 Playback Switch", 0x0b, 0x07, HDA_INPUT),
	{ } /* end */
};


/* End of changed by der_sprengmeister@yahoo.com :-) */

----------------------------------------------------------------------
 der_sprengmeister - 06-07-06 11:42 
----------------------------------------------------------------------
Add On: The new 4 channels I found seems to be "real" channels for the
model, because if I unmute them and volume-up, the noise get louder. It
works for all 4 inputs. I think, most of them aren't connected to a jack,
but one of them should be the line-in on the left side of the notebook (I
hope).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-27-06 21:22 der_sprengmeisterNew Issue                                    
05-27-06 21:22 der_sprengmeisterKernel Version            => 2.6.16          
05-27-06 21:24 der_sprengmeisterIssue Monitored: der_sprengmeister              
     
06-07-06 11:21 der_sprengmeisterNote Added: 0010080                          
06-07-06 11:42 der_sprengmeisterNote Added: 0010081                          
======================================================================
