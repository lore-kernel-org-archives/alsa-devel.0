From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: new "in-compatible" alsa-lib PCM API
Date: Thu, 19 Sep 2002 17:29:48 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0209191723150.6991-100000@pnote.perex-int.cz>
References: <87bs6v1dvb.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA11032
	for <alsa-devel@alsa-project.org>; Thu, 19 Sep 2002 17:32:06 +0200
Received: from pnote.perex-int.cz ([192.168.105.2])
	by gate.perex.cz (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA22769
	for <alsa-devel@alsa-project.org>; Thu, 19 Sep 2002 17:31:59 +0200
In-Reply-To: <87bs6v1dvb.fsf@sulphur.joq.us>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

	your almost all negative messages persuaded me to wait awhile with 
new function prototypes. Here is the result:

- .so library number returned to .2
- library builds with versioned symbols since now, default tag is ALSA_0.9
- new snd_pcm_hw_params_* function are available with tag ALSA_0.9.0rc4 
  (not available for default linking); these new functions are explicitly
  available when ALSA_PCM_NEW_HW_PARAMS_API is defined before inclusion of
  asoundlib.h
- old (default, implicit) functions are not documented from this time, 
  each references in documentation are to newer API

These changes allows us to use newer API (first change for ALSA 1.0) now
without any constraints for old and new APIs. The alsa-utils and
alsa-tools programs use new API since now.

Let me know, if you have some usage problem, but I hope that this library 
will behave in same way as 0.9.0rc3 does.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
