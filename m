From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001656]: snd_pcm_writei seems to be unexpectedly busy-waiting
Date: Sat, 17 Dec 2005 18:40:35 +0100
Message-ID: <ae6fd9e13065e3f638a9aa858bf65461@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5F111181
	for <alsa-devel@alsa-project.org>; Sat, 17 Dec 2005 18:40:35 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1656> 
======================================================================
Reported By:                Tobias Diedrich
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1656
Category:                   1_pcm - digital audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             12-17-2005 18:40 CET
Last Modified:              12-17-2005 18:40 CET
======================================================================
Summary:                    snd_pcm_writei seems to be unexpectedly busy-waiting
Description: 
On at least an emu10k1 'mplayer -ao alsa -af surround foo.mp3' (Or any
other 4-channel audio file without '-af surround') hogs the cpu.
ltrace reveals that most of the time is spent in snd_pcm_writei.
Further investigation reveals, that snd_pcm_status_get_avail returns a
value slightly bigger than the selected chunk_size (say 1027), mplayer
proceeds to decode the corresponding amound of data and feeds it to
ao_alsa, which calls snd_pcm_writei, which returns after having written
only chunk_size (in this case 1024).  The surrounding while-loop proceeds
to call snd_pcm_writei a second time with the remainder (3 frames).  This
second call to snd_pcm_writei appears to be busy-waiting.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-17-05 18:40 Tobias DiedrichNew Issue                                    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
