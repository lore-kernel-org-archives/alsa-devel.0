From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000385]: Rate conversion plugin generates noise on frequency reduction
Date: Fri, 22 Oct 2004 16:35:22 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <d43ba6cb9166fed0d81b7ab7d25e9592@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C83532A8
	for <alsa-devel@alsa-project.org>; Fri, 22 Oct 2004 16:35:22 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=385> 
======================================================================
Reported By:                fmoraes
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   385
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             07-13-2004 19:46 CEST
Last Modified:              10-22-2004 16:35 CEST
======================================================================
Summary:                    Rate conversion plugin generates noise on frequency
reduction
Description: 
When reducing the frequency, the pcm_rate plugin causes noise on the output
data. This has been tested with both the snd-cs46xx and snd-emu10k1x
drivers and the following .asoundrc can be used to recreate the output in
a file:

pcm.CS46xx {
	type hw
	card 0
}

pcm.filetest {
	type file
	slave {
		pcm "CS46xx"
	}
	file "/home/fmoraes/test-out.raw"
	format "raw"
}

pcm.test {
	type rate
	slave {
		pcm "filetest"
		format "S16_LE"
		rate 8000
	}
}

Playing a 48Khz file will cause noticeable noise on the output (noise is
more noticeable the lower the target frequency is).
======================================================================

----------------------------------------------------------------------
 Tobias Diedrich - 10-21-04 17:01 
----------------------------------------------------------------------
I second that.  Downsampling even from 48000Hz to 44100Hz produces very
noticable artifacts, which sound very much like nearest neighbour
resampling artifacts and are especially evident in high pitched vocals. 
It would also be nice to implement better resampling methods than just
linear resampling, AFAICS from the source polyphase and bandlimited
resampling are planned but not yet implemented.

----------------------------------------------------------------------
 perex - 10-22-04 16:34 
----------------------------------------------------------------------
The reported problem should be solved in 1.0.7rc releases.

At the time, we don't have free resources to write code for another
resampling method. Also, there are several problems to use methods based
on sample history.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-13-04 19:46 fmoraes        New Issue                                    
07-15-04 14:07 perex          Status                   new => assigned     
07-15-04 14:07 perex          Assigned To               => perex           
10-21-04 16:57 Tobias DiedrichIssue Monitored: Tobias Diedrich                  
 
10-21-04 17:01 Tobias DiedrichNote Added: 0002223                          
10-22-04 16:19 perex          Project                  ALSA - driver => ALSA -
lib
10-22-04 16:20 perex          Category                 OTHERS => pcm - digital
audio
10-22-04 16:34 perex          Note Added: 0002244                          
10-22-04 16:35 perex          Status                   assigned => resolved
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
