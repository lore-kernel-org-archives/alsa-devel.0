From: Ted <ted@nowtsfree.freeserve.co.uk>
Subject: cvsexport 2003-12-31/alsa-driver/acore/pcm_native.patch fails
Date: Wed, 31 Dec 2003 05:18:37 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031231051837.9FC394955@marimba.home.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: ted@nowtsfree.freeserve.co.uk
List-Id: alsa-devel@alsa-project.org

Hi,

The cvs export for 2003-12-31 will not build for me ...

copying file alsa-kernel/core/pcm_native.c
patching file pcm_native.c
Hunk #2 succeeded at 2656 (offset 47 lines).
Hunk #4 succeeded at 2729 (offset 47 lines).
Hunk #6 FAILED at 2796.
Hunk #7 FAILED at 2823.
Hunk #8 FAILED at 2851.
Hunk #9 FAILED at 2878.
Hunk #10 succeeded at 2957 (offset 51 lines).
Hunk #11 FAILED at 2980.
Hunk #13 FAILED at 2965.
Hunk #14 succeeded at 3030 (offset 53 lines).
Hunk #16 succeeded at 3072 (offset 53 lines).
Hunk #18 succeeded at 3206 (offset 53 lines).
6 out of 19 hunks FAILED -- saving rejects to file pcm_native.c.rej
make[1]: *** [pcm_native.c] Error 1
make[1]: Leaving directory `/u2/lfs/alsa-cvsexport-2003-12-31/alsa-driver/acore'
make: *** [dep] Error 1

The patch file in 2003-12-31/alsa-driver/acore/pcm_native.patch
needs updating.

Ted.
-- 
Ted <ted@nowtsfree.freeserve.co.uk>
   http://www.nowtsfree.freeserve.co.uk


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
