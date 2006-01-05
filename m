From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001717]: Alsa gives no 5.1 surround on Audigy 2 value pci card
Date: Thu, 5 Jan 2006 09:32:15 +0100
Message-ID: <145ec9d0c7d37411bdaae3c8ab3d667e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 37D75175
	for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2006 09:32:16 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1717> 
======================================================================
Reported By:                piezo
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1717
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 4
Kernel Version:             2.6.11-1.1369
======================================================================
Date Submitted:             01-05-2006 03:19 CET
Last Modified:              01-05-2006 09:32 CET
======================================================================
Summary:                    Alsa gives no 5.1 surround on Audigy 2 value pci
card
Description: 
Installed Alsa rpm's for Fedora core 4 (2.6)
- Installed ok

Ran alsaconf
- detected and setup ok

unmuted  "Audigy Analog/Digital Output Jack" using alsamixer
(this enables the soundcard to produce sound for some reason)

ran xine 
changed settings
- audio driver to use = alsa
- speaker setup = Surround 5.1

xine gives an error of another program using the PCM device.

I put this in /etc/asound.conf

********* start *********

# vim:noet:ts=8:sw=2
# Updated 050916, notes {at} notes.for.sabi.co.UK

# Syntax described in these links:
#   http://ALSA-project.org/alsa-doc/alsa-lib/conf.html"
#   http://ALSA-project.org/alsa-doc/alsa-lib/confarg.html"
#   http://ALSA-project.org/alsa-doc/alsa-lib/conffunc.html 
#   http://ALSA-project.org/alsa-doc/alsa-lib/confhooks.html

# In this file I use a style similar to the one I use for CSS style
sheets.

# It may also help to read:
#   http://WWW.sabi.co.UK/Notes/linuxSoundALSA.html

# Also check carefully the contents of '/usr/share/alsa/alsa.conf',
# especially for the one liners defining standard device names
# and attributes.
 
# The device names "default", "dsp0", "mixer0" have special meanings.

# Standard channel number assignments:

#   0 front left	1 front right,
#   2 rear left		3 rear right
#   4 center		5 lfe/subwoofer
#   6 side left		7 side right

########################################################################

# Direct access to the hardware PCM and mixer devices

pcm.card0		{ type hw; card 0; }
ctl.card0		{ type hw; card 0; }

########################################################################

# Read very carefully the ALSA PCM plugin page at:
#   http://www.alsa-project.org/alsa-doc/alsa-lib/pcm_plugins.html

# For the 'asym', 'dsnoop', 'dmix' plugins also read:
#   http://ALSA.OpenSrc.org/index.php?page=asym
#   http://ALSA.OpenSrc.org/index.php?page=dsnoop
#   http://ALSA.OpenSrc.org/index.php?page=DmixPlugin

########################################################################

# The top level shared pseudo device, with both PCM and CTL interfaces
# The ALSA default is "default", but many programs like XMMS and 'aoss'
# assume "dsp0" as default name for PCM and "mixer0" for CTL.

# Amazingly, XMMS has problems if one defines 'pcm.dsp0' to be
# 'plug' for 'pcm.asym0' and not directly as 'asym'.

pcm.!default		{ type			asym;
			  capture.pcm		"dsnoop0";
			  playback.pcm		"dmix0"; }
ctl.!default		{ type hw; card 0; }

########################################################################

pcm.dsp0		{ type			asym;
			  capture.pcm		"dsnoop0";
			  playback.pcm		"dmix0"; } 
ctl.dsp0		{ type hw; card 0; }
ctl.mixer0		{ type hw; card 0; }

# Just trying: probably wrong.
pcm.digi0		{ type			iec958;
			  slave.pcm		"hw:0,2"; }
ctl.digi0		{ type hw; card 0; }

########################################################################

# The two detailed card configurations are for generic 2 to 5.1 channel
# chipsets. It is assumed that both cards need software sharing, and can
# only natively handle 48000Hz.

# These assumptions are fairly typical of recent (2004) low end and
# on-motherboard cards and chipsets, and their configs are not really
# specific to either models.

########################################################################


#							CARD 0 SW MIXING
#							################

pcm.asym0		{ type			asym;
			  capture.pcm		"dsnoop0";
			  playback.pcm		"dmix0"; }

pcm.dsnoop0		{ type			dsnoop;
			  ipc_key		13758;
			  slave.pcm		"hw:0,0"; }

# Buffering (period time defaults to 125000 usecs).

# Size of period, expressed either in usec or byte units:
#   period_time	USECS
#   period_size	BYTES

# Size of buffers, expressed either in period, usec, or byte units:
#   periods	PERIODS
#   buffer_time	USECS
#   buffer_size	BYTES

# The ALSA docs have examples with 'period_time' set to 0,
# when 'period_size' and 'buffer_size' are used instead,
# but this can cause trouble in later releases of ALSA.

# For OSS compatibility, 'period_size' and 'buffer_size'
# should be powers of 2. Also, many cards cannot accept
# a 'period_size' much greater than 4096, so 4096 is safe.
# On my VIA 8233A, any value for 'period_time' greater than
# 85333 usecs (precisely!) causes hiccups in sound output.
# Why? At 48kHz, 85333 usec are are just over 4096 bytes/channel.

pcm.dmix0		{ type			dmix;
			  ipc_key		13759;

			  slave.pcm		"hw:0";
			  slave.channels	2;
			  slave.rate		48000;

			  slave.period_size	4096;
			  slave.buffer_size	81920;

			  slave.period_time	84000;
			  slave.buffer_time	504000;

			  bindings.0		0;
			  bindings.1		1; }

pcm.dmix0-40		{ type			dmix;
			  ipc_key		13761;

			  slave.pcm		"hw:0";
			  slave.channels	4;
			  slave.rate		48000;

			  slave.period_size	4096;
			  slave.buffer_size	81920;

			  slave.period_time	84000;
			  slave.buffer_time	504000;

			  bindings.0		0;
			  bindings.1		1;
			  bindings.2		2;
			  bindings.3		3; }

pcm.dmix0-51		{ type			dmix;
			  ipc_key		13761;

			  slave.pcm		"hw:0";
			  slave.channels	6;
			  slave.rate		48000;

			  slave.period_size	4096;
			  slave.buffer_size	81920;

			  slave.period_time	84000;
			  slave.buffer_time	504000;

			  bindings.0		0;
			  bindings.1		1;
			  bindings.2		2;
			  bindings.3		3;
			  bindings.4		4;
			  bindings.5		5; }

########################################################################

#							4 CHANNEL AS 2 STEREO
#							#####################

# Using one four channel card as two stereo cards.
#   http://ALSA.OpenSrc.org/index.php?page=.asoundrc

#################
# 1st card, front

pcm.card0-f		{ type			route;

			  slave.pcm		"hw:0,0";
			  slave.channels	2;

			  ttable.0.0		1.0;
			  ttable.1.1		1.0; }

# Not quite right.
ctl.card0-f		{ type hw; card 0; }

################
# 1st card, rear

# Note that all (some?) USB sound device config do not define the
# 'surroundXY' style name, so substitute the equivalent 'hw' name.

pcm.card0-r		{ type			route;
			  slave.pcm		"surround40:0";
			  slave.channels	4;

			  ttable.0.2		1.0;
			  ttable.1.3		1.0; }

# Not quite right
ctl.card0-r		{ type hw, card 0; }

######################################
# 1st card, sides (often on a 2nd DAC)

pcm.card0-s		{ type			route;
			  slave.pcm		"surround71:0";
			  slave.channels	8;

			  ttable.0.6		1.0;
			  ttable.1.7		1.0; }

# Not quite right
ctl.card0-s		{ type hw, card 0; }

########################################################################

#							STEREO TO 4 OR 5.1
#							##################

# Distribute 2 channel stereo to 4 or 5.1 surround channels
# 'surround40' and 'surround51' should be predefined.
#   http://ALSA.OpenSrc.org/index.php?page=FAQ028
#   http://ALSA.OpenSrc.org/index.php?page=SurroundSound

# 'table.X.Y Z' means add channel 'X' multiplied by 'Z' to 'Y'.

# Probably does not support sharing, stack 'dsnoop' on top for that.

# Note that all (some?) USB sound device config do not define the
# 'surroundXY' style name, so substitute the equivalent 'hw' name.

##########
# 1st card

pcm.stereo0-40		{ type			route;

			  slave.pcm		"dmix0-40";
			  slave.channels	4;

			  ttable.0.0		1.0;
			  ttable.0.2		0.8;

			  ttable.1.1		1.0;
			  ttable.1.3		0.8; }

ctl.stereo0-40		{ type hw; card 0; }


pcm.stereo0-51		{ type			route;

			  slave.pcm		"dmix0-51";
			  slave.channels	6;

			  ttable.0.0		1.0;
			  ttable.0.2		0.8;
			  ttable.0.4		0.4;
			  ttable.0.5		0.4;

			  ttable.1.1		1.0;
			  ttable.1.3		0.8;
			  ttable.1.4		0.4;
			  ttable.1.5		0.4; }

ctl.stereo0-51		{ type hw; card 0; }

########################################################################;

#							2 CARDS AS 1
#							############

# Using multiple cards to simulate a single card is usually a bad idea
# because they have different latencies and multichannel sound can come
# out with quite a bit of skew. Some people however have a legitimate
# need for this.

# Using two cards as one four channel card.
#   http://ALSA.OpenSrc.org/index.php?page=TwoCardsAsOne

######################################
# 1st >= 2 channels, 2nd >= 2 channels

pcm.multi4		{ type			multi;

			  # could be "dmix0"
			  slaves.a.pcm		"hw:0,0";
			  slaves.a.channels	2;

			  # could be "dmix1"
			  slaves.b.pcm		"hw:1,0";
			  slaves.b.channels	2;

			  bindings.0.slave	a;
			  bindings.0.channel	0;

			  bindings.1.slave	a;
			  bindings.1.channel	1;

			  bindings.2.slave	b;
			  bindings.2.channel	0;

			  bindings.3.slave	b;
			  bindings.3.channel	1; }

ctl.multi4		{ type hw; card 0; }

# Using two cards as one 5.1 channel card, the first has
# 2 channels and the second has 4 channels, and viceversa.
#   http://ALSA.OpenSrc.org/index.php?page=TwoCardsAsOne

######################################
# 1st >= 2 channels, 2nd >= 4 channels

pcm.multi51-24		{ type			multi;

			  # could be "dmix0"
			  slaves.a.pcm		"hw:0,0";
			  slaves.a.channels	2;

			  # could be "dmix1"
			  slaves.b.pcm		"surround40:1";
			  slaves.b.channels	4;

			  bindings.0.slave	a;
			  bindings.0.channel	0;

			  bindings.1.slave	a;
			  bindings.1.channel	1;

			  bindings.2.slave	b;
			  bindings.2.channel	0;

			  bindings.3.slave	b;
			  bindings.3.channel	1;

			  # Center, physically rear left, 2nd card
			  bindings.4.slave	b;
			  bindings.4.channel	2;

			  # LFE/subwoofer, physically rear right, 2nd card
			  bindings.5.slave	b;
			  bindings.5.channel	3; }
# Not quite right.
ctl.multi51-24		{ type hw; card 0; }

######################################
# 1st >= 4 channels, 2nd >= 2 channels

pcm.multi51-42		{ type			multi;

			  # could be "dmix0"
			  slaves.a.pcm		"surround40:0";
			  slaves.a.channels	4;

			  # could be "dmix1"
			  slaves.b.pcm		"hw:1,0";
			  slaves.b.channels	2;

			  bindings.0.slave	a;
			  bindings.0.channel	0;

			  bindings.1.slave	a;
			  bindings.1.channel	1;

			  bindings.2.slave	a;
			  bindings.2.channel	2;

			  bindings.3.slave	a;
			  bindings.3.channel	3;

			  # Center, physically front left, 2nd card
			  bindings.4.slave	b;
			  bindings.4.channel	0;

			  # LFE/subwoofer, physically front right, 2nd card
			  bindings.5.slave	b;
			  bindings.5.channel	1; }
# Not quite right.
ctl.multi51-42		{ type hw; card 0; }

########################################################################;

#							STEREO TO 0 AND 1
#							#################

# Duplicate 2 channel stereo to two 2 channel stereo cards, joined
# together as a single virtual 4 channel card.

pcm.stereo01		{ type			route;

			  slave.pcm		"multi4";
			  slave.channels	4;

			  #   0 front left	1 front right,
			  #   2 rear left	3 rear right

			  # ttable.<source>.<destination>
			  ttable.0.0		1.0;
			  ttable.0.2		1.0;

			  ttable.1.1		1.0;
			  ttable.1.3		1.0; }

ctl.stereo01		{ type hw; card 0; }

########################################################################

#							SW VOLUME CONTROL
#							#################

#pcm.name		{ type			softvol;
#			  slave			STR;
#			  control {
#			    name		STR;
#			      [card		INT;]
#			      [iface		STR;]
#			      [index		INT;]
#			      [device		INT;]
#			      [subdevice	INT;]
#			      [count		INT;]
#			  }
#			}

########################################################################

#							FILE OUTPUT
#							###########

pcm.file0		{ type			file;
			  file			"/tmp/alsa.raw";
			  slave.pcm		"dsp0";
			 #[format		"raw";]
			 #[perm			0600;]
			}
ctl.file0		{ type hw; card 0; }

********* end *********

Can now run xine.

testing sound using "speaker-test -c6"
- only produces sound out the front speakers
- in xine 5.1 DVD's seem to copy front speaker channels to the rear ones 

- adjusting volume controls in alsamixer while playing xine does control
idivitual speakers (Front, Surround, LFE)
but the PCM controls for the same do nothing to the volume.

/etc/modules.conf looks like this

********* start *********

alias eth0 via-rhine

# --- BEGIN: Generated by ALSACONF, do not edit. ---
# --- ALSACONF version 1.0.9rc4a ---
alias snd-card-0 snd-emu10k1
alias sound-slot-0 snd-emu10k1
# --- END: Generated by ALSACONF, do not edit. ---

********* end *********



======================================================================

----------------------------------------------------------------------
 pzad - 01-05-06 09:32 
----------------------------------------------------------------------
Please remove your /etc/asound.conf file, it is complete wrong for your
card. Your card doesn't need it. With this file you can not get more then
stereo sound.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-05-06 03:19 piezo          New Issue                                    
01-05-06 03:19 piezo          Distribution              => Fedora Core 4   
01-05-06 03:19 piezo          Kernel Version            => 2.6.11-1.1369   
01-05-06 09:32 pzad           Note Added: 0007464                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
