From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001362]: Compiler warnings
Date: Tue, 23 Aug 2005 19:08:15 +0200
Message-ID: <d8bcc52b8c187d60779e3d71acf3dfa6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3BAD9263
	for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2005 19:08:15 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1362> 
======================================================================
Reported By:                Henne
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1362
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core release 1 (Yarrow)
Kernel Version:             Linux version 2.4.22-1.2199.5.legacy.nptl
(machbuild@jane.spidermaker.fedoralegacy.org) (gcc version 3.2.3 20030422 (Red
Hat Linux 3.2.3-6)) #1 Sat Apr 30 20:01:22 EDT 2005
======================================================================
Date Submitted:             08-23-2005 19:08 CEST
Last Modified:              08-23-2005 19:08 CEST
======================================================================
Summary:                    Compiler warnings
Description: 
Hi!

I've compiled the new release candidat on gcc 3.3.2 and got some errors.


sound.c:42: Warnung: `device_mode' defined but not used
aloop-kernel.c:43: Warnung: `pcm_devs' defined but not used
In file included from darla20.c:99:
echoaudio.c: In function `snd_echo_free':
echoaudio.c:1741: Warnung: passing arg 1 of `iounmap_R5fb196d4' discards
qualifiers from pointer target type
In file included from darla24.c:106:
echoaudio.c: In function `snd_echo_free':
echoaudio.c:1741: Warnung: passing arg 1 of `iounmap_R5fb196d4' discards
qualifiers from pointer target type
In file included from echo3g.c:119:
echoaudio.c: In function `snd_echo_free':
echoaudio.c:1741: Warnung: passing arg 1 of `iounmap_R5fb196d4' discards
qualifiers from pointer target type
In file included from gina20.c:103:
echoaudio.c: In function `snd_echo_free':
echoaudio.c:1741: Warnung: passing arg 1 of `iounmap_R5fb196d4' discards
qualifiers from pointer target type
In file included from gina24.c:123:
echoaudio.c: In function `snd_echo_free':
echoaudio.c:1741: Warnung: passing arg 1 of `iounmap_R5fb196d4' discards
qualifiers from pointer target type
In file included from indigo.c:103:
echoaudio.c: In function `snd_echo_free':
echoaudio.c:1741: Warnung: passing arg 1 of `iounmap_R5fb196d4' discards
qualifiers from pointer target type
In file included from indigodj.c:103:
echoaudio.c: In function `snd_echo_free':
echoaudio.c:1741: Warnung: passing arg 1 of `iounmap_R5fb196d4' discards
qualifiers from pointer target type
In file included from indigoio.c:104:
echoaudio.c: In function `snd_echo_free':
echoaudio.c:1741: Warnung: passing arg 1 of `iounmap_R5fb196d4' discards
qualifiers from pointer target type
In file included from layla20.c:111:
echoaudio.c: In function `snd_echo_free':
echoaudio.c:1741: Warnung: passing arg 1 of `iounmap_R5fb196d4' discards
qualifiers from pointer target type
In file included from layla24.c:120:
echoaudio.c: In function `snd_echo_free':
echoaudio.c:1741: Warnung: passing arg 1 of `iounmap_R5fb196d4' discards
qualifiers from pointer target type
In file included from mia.c:116:
echoaudio.c: In function `snd_echo_free':
echoaudio.c:1741: Warnung: passing arg 1 of `iounmap_R5fb196d4' discards
qualifiers from pointer target type
In file included from mona.c:129:
echoaudio.c: In function `snd_echo_free':
echoaudio.c:1741: Warnung: passing arg 1 of `iounmap_R5fb196d4' discards
qualifiers from pointer target type

The first message seems very strange to me, cause device_mode is used by
snd_register_device() and alsa_sound_init(). I'll test it on another box
tomorrow. Maybe it's a error in the compiler.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-23-05 19:08 Henne          New Issue                                    
08-23-05 19:08 Henne          Distribution              => Fedora Core release 1
(Yarrow)
08-23-05 19:08 Henne          Kernel Version            => Linux version
2.4.22-1.2199.5.legacy.nptl (machbuild@jane.spidermaker.fedoralegacy.org) (gcc
version 3.2.3 20030422 (Red Hat Lin
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
