From: Jaroslav Kysela <perex@suse.cz>
Subject: alsa-lib & oss 1.0.3rc1
Date: Sat, 21 Feb 2004 23:05:29 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0402212257000.1870@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id XAA23798
	for <alsa-devel@alsa-project.org>; Sat, 21 Feb 2004 23:09:22 +0100
Received: from server.perex-int.cz (server-a.perex-int.cz [192.168.100.3])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id B25BBEF
	for <alsa-devel@alsa-project.org>; Sat, 21 Feb 2004 23:09:21 +0100 (MET)
Received: from pnote.perex-int.cz (localhost [127.0.0.1])
	by server.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 988504000
	for <alsa-devel@alsa-project.org>; Sat, 21 Feb 2004 23:09:21 +0100 (CET)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello all,

	I am trying to fix resampling problems in alsa-lib and OSS
emulation problems in alsa-oss package. I released first preview of my
changes. It would be nice, if you can test my changes and report me bugs
or comments (especially to the new OSS redirector code).

Changes:

- alsa-lib
  - recoded pcm_rate plugin to resample whole periods (click and 
    rounding problem elimination)
  - fixed pcm_file plugin
- alsa-oss
  - mangle power of two period/buffer settings to more benevolent
    ALSA parameters -> dmix plugin should work with more programs
    now
  - created OSS redirector library (libossredir) which can help
    to redirect OSS API based applications to virtualy any dynamic
    library (see alsa-oss/oss-redir/README)

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
