From: "Karsten Wiese" <annabellesgarden@yahoo.de>
Subject: Turtle Beach Pinnacle/Fiji alsa driver 0.1.1
Date: Fri, 14 Jun 2002 23:28:49 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <DAELIEGDPLDDCIJPAICBOELCCCAA.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp012.mail.yahoo.com (smtp012.mail.yahoo.com [216.136.173.32])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id XAA01512
	for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2002 23:28:10 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Alsa-Devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

hi,

new in this is onboard memory maped playback at up to 1387 cycles/s ;-)
on a 400PII with no xruns, if it runs with realtime scheduling with no other
hungry tasks.
it is still err.. a little unstable: for instance crashes while accessing
some /proc/asound files.

works:
PCM:		Stereo playback @44100 with the alsa-tools aplay & pcm & aplay -M
MIXER:	Master, Pcm
VERSION:	0.9rc1CVS, patched sources, diffs available via e-mail
OS:		Slackware 8.1rc1

not...yet:
PCM:		Record
MIDI:
SPDIF:

cheers, karsten



_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas - http://devcon.sprintpcs.com/adp/index.cfm?source=osdntextlink
