From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001895]: nvidia 6150 --- desparate attempt fails at  snd_verbose_printk
Date: Wed, 8 Mar 2006 15:28:23 +0100
Message-ID: <079ad9c6f71aaefde0d50ed5ee1057fe@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2BA351D9
	for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2006 15:28:24 +0100 (MET)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1895> 
======================================================================
Reported By:                iaw4
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1895
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               gentoo
Kernel Version:             2.6.15.5
======================================================================
Date Submitted:             03-07-2006 03:24 CET
Last Modified:              03-08-2006 15:28 CET
======================================================================
Summary:                    nvidia 6150 --- desparate attempt fails at 
snd_verbose_printk
Description: 

I am trying to make the built-in sound on the ASUS A8N CSM VM (nvidia
6150) to work.  apparently, a realtek 880 might also work.  I was told
that the NFORCE drivers do not support it.  it seems to be some variant of
intel high-definition audio.  I was hoping the latest ALSA would support
it.  (Right wrong?)

So, I downloaded the most recent ALSA distribution.  My linux kernel is
linux-2.6.15.5.  I read the ALSA docs.  [by the way, most docs talk about
having to have the soundcore enabled.  this is unclear, because I do not
believe this is how the kernel 2.6.15.5 calls this anymore.  I think all
that is meant here is that the very top selection of sound in the kernel
must be on, which would be CONFIG_SOUND=y in this kernel.  not sure.]

The new ALSA compilation and installation works great.  Alas, now I want
to try the intel driver next, which depends on snd_ac97_codec.  alas,
despite a completely fresh installation, upon a "modprobe snd_ac97_codec",
it fails to find snd_verbose_printk.  I thought modprobe could insert
dependencies automatically.  either I am wrong here, or there is a
dependency that is not marked appropriately.

======================================================================

----------------------------------------------------------------------
 iaw4 - 03-08-06 15:11 
----------------------------------------------------------------------
search for ad1986a and 6150 comes up with
  http://sourceforge.net/mailarchive/message.php?msg_id=14788959
alas, no solution info.

search for ad1986a and snd_hda_intel comes up with some info on
  http://sourceforge.net/mailarchive/message.php?msg_id=13966280
http://sourceforge.net/mailarchive/message.php?msg_id=14701205 [patch]

http://sourceforge.net/mailarchive/message.php?msg_id=14857657 suggests
the position-fix and 3stack-digout, which does not do it for me.

patch is also at
http://www.nabble.com/Intel-HDA-AD1986A-without-surround-t595968.html .

alas, under the latest alsa release, the patch fails.  yikes.  so, this
chipset combo is pretty much a failure all around.  I am ready to give up.
 time for someone to donate a motherboard to the relevant ALSA developer.

sound is really the most important remaining weakness of linux relative to
windows.  the alsa team really does have a tough job.

regards,

/iaw


patch -p0 < patch.patch
patching file hda/hda_codec.c
Hunk #1 succeeded at 1909 (offset 153 lines).
Hunk #2 succeeded at 1919 (offset 153 lines).
Hunk #3 FAILED at 1931.
1 out of 3 hunks FAILED -- saving rejects to file hda/hda_codec.c.rej
iaw@/usr/src/alsa-1.0.11rc3/alsa-driver-1.0.11rc3/pci:0:523 root## more
patch.patch
--- hda/hda_codec.c     2006-01-18 19:17:24.890773500 -0500
+++ hda/hda_codec.c.orig        2006-01-03 21:38:43.257711250 -0500
@@ -1756,6 +1756,7 @@
        if (mout->hp_nid)
                /* headphone out will just decode front left/right
(stereo) */
                snd_hda_codec_setup_stream(codec, mout->hp_nid,
stream_tag, 0, format);
+#if 0
        /* surrounds */
        for (i = 1; i < mout->num_dacs; i++) {
                if (chs >= (i + 1) * 2) /* independent out */
@@ -1765,6 +1766,7 @@
                        snd_hda_codec_setup_stream(codec, nids[i],
stream_tag, 0,
                                                   format);
        }
+#endif
        return 0;
 }

@@ -1776,10 +1778,14 @@
        hda_nid_t *nids = mout->dac_nids;
        int i;

+#if 0
        for (i = 0; i < mout->num_dacs; i++)
                snd_hda_codec_setup_stream(codec, nids[i], 0, 0, 0);
+#endif
        if (mout->hp_nid)
                snd_hda_codec_setup_stream(codec, mout->hp_nid, 0, 0, 0);
+       snd_hda_codec_setup_stream(codec, HDA_FRONT, 0, 0, 0);
+
        down(&codec->spdif_mutex);
        if (mout->dig_out_nid && mout->dig_out_used == HDA_DIG_ANALOG_DUP)
{
                snd_hda_codec_setup_stream(codec, mout->dig_out_nid, 0, 0,
0);

----------------------------------------------------------------------
 tiwai - 03-08-06 15:28 
----------------------------------------------------------------------
Try the patch ad1986a-2ch-model.diff with ALSA CVS version, and pass
"model=2ch".

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-07-06 03:24 iaw4           New Issue                                    
03-07-06 03:24 iaw4           Distribution              => gentoo          
03-07-06 03:24 iaw4           Kernel Version            => 2.6.15.5        
03-07-06 06:27 stevenellis    Issue Monitored: stevenellis                    
03-07-06 06:30 stevenellis    Note Added: 0008361                          
03-07-06 19:03 iaw4           Note Added: 0008371                          
03-07-06 19:21 rlrevell       Note Added: 0008372                          
03-07-06 20:24 iaw4           Note Added: 0008374                          
03-07-06 20:37 Arnaud Patard  Note Added: 0008375                          
03-07-06 20:38 Arnaud Patard  Note Edited: 0008375                         
03-07-06 20:39 er-ku          Note Added: 0008376                          
03-07-06 21:45 iaw4           Note Added: 0008377                          
03-07-06 21:53 rlrevell       Note Added: 0008378                          
03-08-06 00:12 stevenellis    Note Added: 0008379                          
03-08-06 15:11 iaw4           Note Added: 0008381                          
03-08-06 15:28 tiwai          Note Added: 0008382                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
