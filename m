From: Jaroslav Kysela <perex@suse.cz>
Subject: OSS API redirector
Date: Thu, 18 Mar 2004 10:32:08 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403181015270.1835@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA12351
	for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2004 10:35:37 +0100
Received: from server.perex-int.cz (server-a.perex-int.cz [192.168.100.3])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 81C8F13A
	for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2004 10:35:31 +0100 (MET)
Received: from pnote.perex-int.cz (localhost [127.0.0.1])
	by server.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 59B2D3F00C
	for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2004 10:35:31 +0100 (CET)
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

Hi all,

	I would like to point all developers to the OSS API redirector 
which is in our alsa-oss package. It's universal piece of code which can 
redirect all OSS API calls (actually mixer & PCM API only) to any shared 
library.

Pros:
- no more LD_PRELOAD hacks
- any library can be used directly as endpoint
- when used more applications will work (also some which does not work
  with LD_PRELOAD hack)

Drawbacks:
- still no fopen/fclose/fwrite/fread solution
- applications must be a little bit modified

Todo:
- OSS sequencer API redirector (it shouldn't be too difficult)

	My original point is that we might persuade the binary only 
providers (mostly games vendors) to use this small piece of code, because
there are no impacts regarding the application useability and the 
maintaince overhead of this code is minimal.
	The second goal is to use this redirector for all OSS applications
in Linux distributions to make the routing over ALSA library more easy.

Usage of this redirector for OSS API emulation in ALSA:

export OSS_REDIRECTOR=libalsatoss.so

And define appropriate pcm.dsp0 and pcm.mixer0 in ~/.asoundrc.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
