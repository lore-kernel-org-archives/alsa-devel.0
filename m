From: Jaroslav Kysela <perex@suse.cz>
Subject: future ALSA development
Date: Sun, 22 Jun 2003 21:10:31 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306222010030.1838-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (UNKNOWN@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA28852
	for <alsa-devel@alsa-project.org>; Sun, 22 Jun 2003 21:11:01 +0200
Received: from pnote.perex-int.cz (pnote.perex-int.cz [192.168.100.88])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id B9DC6BF
	for <alsa-devel@alsa-project.org>; Sun, 22 Jun 2003 21:10:53 +0200 (MEST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello all,

	here are my next goals for the ALSA library development (short 
term). I invite all developers to comment these directions.

* create ordinary pcm & mixer interfaces
  - proposed headers are in current CVS
    - alsa-lib/include/pcm_ordinary.h
    - alsa-lib/include/mixer_ordinary.h
  - intended applications are
    - simple playback & recorders
    - DVD players
    - VoIP (and other audio conferencing) applications
    - very simple mixer applications
* investigate a lisp integration to the current configuration syntax
  - we need to describe the relations between high level abstract
    layer (ordinary mixer) and current universal controls (very lowlevel);
    it seems that the simple configuration is not able to describe
    these (in most cases) very complicated paths
  - note that describing of these relations might be used also for
    another mixer interfaces (simple mixer for example)
  - I don't rely on lisp, but what another interpreter with function
    definition has only 22kB binary (slisp-1.2 - i686)?
* initiate a development of a graphical tool which will manage
  the alsa configuration files (~/.asoundrc)
  - we need a rapid development tool; I slowly became a fan of python and
    Qt has rich number of widgets; python + PyQt seems to me a good idea
  - using python requires to write a GPLed ALSA 0.9 -> python wrapper

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs




-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
