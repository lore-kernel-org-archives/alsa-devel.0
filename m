From: Nicolas =?iso-8859-1?Q?Fran=E7ois?= <nicolas.francois@centraliens.net>
Subject: Re: hyphens in man pages
Date: Thu, 7 Oct 2004 20:52:42 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041007185242.GA2404@nekral.homelinux.net>
References: <20041002114505.GA22558@nekral.homelinux.net> <s5h8yaiu123.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h8yaiu123.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Nicolas =?iso-8859-1?Q?Fran=E7ois?= <nicolas.francois@centraliens.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Summary: Fix hyphens in man pages

This patch converts hyphens to minus signs in the man pages (for options,
emails, or command line examples).

This patch also closes one font modifier in iecset.1.
(s/\fIfalse\fI,/\fIfalse\fP,/)

Signed-off-by: Nicolas FRANCOIS <nicolas.francois@centraliens.net>


On Thu, Oct 07, 2004 at 03:09:56PM +0200, Takashi Iwai wrote:
> Thanks for the patch.
> Could you make a patch with the unified diff?
Oops, sorry.

> BTW, is '\-' in the email address a common solution?
> I feel it's originally the correct usage for hypen...

I don't know if it's common, but email addresses really use minus signs,
not hyphens (UTF-8: E2 80 90). So, I think it will be better for anyone
who wants to cut and paste the address.

Kind Regards,
-- 
Nekral

--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="alsa_hyphens.patch"

Index: alsa-lib/test/midifile.3
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/test/midifile.3,v
retrieving revision 1.2
diff -a -u -r1.2 midifile.3
--- alsa-lib/test/midifile.3	12 Mar 2002 20:14:35 -0000	1.2
+++ alsa-lib/test/midifile.3	7 Oct 2004 18:25:55 -0000
@@ -1,6 +1,6 @@
 .TH MIDIFILE 3
 .SH NAME
-mfread,mfwrite - read and write a standard MIDI file
+mfread,mfwrite \- read and write a standard MIDI file
 .SH SYNOPSIS
 \fC#include "mfread.h"
 
@@ -87,7 +87,7 @@
 Before calling \fCmfread\fR, the only
 requirement is that you assign a value
 to \fCMf_getc\fR - a pointer to a function that will return
-characters from the MIDI file, using -1 to indicate EOF.
+characters from the MIDI file, using \-1 to indicate EOF.
 All the rest of the function
 pointers are initialized to NULL, and the default action for each
 is to do nothing.  The following is a complete program using \fCmfread\fR
@@ -269,9 +269,9 @@
 which make up a quarter note.  If bit 15 of division is a one,
 delta-times in a file correspond to subdivisions of a second
 similar to SMPTE and MIDI time code. In this format bits
-14 through 8 contain one of four values - 24, -25, -29, or -30,
+14 through 8 contain one of four values \-24, \-25, \-29, or \-30,
 corresponding to the four standard SMPTE and MIDI time code
-frame per second formats, where -29 represents 30 drop frame.
+frame per second formats, where \-29 represents 30 drop frame.
 The second byte consisting of bits 7 through 0 corresponds
 the the resolution within a frame.  Refer the Standard MIDI Files 
 1.0 spec for more details.
@@ -305,9 +305,9 @@
        data[0] = i; /* note number */
        data[1] = 64; /* velocity */
        if(!mf_write_midi_event(480,note_on,1,data,2)) 
-	   return(-1);
+	   return(\-1);
        if(!mf_write_midi_event(480,note_off,1,data,2)) 
-           return(-1);
+           return(\-1);
     }
 
     return(1);
Index: alsa-oss/alsa/aoss.1
===================================================================
RCS file: /cvsroot/alsa/alsa-oss/alsa/aoss.1,v
retrieving revision 1.4
diff -a -u -r1.4 aoss.1
--- alsa-oss/alsa/aoss.1	13 Aug 2004 12:26:52 -0000	1.4
+++ alsa-oss/alsa/aoss.1	7 Oct 2004 18:25:55 -0000
@@ -43,5 +43,5 @@
 .TP
 
 .SH AUTHORS
-The OSS compatibility library is by Abramo Bagnara <abramo@alsa-project.org>.
+The OSS compatibility library is by Abramo Bagnara <abramo@alsa\-project.org>.
 The aoss script and this document are by James Tappin <james@xena.uklinux.net>.
Index: alsa-tools/envy24control/envy24control.1
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/envy24control/envy24control.1,v
retrieving revision 1.7
diff -a -u -r1.7 envy24control.1
--- alsa-tools/envy24control/envy24control.1	16 May 2004 13:36:30 -0000	1.7
+++ alsa-tools/envy24control/envy24control.1	7 Oct 2004 18:25:56 -0000
@@ -4,7 +4,7 @@
 soundcards, under ALSA.
 
 .SH SYNOPSIS
-\fBenvy24control\fP [\fI-c\fP card-number] [\fI-D\fP control-name] [\fI-o\fP 0-num DACs max 8] [\fI-i\fP 0-num ADCs max 8] [\fI-p\fP 0-8] [\fI-s\fP 0-2] [\fI-f\fP <profiles file name>] [\fI-v\fP] [<profile number>|<profile name>]
+\fBenvy24control\fP [\fI\-c\fP card-number] [\fI\-D\fP control-name] [\fI\-o\fP 0-num DACs max 8] [\fI\-i\fP 0-num ADCs max 8] [\fI\-p\fP 0-8] [\fI\-s\fP 0-2] [\fI\-f\fP <profiles file name>] [\fI\-v\fP] [<profile number>|<profile name>]
 
 .SH DESCRIPTION
 \fBenvy24control\fP allows control of the digital mixer, channel gains
@@ -14,47 +14,47 @@
 
 .SH INVOKING
 
-\fBenvy24control\fP [\fI-c\fP card-number] [\fI-D\fP control-name] [\fI-o\fP 0-num DACs max 8] [\fI-i\fP 0-num ADCs max 8] [\fI-p\fP 0-8] [\fI-s\fP 0-2] [\fI-f\fP <profiles file name>] [\fI-v\fP] [<profile number>|<profile name>]
+\fBenvy24control\fP [\fI\-c\fP card-number] [\fI\-D\fP control-name] [\fI\-o\fP 0-num DACs max 8] [\fI\-i\fP 0-num ADCs max 8] [\fI\-p\fP 0-8] [\fI\-s\fP 0-2] [\fI\-f\fP <profiles file name>] [\fI\-v\fP] [<profile number>|<profile name>]
 .TP
 If no control-name is given, then the first sound card is used.
 
 .SS Options
 .TP
-\fI-c\fP card-number
+\fI\-c\fP card-number
 Use the card specified by card-number rather than the first card.
-This is equivalent with \fI-Dhw:n\fP option where \fIn\fP is the card number.
+This is equivalent with \fI\-Dhw:n\fP option where \fIn\fP is the card number.
 .TP
-\fI-D\fP control-name
+\fI\-D\fP control-name
 Use the card specified by control-name rather than the first card,
 normally this will be of the form hw:\fIn\fP where \fIn\fP is the sound
 card number (zero-based). This is only needed if you have more than one
 Envy24-based card or if your Envy24 card is not configured as the first
 card in your ALSA driver setup.
 .TP
-\fI-o\fP outputs
+\fI\-o\fP outputs
 Limit number of analog line outputs to display.  Default is the number of
 DACs in the driver specification. Maximum is 8.
 The number of analog output lines can only be reduced from the available
 number of output lines.
 .TP
-\fI-i\fP inputs
+\fI\-i\fP inputs
 Limit number of analog line inputs to display.  Default is the number of
 ADCs in the driver specification. Maximum is 8.
 The number of analog input lines can only be reduced from the available
 number of input lines.
 .TP
-\fI-p\fP pcm outputs
+\fI\-p\fP pcm outputs
 Limit number of PCM outputs to display.  Default is 8.
 .TP
-\fI-s\fP spdif inputs/outputs
+\fI\-s\fP spdif inputs/outputs
 Limit number of SPDIF inputs/outputs to display.  Default is 2.
 .TP
-\fI-f\fP name and path of the profiles file name.
+\fI\-f\fP name and path of the profiles file name.
 From/to this file will envy24control read/write the alsactl settings.
 If is not given DEFAULT_PROFILERC or for restore if DEFAULT_PROFILERC
 doesn't exists SYS_PROFILERC will be used.
 .TP
-\fI-v\fP view spdif playback channels in the mixer.
+\fI\-v\fP view spdif playback channels in the mixer.
 It is not possible to manage something (muting, volume levels).
 It is only to view the levelmeters.
 Default is no view of spdif playback channels in the mixer.
@@ -69,4 +69,4 @@
 .SH AUTHOR
 \fBenvy24control\fP is  by Jaroslav Kysela <perex@suse.cz>
 This document is by James Tappin <james@xena.uklinux.net>.
-Last updated by Dirk Kalis <dirk.kalis@t-online.de>.
+Last updated by Dirk Kalis <dirk.kalis@t\-online.de>.
Index: alsa-tools/sb16_csp/cspctl.1
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/sb16_csp/cspctl.1,v
retrieving revision 1.1
diff -a -u -r1.1 cspctl.1
--- alsa-tools/sb16_csp/cspctl.1	5 Jun 2001 06:49:09 -0000	1.1
+++ alsa-tools/sb16_csp/cspctl.1	7 Oct 2004 18:25:58 -0000
@@ -12,7 +12,7 @@
 is a simple CSP microcode loader for Crative Sound Blaster 16ASP and some Sound Blaster AWE32 sound cards with Creative Signal Processor (CSP) chip (CT1748A) installed.
 .B cspctl
 can also be used as a post-install function to
-.I snd-sb16-csp
+.I snd\-sb16\-csp
 module to load default codec at module installation. If CSP chip is succesfully detected and initialized, it will be installed as a hardware dependant device
 .I hwC0D2
 into /dev/snd directory. Currently, following codecs can be loaded to CSP device:
@@ -45,14 +45,14 @@
 .B one function.
 To load for example function #2 from QSound microcode file (decoder for 22050Hz), run as follows:
 .IP "" 4
-% cspctl load -f 2 -d QSound wfm0001a.csp
+% cspctl load \-f 2 \-d QSound wfm0001a.csp
 .PP
 After successful loading, /proc/asound/SB16/cspD2 will show:
 .IP "" 4
 .Sp
 .nf
 Creative Signal Processor [v1.0]
-State: -x--L
+State: \-x\-\-L
 Codec: QSound [func #2]
 Sample rates: 22050Hz
 QSound decoder disabled
@@ -66,7 +66,7 @@
 .Sp
 .nf
 Creative Signal Processor [v1.0]
-State: Qx-RL
+State: Qx\-RL
 Codec: QSound [func #2]
 Sample rates: 22050Hz
 QSound decoder enabled
@@ -84,10 +84,10 @@
 .Sp
 .nf
 Creative Signal Processor [v1.0]
-State: -x--L
-Codec: IMA-ADPCM [func #2]
+State: \-x\-\-L
+Codec: IMA\-ADPCM [func #2]
 Sample rates: All
-PCM format ID: 0x400000 (16bit/-) [mono/stereo] [playback/-]
+PCM format ID: 0x400000 (16bit/\-) [mono/stereo] [playback/\-]
 .Sp
 .fi
 .PP
@@ -100,7 +100,7 @@
 Unload microcode from CSP.
 .SH OPTIONS
 .TP
-.B \-h, --help
+.B \-h, \-\-help
 Display a short help.
 .TP
 .B \-c card
@@ -113,7 +113,7 @@
 Optional microcode description string.
 
 .SH AUTHOR
-Uros Bizjak <uros@kss-loka.si>.
+Uros Bizjak <uros@kss\-loka.si>.
 
 
 
Index: alsa-utils/alsaconf/alsaconf.8
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/alsaconf/alsaconf.8,v
retrieving revision 1.2
diff -a -u -r1.2 alsaconf.8
--- alsa-utils/alsaconf/alsaconf.8	31 Aug 2004 16:27:25 -0000	1.2
+++ alsa-utils/alsaconf/alsaconf.8	7 Oct 2004 18:25:58 -0000
@@ -52,7 +52,7 @@
 This option is obsolete in the recent ALSA version.
 .TP
 .B \-r, \-\-strict
-Set strict device mode (equiv. with -g 17 -d 0660).
+Set strict device mode (equiv. with \-g 17 \-d 0660).
 This option is obsolete in the recent ALSA version.
 .TP
 .B \-L, \-\-log file
@@ -79,7 +79,7 @@
 audio group) and the default device mode is 0660.
 
 For the ALSA base package, see also
-.I /usr/share/doc/alsa-base/
+.I /usr/share/doc/alsa\-base/
 
 .SH SEE ALSO
 \fB
@@ -90,7 +90,7 @@
 \fP
 
 .SH HOMEPAGE
-http://www.alsa-project.org/
+http://www.alsa\-project.org/
 
 .SH AUTHOR
 The alsaconf script was written by
Index: alsa-utils/alsactl/alsactl.1
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/alsactl/alsactl.1,v
retrieving revision 1.6
diff -a -u -r1.6 alsactl.1
--- alsa-utils/alsactl/alsactl.1	6 Sep 2002 15:21:01 -0000	1.6
+++ alsa-utils/alsactl/alsactl.1	7 Oct 2004 18:25:58 -0000
@@ -29,29 +29,29 @@
 .SS Options
 
 .TP
-\fI-h, --help\fP 
+\fI\-h, \-\-help\fP 
 Help: show available flags and commands.
 
 .TP
-\fI-f, --file\fP
+\fI\-f, \-\-file\fP
 Select the configuration file to use. The default is /etc/asound.state
 
 .TP
-\fI-F, --force\fP
+\fI\-F, \-\-force\fP
 Used with restore command.  Try to restore the matching control elements
 as much as possible.
 
 .TP
-\fI-d, --debug\fP
+\fI\-d, \-\-debug\fP
 Use debug mode: a bit more verbose.
 
 .TP
-\fI-v, --version\fP
+\fI\-v, \-\-version\fP
 Print alsactl version number.
 
 .SH FILES
 \fI/etc/asound.state\fP (or whatever file you specify with the
-\fB-f\fP flag) is used to store current settings for your
+\fB\-f\fP flag) is used to store current settings for your
 soundcards. The settings include all the usual soundcard mixer
 settings.  More importantly, alsactl is
 capable of controlling other card-specific features that mixer apps
@@ -75,4 +75,4 @@
 
 .SH AUTHOR
 \fBalsactl\fP is by Jaroslav Kysela <perex@suse.cz> and Abramo Bagnara
-<abramo@alsa-project.org>. This document is by Paul Winkler <zarmzarm@erols.com>.
+<abramo@alsa\-project.org>. This document is by Paul Winkler <zarmzarm@erols.com>.
Index: alsa-utils/alsamixer/alsamixer.1
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/alsamixer/alsamixer.1,v
retrieving revision 1.10
diff -a -u -r1.10 alsamixer.1
--- alsa-utils/alsamixer/alsamixer.1	24 Sep 2004 10:00:42 -0000	1.10
+++ alsa-utils/alsamixer/alsamixer.1	7 Oct 2004 18:25:59 -0000
@@ -16,24 +16,24 @@
 .SS Options
 
 .TP
-\fI-h, -help\fP 
+\fI\-h, \-help\fP 
 Help: show available flags.
 
 .TP
-\fI-c\fP <card number or idenfication>
+\fI\-c\fP <card number or idenfication>
 Select the soundcard to use, if you have more than one. Cards are
 numbered from 0 (the default).
 
 .TP
-\fI-D\fP <device identification>
+\fI\-D\fP <device identification>
 Select the mixer device to control.
 
 .TP
-\fI-g\fP <toggle color settings>
+\fI\-g\fP <toggle color settings>
 Toggle the using of colors.
 
 .TP
-\fI-s\fP <minimize mixer window>
+\fI\-s\fP <minimize mixer window>
 Minimize the mixer window.
 
 .SH KEYBOARD COMMANDS
@@ -49,7 +49,7 @@
 also use \fIn\fP ("next") and \fIp\fP ("previous").
 
 The \fIUp\fP and \fIDown Arrows\fP control the volume for the
-currently selected device. You can also use \fI+\fP or \fI-\fP for the
+currently selected device. You can also use \fI+\fP or \fI\-\fP for the
 same purpose. Both the left and right signals are affected. For
 independent left and right control, see below.
  
Index: alsa-utils/amidi/amidi.1
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/amidi/amidi.1,v
retrieving revision 1.4
diff -a -u -r1.4 amidi.1
--- alsa-utils/amidi/amidi.1	9 Jul 2004 07:09:28 -0000	1.4
+++ alsa-utils/amidi/amidi.1	7 Oct 2004 18:25:59 -0000
@@ -28,41 +28,41 @@
 .I options
 
 Use the
-.I -h,
-.I -V,
-.I -l,
+.I \-h,
+.I \-V,
+.I \-l,
 or
-.I -L
+.I \-L
 options to display information;
 or use at least one of the
-.I -s,
-.I -r,
-.I -S,
+.I \-s,
+.I \-r,
+.I \-S,
 or
-.I -d
+.I \-d
 options to specify what data to send or receive.
 
 .SS Options
 
 .TP
-.I -h, --help
+.I \-h, \-\-help
 Help: prints a list of options.
 
 .TP
-.I -V, --version
+.I \-V, \-\-version
 Prints the current version.
 
 .TP
-.I -l, --list-devices
+.I \-l, \-\-list\-devices
 Prints a list of all hardware MIDI ports.
 
 .TP
-.I -L, --list-rawmidis
+.I \-L, \-\-list\-rawmidis
 Prints all RawMIDI definitions.
 (used when debugging configuration files)
 
 .TP
-.I -p, --port=name
+.I \-p, \-\-port=name
 Sets the name of the ALSA RawMIDI port to use.
 If this is not specified,
 .B amidi
@@ -70,14 +70,14 @@
 (the default for this is port 0 on card 0, which may not exist).
 
 .TP
-.I -s, --send=filename
+.I \-s, \-\-send=filename
 Sends the contents of the specified file to the MIDI port.
 The file must contain raw MIDI commands (e.g. a .syx file);
 for Standard MIDI (.mid) files, use
 .B aplaymidi(1).
 
 .TP
-.I -r, --receive=filename
+.I \-r, \-\-receive=filename
 Writes data received from the MIDI port into the specified file.
 The file will contain raw MIDI commands (such as in a .syx file);
 to record a Standard MIDI (.mid) file, use
@@ -85,24 +85,24 @@
 
 .B amidi
 will filter out any Active Sensing bytes (FEh), unless the
-.I -a
+.I \-a
 option has been given.
 
 .TP
-.I -S, --send-hex="..."
+.I \-S, \-\-send\-hex="..."
 Sends the bytes specified as hexadecimal numbers to the MIDI port.
 
 .TP
-.I -d, --dump
+.I \-d, \-\-dump
 Prints data received from the MIDI port as hexadecimal bytes.
 Active Sensing bytes (FEh) will not be shown, unless the
-.I -a
+.I \-a
 option has been given.
 
 This option is useful for debugging.
 
 .TP
-.I -t, --timeout=seconds
+.I \-t, \-\-timeout=seconds
 Stops receiving data when no data has been received for the specified
 amount of time.
 
@@ -111,25 +111,25 @@
 to stop receiving data.
 
 .TP
-.I -a, --active-sensing
+.I \-a, \-\-active\-sensing
 Does not ignore Active Sensing bytes (FEh) when saving or printing
 received MIDI commands.
 
 .SH EXAMPLES
 
 .TP
-.B amidi -p hw:0 -s my_settings.syx
+.B amidi \-p hw:0 \-s my_settings.syx
 will send the MIDI commands in
 .I my_settings.syx
 to port
 .I hw:0.
 
 .TP
-.B amidi -S 'F0 43 10 4C 00 00 7E 00 F7'
+.B amidi \-S 'F0 43 10 4C 00 00 7E 00 F7'
 sends an XG Reset to the default port.
 
 .TP
-.B amidi -p hw:1,2 -S F0411042110C000000000074F7 -r dump.syx -t 1
+.B amidi \-p hw:1,2 \-S F0411042110C000000000074F7 \-r dump.syx \-t 1
 sends a \(lqParameter Dump Request\(rq to a GS device, saves the received
 parameter data to the file
 .I dump.syx,
@@ -137,7 +137,7 @@
 (when no data has been received for one second).
 
 .TP
-.B amidi -p virtual -d
+.B amidi \-p virtual \-d
 creates a virtual RawMIDI port and prints all data sent to this port.
 
 .SH FILES
@@ -152,7 +152,7 @@
 
 .SH BUGS
 The
-.I --list-devices
+.I \-\-list\-devices
 option pretends that output and input ports are the same.
 
 .SH SEE ALSO
Index: alsa-utils/amixer/amixer.1
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/amixer/amixer.1,v
retrieving revision 1.11
diff -a -u -r1.11 amixer.1
--- alsa-utils/amixer/amixer.1	24 Sep 2004 09:49:57 -0000	1.11
+++ alsa-utils/amixer/amixer.1	7 Oct 2004 18:26:00 -0000
@@ -2,7 +2,7 @@
 .SH NAME
 amixer \- command-line mixer for ALSA soundcard driver
 .SH SYNOPSIS
-\fBamixer\fP [\fI-c\fP card] [\fIcmd\fP]
+\fBamixer\fP [\fI\-c\fP card] [\fIcmd\fP]
 .SH DESCRIPTION
 \fBamixer\fP allows command-line control of the mixer for the ALSA
 soundcard driver.
@@ -38,7 +38,7 @@
 The parameters \fIcap, nocap, mute, unmute, toggle\fP are used to
 change capture (recording) and muting for the group specified.
 The parameters \fIfront, rear, center, woofer\fP are used to specify
-channels to be changed. When plus(+) or minus(-) letter is appended after
+channels to be changed. When plus(+) or minus(\-) letter is appended after
 volume value, the volume is incremented or decremented from the current
 value, respectively.
 
@@ -74,28 +74,28 @@
 .SS Options
 
 .TP
-[\fI-c\fP card]
+[\fI\-c\fP card]
 
 Select the card number to control. The device name created from this
 parameter has syntax 'hw:N' where N is specified card number.
 
 .TP
-[\fI-D\fP device]
+[\fI\-D\fP device]
 
 Select the device name to control. The default control name is 'default'.
 
 .TP
-\fI-h\fP 
+\fI\-h\fP 
 Help: show syntax.
 .TP
-\fI-q\fP
+\fI\-q\fP
 Quiet mode. Do not show results of changes.
 
 .SS
 Example #1:
 
 .TP
-\fBamixer -c 1 sset Line,0 80%,40% unmute cap\fR
+\fBamixer \-c 1 sset Line,0 80%,40% unmute cap\fR
 will set the second soundcard's left line input volume to 80% and
 right line input to 40%, unmute it, and select it as a source for
 capture (recording).\fR
@@ -104,14 +104,14 @@
 Example #2:
 
 .TP
-\fBamixer -c 2 cset iface=MIXER,name='Line Playback Volume",index=1 40%\fR
+\fBamixer \-c 2 cset iface=MIXER,name='Line Playback Volume",index=1 40%\fR
 will set the third soundcard's second line playback volume(s) to 40%
 
 .SS
 Example #3:
 
 .TP
-\fBamixer -c 2 cset numid=34 40%\fR
+\fBamixer \-c 2 cset numid=34 40%\fR
 will set the 34th soundcard element to 40%
 
 .SH BUGS 
Index: alsa-utils/aplay/aplay.1
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/aplay/aplay.1,v
retrieving revision 1.9
diff -a -u -r1.9 aplay.1
--- alsa-utils/aplay/aplay.1	24 Sep 2004 09:51:45 -0000	1.9
+++ alsa-utils/aplay/aplay.1	7 Oct 2004 18:26:00 -0000
@@ -25,31 +25,31 @@
 
 .SS Options
 .TP
-\fI-h, --help\fP
+\fI\-h, \-\-help\fP
 Help: show syntax.
 .TP
-\fI--version\fP
+\fI\-\-version\fP
 Print current version.
 .TP
-\fI-l, --list-devices\fP
+\fI\-l, \-\-list\-devices\fP
 List all soundcards and digital audio devices
 .TP
-\fI-L, --list-pcms\fP
+\fI\-L, \-\-list\-pcms\fP
 List all PCMs defined
 .TP
-\fI-D, --device=NAME\fP
+\fI\-D, \-\-device=NAME\fP
 Select PCM by name
 .TP
-\fI-q --quiet\fP
+\fI\-q \-\-quiet\fP
 Quiet mode. Suppress messages (not sound :))
 .TP
-\fI-t, --file-type TYPE\fP
+\fI\-t, \-\-file\-type TYPE\fP
 File type (voc, wav, raw or au)
 .TP
-\fI-c, --channels=#\fP
+\fI\-c, \-\-channels=#\fP
 The number of channels
 .TP
-\fI-f --format=FORMAT\fP
+\fI\-f \-\-format=FORMAT\fP
 Sample format
 .br
 Recognized sample formats are: S8 U8 S16_LE S16_BE U16_LE U16_BE S24_LE
@@ -61,67 +61,67 @@
 .br
 There are also two format shortcuts available:
 .nf
--f cd (16 bit little endian, 44100, stereo [-f S16_LE -c2 -r44100]
--f dat (16 bit little endian, 48000, stereo) [-f S16_LE -c2 -r48000]
+\-f cd (16 bit little endian, 44100, stereo [\-f S16_LE \-c2 \-r44100]
+\-f dat (16 bit little endian, 48000, stereo) [\-f S16_LE \-c2 \-r48000]
 .fi
 .TP
-\fI-r, --rate=#<Hz>\fP
+\fI\-r, \-\-rate=#<Hz>\fP
 Sampling rate in Hertz.
 .TP
-\fI-d, --duration=#\fP
+\fI\-d, \-\-duration=#\fP
 Interrupt after # seconds.
 A value of zero means infinity.
 The default is zero, so if this option is omitted then the arecord process will run until it is killed.
 .TP
-\fI-s, --sleep-min=#\fP
+\fI\-s, \-\-sleep\-min=#\fP
 Min ticks to sleep
 .TP
-\fI-M, --mmap\fP            
+\fI\-M, \-\-mmap\fP            
 Mmap stream
 .TP
-\fI-N, --nonblock\fP          
+\fI\-N, \-\-nonblock\fP          
 Nonblocking mode
 .TP
-\fI-F, --period-time=#\fP     
+\fI\-F, \-\-period\-time=#\fP     
 Distance between interrupts is # microseconds
 .TP
-\fI-B, --buffer-time=#\fP     
+\fI\-B, \-\-buffer\-time=#\fP     
 Buffer duration is # microseconds
 .TP
-\fI--period-size=#\fP     
+\fI\-\-period\-size=#\fP     
 Distance between interrupts is # frames
 .TP
-\fI--buffer-size=#\fP     
+\fI\-\-buffer\-size=#\fP     
 Buffer duration is # frames
 .TP
-\fI-A, --avail-min=#\fP       
+\fI\-A, \-\-avail\-min=#\fP       
 Min available space for wakeup is # microseconds
 .TP
-\fI-R, --start-delay=#\fP     
+\fI\-R, \-\-start\-delay=#\fP     
 Delay for automatic PCM start is # microseconds 
 (relative to buffer size if <= 0)
 .TP
-\fI-T, --stop-delay=#\fP      
+\fI\-T, \-\-stop\-delay=#\fP      
 Delay for automatic PCM stop is # microseconds from xrun
 .TP
-\fI-v, --verbose\fP           
+\fI\-v, \-\-verbose\fP           
 Show PCM structure and setup.
 This option is accumulative.  The VU meter is displayed when this
 is given twice.
 .TP
-\fI-I, --separate-channels\fP 
+\fI\-I, \-\-separate\-channels\fP 
 One file for each channel
 
 .SS
 Example:
 
 .TP
-\fBaplay -c 1 -t raw -r 22050 -f mu_law foobar\fR
+\fBaplay \-c 1 \-t raw \-r 22050 \-f mu_law foobar\fR
 will play the raw file "foobar" as a
 22050-Hz, mono, 8-bit, Mu-Law .au file. 
 
 .TP
-\fBarecord -d 10 -f cd -t wav -D copy foobar.wav\fP
+\fBarecord \-d 10 \-f cd \-t wav \-D copy foobar.wav\fP
 will record foobar.wav as a 10-second, CD-quality wave file, using the
 PCM "copy" (which might be defined in the user's .asoundrc file as:
 .nf
Index: alsa-utils/iecset/iecset.1
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/iecset/iecset.1,v
retrieving revision 1.1
diff -a -u -r1.1 iecset.1
--- alsa-utils/iecset/iecset.1	23 Oct 2003 16:54:33 -0000	1.1
+++ alsa-utils/iecset/iecset.1	7 Oct 2004 18:26:00 -0000
@@ -16,14 +16,14 @@
 shown as well.
 
 The commands consist of the command directive and the argument.
-As the boolean argument, \fIyes\fP, \fIno\fP, \fItrue\fP, \fIfalse\fI,
+As the boolean argument, \fIyes\fP, \fIno\fP, \fItrue\fP, \fIfalse\fP,
 or a digit number is allowed.
 
 .SH EXAMPLES
 .TP
 .BI iecset\ \-Dhw:1
 Displays the current IEC958 status bits on the second card.
-This is equivalent with \fI-c 1\fP.
+This is equivalent with \fI\-c 1\fP.
 .TP
 .BI iecset\ \-x
 Displays the current IEC958 status bits in a style of the arguments
@@ -36,16 +36,16 @@
 
 .SH OPTIONS
 .TP
-\fI-D\fP device
+\fI\-D\fP device
 Specifies the device name of the control to open
 .TP
-\fI-c\fP card
-Specifies the card index to open.  Equivalent with \fI-Dhw:x\fP.
+\fI\-c\fP card
+Specifies the card index to open.  Equivalent with \fI\-Dhw:x\fP.
 .TP
-\fI-x\fP
+\fI\-x\fP
 Dumps the status in the form of AESx bytes.
 .TP
-\fI-i\fP
+\fI\-i\fP
 Reads the command sequences from stdin.
 Each line has single command.
 
Index: alsa-utils/seq/aconnect/aconnect.1
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/seq/aconnect/aconnect.1,v
retrieving revision 1.5
diff -a -u -r1.5 aconnect.1
--- alsa-utils/seq/aconnect/aconnect.1	25 Feb 2004 11:26:07 -0000	1.5
+++ alsa-utils/seq/aconnect/aconnect.1	7 Oct 2004 18:26:01 -0000
@@ -5,10 +5,10 @@
 
 .SH SYNOPSIS
 .B aconnect
-[\-d] [-options] sender receiver
+[\-d] [\-options] sender receiver
 .br
 .B aconnect
-\-i|-o [-options]
+\-i|\-o [\-options]
 .br
 .B aconnect
 \-x
@@ -34,7 +34,7 @@
 .B \-d
 option.
 .IP "" 4
-% aconnect -d 64:0 65:0
+% aconnect \-d 64:0 65:0
 .PP
 The address can be given using the client's name.
 .IP "" 4
@@ -53,7 +53,7 @@
 .B \-i
 option.
 .IP "" 4
-% aconnect -i
+% aconnect \-i
 .br
 client 0: 'System' [type=kernel]
 .in +4
@@ -61,9 +61,9 @@
 .br
 1 'Announce        '
 .in -4
-client 64: 'External MIDI-0' [type=kernel]
+client 64: 'External MIDI\-0' [type=kernel]
 .in +4
-0 'MIDI 0-0        '
+0 'MIDI 0\-0        '
 .in -4
 .PP
 Similary, to see the output ports, use
@@ -79,23 +79,23 @@
 .SH OPTIONS
 .SS CONNNECTION MANAGEMENT
 .TP
-.B \-d, --disconnect
+.B \-d, \-\-disconnect
 Disconnect the given subscription.
 .TP
-.B \-e, --exclusive
+.B \-e, \-\-exclusive
 Connect ports with exclusive mode.
 Both sender and receiver ports can be no longer connected by any other ports.
 .TP
-.B \-r, --real queue
+.B \-r, \-\-real queue
 Convert time-stamps of event packets to the current value of the given
 .I real-time
 queue.
 This is option is, however, not so useful, since
 the receiver port must use (not necessarily own) the specified queue.
 .TP
-.B \-t, --tick queue
+.B \-t, \-\-tick queue
 Like
-.B -r
+.B \-r
 option, but 
 time-stamps are converted to the current value of the given
 .I tick
@@ -103,17 +103,17 @@
 
 .SS LIST PORTS
 .TP
-.B \-i, --input
+.B \-i, \-\-input
 List existing input (readable) ports.
 This option is exclusive to
 .B \-o.
 .TP
-.B \-o, --output
+.B \-o, \-\-output
 List existing output (writable) ports.
 This option is exclusive to
 .B \-i.
 .TP
-.B \-l, --list
+.B \-l, \-\-list
 List the current connection status.  The connected and connecting ports
 from/to each port are listed together.
 The suffix flag
@@ -128,7 +128,7 @@
 
 .SS REMOVE ALL CONNECTIONS
 .TP
-.B \-x, --removeall
+.B \-x, \-\-removeall
 Remove all exported connections.
 
 .SH "SEE ALSO"
Index: alsa-utils/seq/aplaymidi/aplaymidi.1
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/seq/aplaymidi/aplaymidi.1,v
retrieving revision 1.1
diff -a -u -r1.1 aplaymidi.1
--- alsa-utils/seq/aplaymidi/aplaymidi.1	23 Feb 2004 10:58:35 -0000	1.1
+++ alsa-utils/seq/aplaymidi/aplaymidi.1	7 Oct 2004 18:26:01 -0000
@@ -5,7 +5,7 @@
 
 .SH SYNOPSIS
 .B aplaymidi
--p client:port[,...] [-d delay] midifile ...
+\-p client:port[,...] [\-d delay] midifile ...
 
 .SH DESCRIPTION
 .B aplaymidi
@@ -15,19 +15,19 @@
 .SH OPTIONS
 
 .TP
-.I -h, --help
+.I \-h, \-\-help
 Prints a list of options.
 
 .TP
-.I -V, --version
+.I \-V, \-\-version
 Prints the current version.
 
 .TP
-.I -l, --list
+.I \-l, \-\-list
 Prints a list of possible output ports.
 
 .TP
-.I -p, --port=client:port,...
+.I \-p, \-\-port=client:port,...
 Sets the sequencer port(s) to which the events in the MIDI file(s) are
 sent.
 
@@ -42,7 +42,7 @@
 environment variable if none is given on the command line.
 
 .TP
-.I -d, --delay=seconds
+.I \-d, \-\-delay=seconds
 Specifies how long to wait after the end of each MIDI file,
 to allow the last notes to die away.
 
Index: alsa-utils/seq/aplaymidi/arecordmidi.1
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/seq/aplaymidi/arecordmidi.1,v
retrieving revision 1.2
diff -a -u -r1.2 arecordmidi.1
--- alsa-utils/seq/aplaymidi/arecordmidi.1	6 Apr 2004 06:22:19 -0000	1.2
+++ alsa-utils/seq/aplaymidi/arecordmidi.1	7 Oct 2004 18:26:01 -0000
@@ -1,11 +1,11 @@
 .TH ARECORDMIDI 1 "6 Apr 2004"
 
 .SH NAME
-arecordmidi - record Standard MIDI Files
+arecordmidi \- record Standard MIDI Files
 
 .SH SYNOPSIS
 .B arecordmidi
--p client:port[,...] [options] midifile
+\-p client:port[,...] [options] midifile
 
 .SH DESCRIPTION
 .B arecordmidi
@@ -17,19 +17,19 @@
 .SH OPTIONS
 
 .TP
-.I -h,--help
+.I \-h,\-\-help
 Prints a list of options.
 
 .TP
-.I -V,--version
+.I \-V,\-\-version
 Prints the current version.
 
 .TP
-.I -l,--list
+.I \-l,\-\-list
 Prints a list of possible input ports.
 
 .TP
-.I -p,--port=client:port,...
+.I \-p,\-\-port=client:port,...
 Sets the sequencer port(s) from which events are recorded.
 
 A client can be specified by its number, its name, or a prefix of its
@@ -37,40 +37,40 @@
 ":0" part of the port specification can be omitted.
 
 .TP
-.I -b,--bpm=beats
+.I \-b,\-\-bpm=beats
 Sets the musical tempo of the MIDI file, in beats per minute.
 The default value is 120 BPM.
 
 .TP
-.I -f,--fps=frames
+.I \-f,\-\-fps=frames
 Sets the SMPTE resolution, in frames per second.
 Possible values are 24, 25, 29.97 (for 30 drop-frame), and 30.
 
 .TP
-.I -t,--ticks=ticks
+.I \-t,\-\-ticks=ticks
 Sets the resolution of timestamps (ticks) in the MIDI file,
 in ticks per beat (when using musical tempo) or ticks per frame
 (when using SMPTE timing).
 The default value is 384 ticks/beat or 40 ticks/frame, respectively.
 
 .TP
-.I -s,--split-channels
+.I \-s,\-\-split\-channels
 Specifies that the data for each MIDI channel should be written to a
 separate track in the MIDI file.
 
 .TP
-.I -d,--dump
+.I \-d,\-\-dump
 Shows the events received as text on standard output.
 
 .TP
-.I -m,--metronome=client:port
+.I \-m,\-\-metronome=client:port
 Plays a metronome signal on the specified sequencer port.
 
 Metronome sounds are played on channel 10, MIDI notes 33 & 34 (GM2/GS/XG 
 metronome standard notes), with velocity 100 and duration 1.
 
 .TP
-.I -i,--timesig=numerator:denominator
+.I \-i,\-\-timesig=numerator:denominator
 Sets the time signature for the MIDI file and metronome.
 
 The time signature is specified as usual with two numbers, representing
Index: alsa-utils/seq/aseqnet/aseqnet.1
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/seq/aseqnet/aseqnet.1,v
retrieving revision 1.2
diff -a -u -r1.2 aseqnet.1
--- alsa-utils/seq/aseqnet/aseqnet.1	1 Sep 2000 16:25:10 -0000	1.2
+++ alsa-utils/seq/aseqnet/aseqnet.1	7 Oct 2004 18:26:01 -0000
@@ -49,7 +49,7 @@
 The following command plays MIDI on
 .I hostB.
 .IP "" 4
-hostA% pmidi -p 128:0 foo.mid
+hostA% pmidi \-p 128:0 foo.mid
 .PP
 The multiple clients may exist simultaneously.  If
 .I hostC

--Qxx1br4bt0+wmkIi--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
