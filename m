From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000643]: Crash in snd_pcm_wait()
Date: Mon, 20 Dec 2004 14:43:59 +0100
Message-ID: <64c1b9197e4549087b37a799895ef3c2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 663032EE
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2004 14:43:59 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=643> 
======================================================================
Reported By:                rbultje
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   643
Category:                   ordinary pcm
Reproducibility:            sometimes
Severity:                   minor
Priority:                   normal
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-11-2004 17:40 CET
Last Modified:              12-20-2004 14:43 CET
======================================================================
Summary:                    Crash in snd_pcm_wait()
Description: 
Hi,

http://bugzilla.gnome.org/show_bug.cgi?id=151520 reports assertion
failures in snd_pcm_wait(). The calling code looks like this:


  if (snd_pcm_state (this->handle) == SND_PCM_STATE_RUNNING) {
    if ((err = snd_pcm_wait (this->handle, 1000)) < 0) {
      [error handling]
    }
    [some more]
  }

It crashes inside snd_pcm_wait() on line 2097 of src/pcm/pcm.c,
"assert(err == 1);".

Interestingly, if you call snd_pcm_state(pcm) inside snd_pcm_wait() right
before the failing assertion (line 2097 of src/pcm/pcm.c), it will return
3, which is SND_PCM_STATE_XRUN, I think. This means I cannot work around
it (because state changes while inside this function) without using my own
snd_pcm_wait() implementation.

Changing the "assert(err==1);" into a "if (err < 0) return err;", it works
(this is not in the bug report because this was figured out while
debugging the issue on IRC). I'm not sure if this is the correct fix,
though.

For information about the soundcard (seems to trigger at least with the
snd-intel8x0 driver when using dmix) or contacting information about the
original reporters, feel free to ask me or see the original bug report.
======================================================================

----------------------------------------------------------------------
 thrope - 11-12-04 19:51 
----------------------------------------------------------------------
This happens to me also 

gst-launch-0.8 sinesrc ! alsasink device=jackplug

yields:
RUNNING pipeline ...
gst-launch-0.8: pcm.c:2094: snd_pcm_wait: Assertion `err == 1' failed.
Aborted

The patch descibed (change "assert(err==1);" into a "if (err < 0) return
err;") fixed the problem.

I am using an M-Audio Delta 44, (driver snd-ice1712)

----------------------------------------------------------------------
 tiwai - 11-18-04 18:21 
----------------------------------------------------------------------
The if (...) was inserted as proposed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-11-04 17:40 rbultje        New Issue                                    
11-12-04 13:18 zaheerm        Issue Monitored: zaheerm                     
11-12-04 13:32 zaheerm        Note Added: 0002394                          
11-12-04 19:51 thrope         Note Added: 0002400                          
11-18-04 18:21 tiwai          Status                   new => resolved     
11-18-04 18:21 tiwai          Resolution               open => fixed       
11-18-04 18:21 tiwai          Assigned To               => tiwai           
11-18-04 18:21 tiwai          Note Added: 0002456                          
11-27-04 16:40 koenraad       Issue Monitored: koenraad                    
11-27-04 16:40 koenraad       Issue End Monitor: koenraad                    
12-20-04 14:43 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
