From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0001278]: fails to read volume for software volume control
Date: Mon, 1 Aug 2005 08:09:03 +0200
Message-ID: <172303d810b2a193d51d581272e9445a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C125F1AC
	for <alsa-devel@alsa-project.org>; Mon,  1 Aug 2005 08:09:03 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1278> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - liboss
Issue ID:                   1278
Category:                   
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-23-2005 18:23 CEST
Last Modified:              08-01-2005 08:09 CEST
======================================================================
Summary:                    fails to read volume for software volume control
Description: 
From: http://bugs.debian.org/319628:

Package: alsa-oss
Version: 1.0.8-1

Hi,

My MacMini's audio chip seems to have no hardware volume control (or it 
is unsupported in the kernel I use), so I use software volume control, 
with the attached .asoundrc. (I'm still a newbie about alsa, there may 
be some mistakes in my .soundrc file.)

While trying to use hotkeys (that only understands oss) with aoss, I 
discovered that aoss did not allow to read the volume control, while it 
can write it flawlessly.

After a few tests, I discovered that it was related to the failing 
snd_mixer_selem_get_playback_switch function call, and I could 
workaround the issue with the attached trivial quick&dirty patch.


Cheers,

Nicolas Boullis


-- System Information:
Debian Release: 3.1
Architecture: powerpc (ppc)
Kernel: Linux 2.6.12-irma
Locale: LANG=C, LC_CTYPE=C (charmap=ANSI_X3.4-1968)

Versions of packages alsa-oss depends on:
ii  libasound2                  1.0.8-3      ALSA library
ii  libc6                       2.3.2.ds1-22 GNU C Library: Shared
libraries an

-- no debconf information



pcm.!default {
  type plug
  slave {
    pcm {
      type softvol
      slave {
        pcm {
	  type dmix
	  ipc_key 7666
	  slave {
	    pcm "hw:0,0"
	    period_time 0
	    period_size 1024
	    buffer_size 8192
	    rate 44100
	  }
	}
      }
      control {
        name Master
        card 0
      }
    }
  }
}

pcm.dsp0 {
  type plug
  slave.pcm "!default"
}




only in patch2:
unchanged:
--- alsa-oss-1.0.8.orig/alsa/mixer.c
+++ alsa-oss-1.0.8/alsa/mixer.c
@@ -487,9 +487,7 @@
 				break;
 			}
 			err = snd_mixer_selem_get_playback_switch(elem,
SND_MIXER_SCHN_FRONT_LEFT, &sw);
-			if (err < 0) 
-				break;
-			if (sw) {
+			if ((err < 0) || (sw)) {
 				err = snd_mixer_selem_get_playback_volume(elem,
SND_MIXER_SCHN_FRONT_LEFT, &lvol);
 				if (err < 0) 
 					break;
@@ -499,9 +497,7 @@
 				rvol = lvol;
 			} else {
 				err = snd_mixer_selem_get_playback_switch(elem,
SND_MIXER_SCHN_FRONT_RIGHT, &sw);
-				if (err < 0) 
-					break;
-				if (sw) {
+				if ((err < 0) || (sw)) { 
 					err = snd_mixer_selem_get_playback_volume(elem,
SND_MIXER_SCHN_FRONT_RIGHT, &rvol);
 					if (err < 0) 
 						break;



======================================================================

----------------------------------------------------------------------
 tiwai - 07-29-05 18:02 
----------------------------------------------------------------------
Isn't is already fixed in 1.0.9?

----------------------------------------------------------------------
 jdthood - 08-01-05 08:09 
----------------------------------------------------------------------
No, the submitter reports that the bug is still present in 1.0.9.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-23-05 18:23 jdthood        New Issue                                    
07-29-05 18:02 tiwai          Note Added: 0005584                          
08-01-05 08:09 jdthood        Note Added: 0005594                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
