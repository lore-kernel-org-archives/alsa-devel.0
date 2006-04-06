From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001971]: Some elements incorrectly have capture flags
Date: Thu, 6 Apr 2006 09:44:24 +0200
Message-ID: <f24d9e1814c24741300481e620ace868@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B9BFF1A0
	for <alsa-devel@alsa-project.org>; Thu,  6 Apr 2006 09:44:24 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1971> 
======================================================================
Reported By:                pzad
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1971
Category:                   simple mixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             03-28-2006 12:16 CEST
Last Modified:              04-06-2006 09:44 CEST
======================================================================
Summary:                    Some elements incorrectly have capture flags
Description: 
Some elemnts have capture flags even they have nothing to do with capture.
This will duplicate control in alsamixer - view ALL.

On VIA8233A + ALC650:

Simple mixer control '3D Control - Center',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 1 [7%]
Simple mixer control '3D Control - Depth',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 0 [0%]

On Audigy 1:
Simple mixer control 'Bass',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 40
  Front Left: 23 [58%]
  Front Right: 23 [58%]
Simple mixer control 'Treble',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 40
  Front Left: 27 [68%]
  Front Right: 27 [68%]


======================================================================

----------------------------------------------------------------------
 Raymond - 04-05-06 18:50 
----------------------------------------------------------------------
I can group the lower 4 bands to implement the bass control and the upper 6
bands to implement the treble control. 

The new "Bass" and "Treble" will appear in kmix.

how can I add the surround of STAC9708 into kmix ?

cat /proc/asound/au8830/oss_mixer
VOLUME "Master" 0
BASS "Tone Control - Bass" 0
TREBLE "Tone Control - Treble" 0
SYNTH "" 0
PCM "PCM" 0
SPEAKER "PC Speaker" 0
LINE "Line" 0
MIC "Mic" 0
CD "CD" 0
IMIX "" 0
ALTPCM "" 0
RECLEV "" 0
IGAIN "Capture" 0
OGAIN "" 0
LINE1 "Aux" 0
LINE2 "" 0
LINE3 "" 0
DIGITAL1 "" 0
DIGITAL2 "" 0
DIGITAL3 "" 0
PHONEIN "Phone" 0
PHONEOUT "Master Mono" 0
VIDEO "Video" 0
RADIO "" 0
MONITOR "" 0


/*
	Bass control - the lower 4 bands
*/
static int
snd_vortex_bass_treble_info(struct snd_kcontrol *kcontrol, struct
snd_ctl_elem_info *uinfo)
{
	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
	uinfo->count = 2;
	uinfo->value.integer.min = 0x0000;
	uinfo->value.integer.max = 0x7fff;
	return 0;
}

static int
snd_vortex_bass_get(struct snd_kcontrol *kcontrol, struct
snd_ctl_elem_value *ucontrol)
{
	vortex_t *vortex = snd_kcontrol_chip(kcontrol);
	ucontrol->value.integer.value[0] = vortex->bass[0];
	ucontrol->value.integer.value[1] = vortex->bass[1];
	return 0;
}

static int
snd_vortex_bass_put(struct snd_kcontrol *kcontrol, struct
snd_ctl_elem_value *ucontrol)
{
	vortex_t *vortex = snd_kcontrol_chip(kcontrol);
	int changed = 0, i;
	if ( vortex->bass[0] != ucontrol->value.integer.value[0]) {
		vortex->bass[0] = ucontrol->value.integer.value[0];
		changed = 1;
	};
	if ( vortex->bass[1] != ucontrol->value.integer.value[1]) {
		vortex->bass[1] = ucontrol->value.integer.value[1];
		changed = 1;
	};
	for (i=0; i<4; i++)  {
		vortex_Eqlzr_SetLeftGain(vortex, i, vortex->bass[0]);
		vortex_Eqlzr_SetRightGain(vortex, i, vortex->bass[1]);
	}
	return changed;
}

static struct snd_kcontrol_new vortex_bass_kcontrol __devinitdata = {
	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
	.name = "Tone Control - Bass",
	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
	.info = snd_vortex_bass_treble_info,
	.get = snd_vortex_bass_get,
	.put = snd_vortex_bass_put
};

/*
	Treble control - the upper 6 bands
*/
static int
snd_vortex_treble_get(struct snd_kcontrol *kcontrol, struct
snd_ctl_elem_value *ucontrol)
{
	vortex_t *vortex = snd_kcontrol_chip(kcontrol);
	ucontrol->value.integer.value[0] = vortex->treble[0];
	ucontrol->value.integer.value[1] = vortex->treble[1];
	return 0;
}

static int
snd_vortex_treble_put(struct snd_kcontrol *kcontrol, struct
snd_ctl_elem_value *ucontrol)
{
	vortex_t *vortex = snd_kcontrol_chip(kcontrol);
	int changed = 0, i;
	if ( vortex->treble[0] != ucontrol->value.integer.value[0]) {
		vortex->treble[0] = ucontrol->value.integer.value[0];
		changed = 1;
	}
	if ( vortex->treble[1] != ucontrol->value.integer.value[1]) {
		vortex->treble[1] = ucontrol->value.integer.value[1];
		changed = 1;
	}
	for (i=4; i<10; i++)  {
		vortex_Eqlzr_SetLeftGain(vortex, i, vortex->treble[0]);
		vortex_Eqlzr_SetRightGain(vortex, i, vortex->treble[1]);
	};
	return changed;
}

static struct snd_kcontrol_new vortex_treble_kcontrol __devinitdata = {
	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
	.name = "Tone Control - Treble",
	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
	.info = snd_vortex_bass_treble_info,
	.get = snd_vortex_treble_get,
	.put = snd_vortex_treble_put
};









	for (i=0; i<2; i++) {
		vortex->bass[i] = 0x3e96;
		vortex->treble[i] = 0x3e96;
	};

	if ((kcontrol =  snd_ctl_new1(&vortex_bass_kcontrol, vortex)) == NULL)
		return -ENOMEM;
	if ((err = snd_ctl_add(vortex->card, kcontrol)) < 0)
		return err;
	if ((kcontrol =  snd_ctl_new1(&vortex_treble_kcontrol, vortex)) == NULL)
		return -ENOMEM;
	if ((err = snd_ctl_add(vortex->card, kcontrol)) < 0)
		return err;



----------------------------------------------------------------------
 Raymond - 04-06-06 09:44 
----------------------------------------------------------------------
It's easy to implement a switch which route either one of the following 

1) Front Playback Channels
2) Capture Channels
3) Rear Playback Channels (Only for au8810/au8830 with 4 channels codec)

to the 10-bands stereo equalizer.


static void
vortex_connect_codecplay(vortex_t * vortex, int en, unsigned char
mixers[])
{
#ifdef CHIP_AU8820
	vortex_connection_mix_adb(vortex, en, 0x11, mixers[0], ADB_CODECOUT(0));
	vortex_connection_mix_adb(vortex, en, 0x11, mixers[1], ADB_CODECOUT(1));
#else
	switch(vortex->eq_route){
	case 0:
		// Connect front channels through EQ.
		vortex_connection_mix_adb(vortex, en, 0x11, mixers[0], ADB_EQIN(0));
		vortex_connection_mix_adb(vortex, en, 0x11, mixers[1], ADB_EQIN(1));
		/* Lower volume, since EQ has some gain. */
		vortex_mix_setvolumebyte(vortex, mixers[0], 0);
		vortex_mix_setvolumebyte(vortex, mixers[1], 0);
		vortex_route(vortex, en, 0x11, ADB_EQOUT(0), ADB_CODECOUT(0));
		vortex_route(vortex, en, 0x11, ADB_EQOUT(1), ADB_CODECOUT(1));
		/* Check if reg 0x28 has SDAC bit set. */
		if (VORTEX_IS_QUAD(vortex)) {
			/* Rear channel. Note: ADB_CODECOUT(0+2) and (1+2) is for AC97 modem
*/
			vortex_connection_mix_adb(vortex, en, 0x11, mixers[2],
ADB_CODECOUT(4));
			vortex_connection_mix_adb(vortex, en, 0x11, mixers[3],
ADB_CODECOUT(5));
		}
		break;
	case 1:
		vortex_connection_mix_adb(vortex, en, 0x11, mixers[0],
ADB_CODECOUT(0));
		vortex_connection_mix_adb(vortex, en, 0x11, mixers[1],
ADB_CODECOUT(1));
		if (VORTEX_IS_QUAD(vortex)) {
			vortex_connection_mix_adb(vortex, en, 0x11, mixers[2],
ADB_CODECOUT(4));
			vortex_connection_mix_adb(vortex, en, 0x11, mixers[3],
ADB_CODECOUT(5));
		}
		break;
	case 2:
		// Connect front channels
		vortex_connection_mix_adb(vortex, en, 0x11, mixers[0],
ADB_CODECOUT(0));
		vortex_connection_mix_adb(vortex, en, 0x11, mixers[1],
ADB_CODECOUT(1));
		// Connect rear channels through EQ.
		vortex_connection_mix_adb(vortex, en, 0x11, mixers[2], ADB_EQIN(0));
		vortex_connection_mix_adb(vortex, en, 0x11, mixers[3], ADB_EQIN(1));
		/* Lower volume, since EQ has some gain. */
		vortex_mix_setvolumebyte(vortex, mixers[2], 0);
		vortex_mix_setvolumebyte(vortex, mixers[3], 0);
		vortex_route(vortex, en, 0x11, ADB_EQOUT(0), ADB_CODECOUT(4));
		vortex_route(vortex, en, 0x11, ADB_EQOUT(1), ADB_CODECOUT(5));
		break;
	};
#endif
}

static void
vortex_connect_codecrec(vortex_t * vortex, int en, unsigned char mixin0,
			unsigned char mixin1)
{
	/*
	   Enable: 0x1, 0x1
	   Channel: 0x11, 0x11
	   ADB Source address: 0x48, 0x49
	   Destination Asp4Topology_0x9c,0x98
	 */
	if ( vortex->eq_route == 1 ) {
		// Connect rear channels through EQ.
		vortex_connection_mix_adb(vortex, en, 0x11, ADB_CODECIN(0),
ADB_EQIN(0));
		vortex_connection_mix_adb(vortex, en, 0x11, ADB_CODECIN(1),
ADB_EQIN(1));
		/* Lower volume, since EQ has some gain. */
		vortex_mix_setvolumebyte(vortex, mixin0, 0);
		vortex_mix_setvolumebyte(vortex, mixin1, 0);
		vortex_route(vortex, en, 0x11, ADB_EQOUT(0), mixin0);
		vortex_route(vortex, en, 0x11, ADB_EQOUT(1), mixin1));
	}
	else {
		vortex_connection_adb_mixin(vortex, en, 0x11, ADB_CODECIN(0), mixin0);
		vortex_connection_adb_mixin(vortex, en, 0x11, ADB_CODECIN(1), mixin1);
	};
}


It's OK to implement eq_route as a module switch since we can change the
name of the kcontrol when the driver is loaded.

Is it possible to implmenet eq_route as a kcontrol which allow the user to
change the eq_route dynamically after the driver is loaded ?

Will the alsamixer able to detect this change ?

Please note the that above code is not complete, we still need to adjust
the gain of the hardware mixers when a substream is open.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-28-06 12:16 pzad           New Issue                                    
03-30-06 11:01 Raymond        Note Added: 0009028                          
03-30-06 12:50 pzad           Note Added: 0009031                          
03-30-06 13:13 pzad           Note Added: 0009032                          
03-30-06 13:22 Raymond        Note Added: 0009033                          
03-30-06 13:29 Raymond        Note Edited: 0009033                         
03-30-06 13:41 Raymond        Note Edited: 0009033                         
03-31-06 04:36 Raymond        Note Added: 0009041                          
03-31-06 04:50 Raymond        Note Edited: 0009041                         
04-01-06 01:13 Raymond        Note Edited: 0009033                         
04-03-06 19:08 Raymond        Note Added: 0009103                          
04-05-06 18:42 Raymond        Note Added: 0009121                          
04-05-06 18:46 Raymond        Note Edited: 0009121                         
04-05-06 18:50 Raymond        Note Edited: 0009121                         
04-06-06 09:11 Raymond        Note Deleted: 0009103                        
04-06-06 09:44 Raymond        Note Added: 0009124                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
