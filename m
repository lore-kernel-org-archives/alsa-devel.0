From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000483]: alsa-libs samplerate-conversion causes assertion frames <= snd_pcm_mmap_avail
Date: Sun, 20 Mar 2005 13:39:02 +0100
Message-ID: <04953f5caa3008cdafa82b2c26a77651@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CB4BA250
	for <alsa-devel@alsa-project.org>; Sun, 20 Mar 2005 13:39:02 +0100 (MET)
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


The following issue has been UPDATED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=483> 
======================================================================
Reported By:                jwrdegoede
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   483
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             09-06-2004 11:39 CEST
Last Modified:              03-20-2005 13:39 CET
======================================================================
Summary:                    alsa-libs samplerate-conversion causes assertion
frames <= snd_pcm_mmap_avail
Description: 
When running xmame (x.mame.net) with alsa selected for sound output on my
es1688. I get the following error:
pcm.c:5957: snd_pcm_mmap_commit: Assertion frames <=
snd_pcm_mmap_avail(pcm)' failed.

I checked the source for the alsa driver (I'm one of the xmame developers)
and the number of frames it is passing to snd_pcm_writei is always smaller
then or equal to the value
returned by:
err = snd_pcm_status(priv->pcm_handle, status);
/* check err */
frames = snd_pcm_status_get_avail(status);

After some more testing I noticed that alsa returns 22050 as the actual
acquired samplerate, but I know from the oss days that my card can only do
22095 not 22050. So I thought this error might be caused by the
alsa-lib-samplerate conversion code, which appearantly is default enabled
(Fedora feature?)

To test my hypothesis I tried creating an almost empty .asoundrc:
pcm.!default {
type hw
card 0
}

ctl.!default {
type hw
card 0
}

And now alsa-lib returns 22095 as the acquired samplerate and everything
works fine! So IMHO this problem is clearly somewhere in alsa-libs
samplerate conversion.

I've searched the internet for this assertion and I believe this bug has
bitten more people and applications and needs fixing ASAP. (note I'm not
saying this because I need it fixed, since the .asoundrc workaround works
fine for me, but I'm saying this in the general interest)

======================================================================

----------------------------------------------------------------------
 jdthood - 03-19-05 19:26 
----------------------------------------------------------------------
What was in your /etc/asound.conf before you added the .asoundrc?

----------------------------------------------------------------------
 jwrdegoede - 03-19-05 19:51 
----------------------------------------------------------------------
This was quite some time ago currently I have a different computer with a
newer version of my distro (Fedora) but I believe that there was no
/etc/asound.conf . Atleast the current Fedora doesn't have one.

----------------------------------------------------------------------
 Belegdol - 03-20-05 10:39 
----------------------------------------------------------------------
Same problem here. Mandrake 10.1 Official, Gigabyte GA-8IPE1000 Pro-G
motherboard (Intel 865PE). I have no /etc/asound.conf file but I have the
following /etc/asound.state:

state.ICH5 {
	control.1 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Master Playback Switch'
		value true
	}
	control.2 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Master Playback Volume'
		value.0 23
		value.1 23
	}
	control.3 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Center Playback Switch'
		value true
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Center Playback Volume'
		value 24
	}
	control.5 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'LFE Playback Switch'
		value true
	}
	control.6 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'LFE Playback Volume'
		value 24
	}
	control.7 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Surround Playback Switch'
		value.0 true
		value.1 true
	}
	control.8 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Surround Playback Volume'
		value.0 24
		value.1 24
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Master Mono Playback Switch'
		value true
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Master Mono Playback Volume'
		value 31
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'PC Speaker Playback Switch'
		value true
	}
	control.12 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name 'PC Speaker Playback Volume'
		value 12
	}
	control.13 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Phone Playback Switch'
		value true
	}
	control.14 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Phone Playback Volume'
		value 24
	}
	control.15 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Playback Switch'
		value false
	}
	control.16 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Mic Playback Volume'
		value 0
	}
	control.17 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Boost (+20dB)'
		value false
	}
	control.18 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Line Playback Switch'
		value true
	}
	control.19 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Line Playback Volume'
		value.0 24
		value.1 24
	}
	control.20 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'CD Playback Switch'
		value true
	}
	control.21 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'CD Playback Volume'
		value.0 28
		value.1 28
	}
	control.22 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Aux Playback Switch'
		value true
	}
	control.23 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Aux Playback Volume'
		value.0 24
		value.1 24
	}
	control.24 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'PCM Playback Switch'
		value true
	}
	control.25 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'PCM Playback Volume'
		value.0 28
		value.1 28
	}
	control.26 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Mic
		comment.item.1 CD
		comment.item.2 Video
		comment.item.3 Aux
		comment.item.4 Line
		comment.item.5 Mix
		comment.item.6 'Mix Mono'
		comment.item.7 Phone
		iface MIXER
		name 'Capture Source'
		value.0 Mic
		value.1 Mic
	}
	control.27 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Capture Switch'
		value true
	}
	control.28 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name 'Capture Volume'
		value.0 12
		value.1 12
	}
	control.29 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Mix
		comment.item.1 Mic
		iface MIXER
		name 'Mono Output Select'
		value Mix
	}
	control.30 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Mic1
		comment.item.1 Mic2
		iface MIXER
		name 'Mic Select'
		value Mic1
	}
	control.31 {
		comment.access read
		comment.type IEC958
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value
'0fff000f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.32 {
		comment.access read
		comment.type IEC958
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value
cf00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
	}
	control.33 {
		comment.access 'read write'
		comment.type IEC958
		iface MIXER
		name 'IEC958 Playback Default'
		value
'0082000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.34 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'IEC958 Playback Switch'
		value false
	}
	control.35 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 3'
		iface MIXER
		name 'IEC958 Playback AC97-SPSA'
		value 0
	}
	control.36 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Duplicate Front'
		value true
	}
	control.37 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Line-In As Surround'
		value true
	}
	control.38 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic As Center/LFE'
		value true
	}
	control.39 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'IEC958 Capture Switch'
		value true
	}
	control.40 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'IEC958 Input Monitor'
		value false
	}
	control.41 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 PCM
		comment.item.1 'Analog In'
		comment.item.2 'IEC958 In'
		iface MIXER
		name 'IEC958 Playback Route'
		value PCM
	}
	control.42 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'External Amplifier'
		value true
	}
}

HTH



Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-06-04 11:39 jwrdegoede     New Issue                                    
03-19-05 19:26 jdthood        Note Added: 0004067                          
03-19-05 19:51 jwrdegoede     Note Added: 0004068                          
03-20-05 09:43 Belegdol       Note Added: 0004075                          
03-20-05 10:12 Belegdol       Note Edited: 0004075                         
03-20-05 10:39 Belegdol       Note Edited: 0004075                         
03-20-05 13:39 perex          Category                 ordinary pcm => pcm -
digital audio
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
