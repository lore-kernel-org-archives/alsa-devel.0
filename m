From: Supphachoke Suntiwichaya <mrchoke@opentle.org>
Subject: Re: au88xo spin_lock and spin_unlock error
Date: Mon, 13 Oct 2003 11:05:40 +0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F8A2494.30001@opentle.org>
References: <3F8A1C45.6040403@opentle.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060805000202070003000808"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F8A1C45.6040403@opentle.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060805000202070003000808
Content-Type: text/plain; charset=TIS-620; format=flowed
Content-Transfer-Encoding: 8bit

Again
       Check my patch , it correct ?

MrChoke

Supphachoke Suntiwichaya wrote:

> Hi,
>    I can't  compile ALSA-DRIVER 0.9.7b .
>
> ====
> In file included from au8810_core.c:2:
> au88x0_core.c: In function `vortex_adb_allocroute':
> au88x0_core.c:1780: incompatible type for argument 1 of `_raw_spin_lock'
> au88x0_core.c:1887: incompatible type for argument 1 of 
> `_raw_spin_unlock'
> make[2]: *** [au8810_core.o] Error 1
> make[1]: *** [_modsubdir_au88x0] Error 2
>
> ====
> I used kernel 2.4.22
> http://www-ccrma.stanford.edu/planetccrma/software/system.html#kernel
>
> MrChoke



-- 

Name : Supphachoke Suntiwichaya
Email : MrChoke@opentle.org
URL : http://jedi.links.nectec.or.th/mrchoke/
Distribution : Linux TLE 5.0 (Andaman)
OS : Linux 2.4.23-pre4-tv #2 อา. ก.ย. 14 16:58:21 ICT 2003 i686 GNU/Linux
Uptime :  11:05:00  up 6 days, 19:19,  1 user,  load average: 0.38, 0.42, 0.27


--------------060805000202070003000808
Content-Type: text/plain;
 name="alsa-driver-0.9.7b-spin.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-driver-0.9.7b-spin.patch"

--- alsa-driver-0.9.7b/pci/au88x0/au88x0_core.c	2003-10-06 21:01:04.000000000 +0700
+++ alsa-driver-0.9.7b/pci/au88x0/au88x0_core.c-spin	2003-10-13 10:46:53.000000000 +0700
@@ -1777,7 +1777,7 @@
 	if ((nr_ch == 3) || ((dir == SNDRV_PCM_STREAM_CAPTURE)&&(nr_ch > 2)))
 		return -EBUSY;
 	
-	spin_lock(vortex->lock);
+	spin_lock(&vortex->lock);
 	if (dma >= 0) {
    		en = 0;
 		vortex_adb_checkinout(vortex, vortex->dma_adb[dma].resources, en, VORTEX_RESOURCE_DMA);
@@ -1884,7 +1884,7 @@
 		}
 	}
 	vortex->dma_adb[dma].nr_ch = nr_ch;
-	spin_unlock(vortex->lock);
+	spin_unlock(&vortex->lock);
 	
 #if 0
 	/* AC97 Codec channel setup. FIXME: this has no effect !! */

--------------060805000202070003000808--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
