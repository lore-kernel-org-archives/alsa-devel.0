From: Nicolas =?iso-8859-1?Q?Fran=E7ois?= <nicolas.francois@centraliens.net>
Subject: hyphens in man pages
Date: Sat, 2 Oct 2004 13:45:05 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041002114505.GA22558@nekral.homelinux.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Nicolas =?iso-8859-1?Q?Fran=E7ois?= <nicolas.francois@centraliens.net>
List-Id: alsa-devel@alsa-project.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Here is a patch that convert hyphens to minus signs in the man pages (for
options, emails, or command line examples).

Hyphens are not suitable for searches or cut&paste on UTF-8 terminals.
Minus signs need to be escaped (\-) in order to be displayed as a minus
sign, and not as an hyphen.

This patch also close one font modifier in iecset.1.
s/\fIfalse\fI,/\fIfalse\fP,/

Kind Regards,
-- 
Nekral

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="alsa_hyphens.patch"

Index: alsa-lib/test/midifile.3
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/test/midifile.3,v
retrieving revision 1.2
diff -r1.2 midifile.3
3c3
< mfread,mfwrite - read and write a standard MIDI file
---
> mfread,mfwrite \- read and write a standard MIDI file
90c90
< characters from the MIDI file, using -1 to indicate EOF.
---
> characters from the MIDI file, using \-1 to indicate EOF.
272c272
< 14 through 8 contain one of four values - 24, -25, -29, or -30,
---
> 14 through 8 contain one of four values \-24, \-25, \-29, or \-30,
274c274
< frame per second formats, where -29 represents 30 drop frame.
---
> frame per second formats, where \-29 represents 30 drop frame.
308c308
< 	   return(-1);
---
> 	   return(\-1);
310c310
<            return(-1);
---
>            return(\-1);
Index: alsa-oss/alsa/aoss.1
===================================================================
RCS file: /cvsroot/alsa/alsa-oss/alsa/aoss.1,v
retrieving revision 1.4
diff -r1.4 aoss.1
46c46
< The OSS compatibility library is by Abramo Bagnara <abramo@alsa-project.org>.
---
> The OSS compatibility library is by Abramo Bagnara <abramo@alsa\-project.org>.
Index: alsa-tools/envy24control/envy24control.1
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/envy24control/envy24control.1,v
retrieving revision 1.7
diff -r1.7 envy24control.1
7c7
< \fBenvy24control\fP [\fI-c\fP card-number] [\fI-D\fP control-name] [\fI-o\fP 0-num DACs max 8] [\fI-i\fP 0-num ADCs max 8] [\fI-p\fP 0-8] [\fI-s\fP 0-2] [\fI-f\fP <profiles file name>] [\fI-v\fP] [<profile number>|<profile name>]
---
> \fBenvy24control\fP [\fI\-c\fP card-number] [\fI\-D\fP control-name] [\fI\-o\fP 0-num DACs max 8] [\fI\-i\fP 0-num ADCs max 8] [\fI\-p\fP 0-8] [\fI\-s\fP 0-2] [\fI\-f\fP <profiles file name>] [\fI\-v\fP] [<profile number>|<profile name>]
17c17
< \fBenvy24control\fP [\fI-c\fP card-number] [\fI-D\fP control-name] [\fI-o\fP 0-num DACs max 8] [\fI-i\fP 0-num ADCs max 8] [\fI-p\fP 0-8] [\fI-s\fP 0-2] [\fI-f\fP <profiles file name>] [\fI-v\fP] [<profile number>|<profile name>]
---
> \fBenvy24control\fP [\fI\-c\fP card-number] [\fI\-D\fP control-name] [\fI\-o\fP 0-num DACs max 8] [\fI\-i\fP 0-num ADCs max 8] [\fI\-p\fP 0-8] [\fI\-s\fP 0-2] [\fI\-f\fP <profiles file name>] [\fI\-v\fP] [<profile number>|<profile name>]
23c23
< \fI-c\fP card-number
---
> \fI\-c\fP card-number
25c25
< This is equivalent with \fI-Dhw:n\fP option where \fIn\fP is the card number.
---
> This is equivalent with \fI\-Dhw:n\fP option where \fIn\fP is the card number.
27c27
< \fI-D\fP control-name
---
> \fI\-D\fP control-name
34c34
< \fI-o\fP outputs
---
> \fI\-o\fP outputs
40c40
< \fI-i\fP inputs
---
> \fI\-i\fP inputs
46c46
< \fI-p\fP pcm outputs
---
> \fI\-p\fP pcm outputs
49c49
< \fI-s\fP spdif inputs/outputs
---
> \fI\-s\fP spdif inputs/outputs
52c52
< \fI-f\fP name and path of the profiles file name.
---
> \fI\-f\fP name and path of the profiles file name.
57c57
< \fI-v\fP view spdif playback channels in the mixer.
---
> \fI\-v\fP view spdif playback channels in the mixer.
72c72
< Last updated by Dirk Kalis <dirk.kalis@t-online.de>.
---
> Last updated by Dirk Kalis <dirk.kalis@t\-online.de>.
Index: alsa-tools/sb16_csp/cspctl.1
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/sb16_csp/cspctl.1,v
retrieving revision 1.1
diff -r1.1 cspctl.1
15c15
< .I snd-sb16-csp
---
> .I snd\-sb16\-csp
48c48
< % cspctl load -f 2 -d QSound wfm0001a.csp
---
> % cspctl load \-f 2 \-d QSound wfm0001a.csp
55c55
< State: -x--L
---
> State: \-x\-\-L
69c69
< State: Qx-RL
---
> State: Qx\-RL
87,88c87,88
< State: -x--L
< Codec: IMA-ADPCM [func #2]
---
> State: \-x\-\-L
> Codec: IMA\-ADPCM [func #2]
90c90
< PCM format ID: 0x400000 (16bit/-) [mono/stereo] [playback/-]
---
> PCM format ID: 0x400000 (16bit/\-) [mono/stereo] [playback/\-]
103c103
< .B \-h, --help
---
> .B \-h, \-\-help
116c116
< Uros Bizjak <uros@kss-loka.si>.
---
> Uros Bizjak <uros@kss\-loka.si>.
Index: alsa-utils/alsaconf/alsaconf.8
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/alsaconf/alsaconf.8,v
retrieving revision 1.2
diff -r1.2 alsaconf.8
55c55
< Set strict device mode (equiv. with -g 17 -d 0660).
---
> Set strict device mode (equiv. with \-g 17 \-d 0660).
82c82
< .I /usr/share/doc/alsa-base/
---
> .I /usr/share/doc/alsa\-base/
93c93
< http://www.alsa-project.org/
---
> http://www.alsa\-project.org/
Index: alsa-utils/alsactl/alsactl.1
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/alsactl/alsactl.1,v
retrieving revision 1.6
diff -r1.6 alsactl.1
32c32
< \fI-h, --help\fP 
---
> \fI\-h, \-\-help\fP 
36c36
< \fI-f, --file\fP
---
> \fI\-f, \-\-file\fP
40c40
< \fI-F, --force\fP
---
> \fI\-F, \-\-force\fP
45c45
< \fI-d, --debug\fP
---
> \fI\-d, \-\-debug\fP
49c49
< \fI-v, --version\fP
---
> \fI\-v, \-\-version\fP
54c54
< \fB-f\fP flag) is used to store current settings for your
---
> \fB\-f\fP flag) is used to store current settings for your
78c78
< <abramo@alsa-project.org>. This document is by Paul Winkler <zarmzarm@erols.com>.
---
> <abramo@alsa\-project.org>. This document is by Paul Winkler <zarmzarm@erols.com>.
Index: alsa-utils/alsamixer/alsamixer.1
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/alsamixer/alsamixer.1,v
retrieving revision 1.10
diff -r1.10 alsamixer.1
19c19
< \fI-h, -help\fP 
---
> \fI\-h, \-help\fP 
23c23
< \fI-c\fP <card number or idenfication>
---
> \fI\-c\fP <card number or idenfication>
28c28
< \fI-D\fP <device identification>
---
> \fI\-D\fP <device identification>
32c32
< \fI-g\fP <toggle color settings>
---
> \fI\-g\fP <toggle color settings>
36c36
< \fI-s\fP <minimize mixer window>
---
> \fI\-s\fP <minimize mixer window>
52c52
< currently selected device. You can also use \fI+\fP or \fI-\fP for the
---
> currently selected device. You can also use \fI+\fP or \fI\-\fP for the
Index: alsa-utils/amidi/amidi.1
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/amidi/amidi.1,v
retrieving revision 1.4
diff -r1.4 amidi.1
31,33c31,33
< .I -h,
< .I -V,
< .I -l,
---
> .I \-h,
> .I \-V,
> .I \-l,
35c35
< .I -L
---
> .I \-L
38,40c38,40
< .I -s,
< .I -r,
< .I -S,
---
> .I \-s,
> .I \-r,
> .I \-S,
42c42
< .I -d
---
> .I \-d
48c48
< .I -h, --help
---
> .I \-h, \-\-help
52c52
< .I -V, --version
---
> .I \-V, \-\-version
56c56
< .I -l, --list-devices
---
> .I \-l, \-\-list\-devices
60c60
< .I -L, --list-rawmidis
---
> .I \-L, \-\-list\-rawmidis
65c65
< .I -p, --port=name
---
> .I \-p, \-\-port=name
73c73
< .I -s, --send=filename
---
> .I \-s, \-\-send=filename
80c80
< .I -r, --receive=filename
---
> .I \-r, \-\-receive=filename
88c88
< .I -a
---
> .I \-a
92c92
< .I -S, --send-hex="..."
---
> .I \-S, \-\-send\-hex="..."
96c96
< .I -d, --dump
---
> .I \-d, \-\-dump
99c99
< .I -a
---
> .I \-a
105c105
< .I -t, --timeout=seconds
---
> .I \-t, \-\-timeout=seconds
114c114
< .I -a, --active-sensing
---
> .I \-a, \-\-active\-sensing
121c121
< .B amidi -p hw:0 -s my_settings.syx
---
> .B amidi \-p hw:0 \-s my_settings.syx
128c128
< .B amidi -S 'F0 43 10 4C 00 00 7E 00 F7'
---
> .B amidi \-S 'F0 43 10 4C 00 00 7E 00 F7'
132c132
< .B amidi -p hw:1,2 -S F0411042110C000000000074F7 -r dump.syx -t 1
---
> .B amidi \-p hw:1,2 \-S F0411042110C000000000074F7 \-r dump.syx \-t 1
140c140
< .B amidi -p virtual -d
---
> .B amidi \-p virtual \-d
155c155
< .I --list-devices
---
> .I \-\-list\-devices
Index: alsa-utils/amixer/amixer.1
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/amixer/amixer.1,v
retrieving revision 1.11
diff -r1.11 amixer.1
5c5
< \fBamixer\fP [\fI-c\fP card] [\fIcmd\fP]
---
> \fBamixer\fP [\fI\-c\fP card] [\fIcmd\fP]
41c41
< channels to be changed. When plus(+) or minus(-) letter is appended after
---
> channels to be changed. When plus(+) or minus(\-) letter is appended after
77c77
< [\fI-c\fP card]
---
> [\fI\-c\fP card]
83c83
< [\fI-D\fP device]
---
> [\fI\-D\fP device]
88c88
< \fI-h\fP 
---
> \fI\-h\fP 
91c91
< \fI-q\fP
---
> \fI\-q\fP
98c98
< \fBamixer -c 1 sset Line,0 80%,40% unmute cap\fR
---
> \fBamixer \-c 1 sset Line,0 80%,40% unmute cap\fR
107c107
< \fBamixer -c 2 cset iface=MIXER,name='Line Playback Volume",index=1 40%\fR
---
> \fBamixer \-c 2 cset iface=MIXER,name='Line Playback Volume",index=1 40%\fR
114c114
< \fBamixer -c 2 cset numid=34 40%\fR
---
> \fBamixer \-c 2 cset numid=34 40%\fR
Index: alsa-utils/aplay/aplay.1
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/aplay/aplay.1,v
retrieving revision 1.9
diff -r1.9 aplay.1
28c28
< \fI-h, --help\fP
---
> \fI\-h, \-\-help\fP
31c31
< \fI--version\fP
---
> \fI\-\-version\fP
34c34
< \fI-l, --list-devices\fP
---
> \fI\-l, \-\-list\-devices\fP
37c37
< \fI-L, --list-pcms\fP
---
> \fI\-L, \-\-list\-pcms\fP
40c40
< \fI-D, --device=NAME\fP
---
> \fI\-D, \-\-device=NAME\fP
43c43
< \fI-q --quiet\fP
---
> \fI\-q \-\-quiet\fP
46c46
< \fI-t, --file-type TYPE\fP
---
> \fI\-t, \-\-file\-type TYPE\fP
49c49
< \fI-c, --channels=#\fP
---
> \fI\-c, \-\-channels=#\fP
52c52
< \fI-f --format=FORMAT\fP
---
> \fI\-f \-\-format=FORMAT\fP
64,65c64,65
< -f cd (16 bit little endian, 44100, stereo [-f S16_LE -c2 -r44100]
< -f dat (16 bit little endian, 48000, stereo) [-f S16_LE -c2 -r48000]
---
> \-f cd (16 bit little endian, 44100, stereo [\-f S16_LE \-c2 \-r44100]
> \-f dat (16 bit little endian, 48000, stereo) [\-f S16_LE \-c2 \-r48000]
68c68
< \fI-r, --rate=#<Hz>\fP
---
> \fI\-r, \-\-rate=#<Hz>\fP
71c71
< \fI-d, --duration=#\fP
---
> \fI\-d, \-\-duration=#\fP
76c76
< \fI-s, --sleep-min=#\fP
---
> \fI\-s, \-\-sleep\-min=#\fP
79c79
< \fI-M, --mmap\fP            
---
> \fI\-M, \-\-mmap\fP            
82c82
< \fI-N, --nonblock\fP          
---
> \fI\-N, \-\-nonblock\fP          
85c85
< \fI-F, --period-time=#\fP     
---
> \fI\-F, \-\-period\-time=#\fP     
88c88
< \fI-B, --buffer-time=#\fP     
---
> \fI\-B, \-\-buffer\-time=#\fP     
91c91
< \fI--period-size=#\fP     
---
> \fI\-\-period\-size=#\fP     
94c94
< \fI--buffer-size=#\fP     
---
> \fI\-\-buffer\-size=#\fP     
97c97
< \fI-A, --avail-min=#\fP       
---
> \fI\-A, \-\-avail\-min=#\fP       
100c100
< \fI-R, --start-delay=#\fP     
---
> \fI\-R, \-\-start\-delay=#\fP     
104c104
< \fI-T, --stop-delay=#\fP      
---
> \fI\-T, \-\-stop\-delay=#\fP      
107c107
< \fI-v, --verbose\fP           
---
> \fI\-v, \-\-verbose\fP           
112c112
< \fI-I, --separate-channels\fP 
---
> \fI\-I, \-\-separate\-channels\fP 
119c119
< \fBaplay -c 1 -t raw -r 22050 -f mu_law foobar\fR
---
> \fBaplay \-c 1 \-t raw \-r 22050 \-f mu_law foobar\fR
124c124
< \fBarecord -d 10 -f cd -t wav -D copy foobar.wav\fP
---
> \fBarecord \-d 10 \-f cd \-t wav \-D copy foobar.wav\fP
Index: alsa-utils/iecset/iecset.1
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/iecset/iecset.1,v
retrieving revision 1.1
diff -r1.1 iecset.1
19c19
< As the boolean argument, \fIyes\fP, \fIno\fP, \fItrue\fP, \fIfalse\fI,
---
> As the boolean argument, \fIyes\fP, \fIno\fP, \fItrue\fP, \fIfalse\fP,
26c26
< This is equivalent with \fI-c 1\fP.
---
> This is equivalent with \fI\-c 1\fP.
39c39
< \fI-D\fP device
---
> \fI\-D\fP device
42,43c42,43
< \fI-c\fP card
< Specifies the card index to open.  Equivalent with \fI-Dhw:x\fP.
---
> \fI\-c\fP card
> Specifies the card index to open.  Equivalent with \fI\-Dhw:x\fP.
45c45
< \fI-x\fP
---
> \fI\-x\fP
48c48
< \fI-i\fP
---
> \fI\-i\fP
Index: alsa-utils/seq/aconnect/aconnect.1
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/seq/aconnect/aconnect.1,v
retrieving revision 1.5
diff -r1.5 aconnect.1
8c8
< [\-d] [-options] sender receiver
---
> [\-d] [\-options] sender receiver
11c11
< \-i|-o [-options]
---
> \-i|\-o [\-options]
37c37
< % aconnect -d 64:0 65:0
---
> % aconnect \-d 64:0 65:0
56c56
< % aconnect -i
---
> % aconnect \-i
64c64
< client 64: 'External MIDI-0' [type=kernel]
---
> client 64: 'External MIDI\-0' [type=kernel]
66c66
< 0 'MIDI 0-0        '
---
> 0 'MIDI 0\-0        '
82c82
< .B \-d, --disconnect
---
> .B \-d, \-\-disconnect
85c85
< .B \-e, --exclusive
---
> .B \-e, \-\-exclusive
89c89
< .B \-r, --real queue
---
> .B \-r, \-\-real queue
96c96
< .B \-t, --tick queue
---
> .B \-t, \-\-tick queue
98c98
< .B -r
---
> .B \-r
106c106
< .B \-i, --input
---
> .B \-i, \-\-input
111c111
< .B \-o, --output
---
> .B \-o, \-\-output
116c116
< .B \-l, --list
---
> .B \-l, \-\-list
131c131
< .B \-x, --removeall
---
> .B \-x, \-\-removeall
Index: alsa-utils/seq/aplaymidi/aplaymidi.1
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/seq/aplaymidi/aplaymidi.1,v
retrieving revision 1.1
diff -r1.1 aplaymidi.1
8c8
< -p client:port[,...] [-d delay] midifile ...
---
> \-p client:port[,...] [\-d delay] midifile ...
18c18
< .I -h, --help
---
> .I \-h, \-\-help
22c22
< .I -V, --version
---
> .I \-V, \-\-version
26c26
< .I -l, --list
---
> .I \-l, \-\-list
30c30
< .I -p, --port=client:port,...
---
> .I \-p, \-\-port=client:port,...
45c45
< .I -d, --delay=seconds
---
> .I \-d, \-\-delay=seconds
Index: alsa-utils/seq/aplaymidi/arecordmidi.1
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/seq/aplaymidi/arecordmidi.1,v
retrieving revision 1.2
diff -r1.2 arecordmidi.1
4c4
< arecordmidi - record Standard MIDI Files
---
> arecordmidi \- record Standard MIDI Files
8c8
< -p client:port[,...] [options] midifile
---
> \-p client:port[,...] [options] midifile
20c20
< .I -h,--help
---
> .I \-h,\-\-help
24c24
< .I -V,--version
---
> .I \-V,\-\-version
28c28
< .I -l,--list
---
> .I \-l,\-\-list
32c32
< .I -p,--port=client:port,...
---
> .I \-p,\-\-port=client:port,...
40c40
< .I -b,--bpm=beats
---
> .I \-b,\-\-bpm=beats
45c45
< .I -f,--fps=frames
---
> .I \-f,\-\-fps=frames
50c50
< .I -t,--ticks=ticks
---
> .I \-t,\-\-ticks=ticks
57c57
< .I -s,--split-channels
---
> .I \-s,\-\-split\-channels
62c62
< .I -d,--dump
---
> .I \-d,\-\-dump
66c66
< .I -m,--metronome=client:port
---
> .I \-m,\-\-metronome=client:port
73c73
< .I -i,--timesig=numerator:denominator
---
> .I \-i,\-\-timesig=numerator:denominator
Index: alsa-utils/seq/aseqnet/aseqnet.1
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/seq/aseqnet/aseqnet.1,v
retrieving revision 1.2
diff -r1.2 aseqnet.1
52c52
< hostA% pmidi -p 128:0 foo.mid
---
> hostA% pmidi \-p 128:0 foo.mid

--liOOAslEiF7prFVr--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
