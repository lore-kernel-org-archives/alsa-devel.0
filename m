From: Kai Vehmanen <k@eca.cx>
Subject: =?ISO-8859-1?Q?=5Bpatch=5D=A0alsa-lib=2Fsrc=2Fpcm=2Fpcm=5Fhw=2Ec?=
Date: Thu, 21 Feb 2002 19:03:58 +0200 (EET)
Message-ID: <Pine.LNX.4.44.0202211901260.3739-100000@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Huh, I thought I killed jack for good - no sound at all, just huge amount
of xruns. Luckily it was a false alarm, jack is still live and kicking...
following patch helps to the problem. ;)

--cut--
Index: src/pcm/pcm_hw.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_hw.c,v
retrieving revision 1.94
diff -u -r1.94 pcm_hw.c
--- src/pcm/pcm_hw.c    21 Feb 2002 15:01:34 -0000      1.94
+++ src/pcm/pcm_hw.c    21 Feb 2002 17:02:18 -0000
@@ -653,6 +653,7 @@
                        /* everything is ok, state == SND_PCM_STATE_XRUN at the moment */
                        return -EPIPE;
                }
+               break;
        case SNDRV_PCM_STATE_XRUN:
                return -EPIPE;
        default:
--cut--

-- 
 http://www.eca.cx
 Audio software for Linux!


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
