From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001990]: aplay/arecord cannot play/capture A_LAW
Date: Tue, 25 Apr 2006 11:46:53 +0200
Message-ID: <351c6c768b7b7241a36acd0b085576e6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3C62D16B
	for <alsa-devel@alsa-project.org>; Tue, 25 Apr 2006 11:46:54 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1990> 
======================================================================
Reported By:                Raymond
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Issue ID:                   1990
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             04-01-2006 04:26 CEST
Last Modified:              04-25-2006 11:46 CEST
======================================================================
Summary:                    aplay/arecord cannot play/capture A_LAW
Description: 
aplay/arecord can play MU_LAW and the sound card support MU_LAW and A_LAW

arecord -D hw:0,0 -f MU_LAW -t au -c 1 -r 8000 test.au

aplay -D hw:0,0 test.au


Try to use -t raw but the quality of A_LAW is very bad when compare with
MU_LAW

arecord -D hw:0,0 -f A_LAW -t raw -c 1 -r 8000 test.raw

aplay -D hw:0,0 test.raw


======================================================================

----------------------------------------------------------------------
 Raymond - 04-25-06 02:59 
----------------------------------------------------------------------
au88xx driver also support A-Law and MU-LAW.

aplay -v -f A_LAW -Dossdriver test.raw
Playing raw data 'test.raw' : A-Law, Rate 8000 Hz, Mono
aplay: set_params:901: Sample format non available


pcm.alawoss {
        type alaw              
        slave {
		pcm ossdriver
		format S16_LE
	}
}

aplay -v -f A_LAW -Dalawoss test.raw
Playing raw data 'test.raw' : A-Law, Rate 8000 Hz, Mono
A-Law conversion PCM (S16_LE)
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : A_LAW
  subformat    : STD
  channels     : 1
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 8
  buffer_size  : 4096
  period_size  : 1024
  period_time  : 128000
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 1024
  xfer_align   : 1024
  start_threshold  : 4096
  stop_threshold   : 4096
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
Slave: ALSA <-> OSS PCM I/O Plugin
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 16
  buffer_size  : 4096
  period_size  : 1024
  period_time  : 128000
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 1024
  xfer_align   : 1024
  start_threshold  : 4096
  stop_threshold   : 4096
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824

----------------------------------------------------------------------
 tiwai - 04-25-06 11:46 
----------------------------------------------------------------------
IT IS OFF-TOPIC.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-01-06 04:26 Raymond        New Issue                                    
04-03-06 07:16 Raymond        Note Added: 0009085                          
04-03-06 07:36 Raymond        Note Added: 0009086                          
04-07-06 19:32 tiwai          Note Added: 0009152                          
04-08-06 07:47 Raymond        Note Added: 0009171                          
04-10-06 16:52 tiwai          Note Added: 0009199                          
04-11-06 07:46 Raymond        Note Added: 0009229                          
04-11-06 07:55 Raymond        Note Edited: 0009229                         
04-11-06 09:41 Raymond        Note Edited: 0009229                         
04-20-06 15:29 tiwai          Status                   new => resolved     
04-20-06 15:29 tiwai          Resolution               open => not an issue
04-20-06 15:29 tiwai          Assigned To               => tiwai           
04-20-06 15:29 tiwai          Note Added: 0009384                          
04-24-06 15:07 Raymond        Status                   resolved => feedback
04-24-06 15:07 Raymond        Resolution               not an issue => reopened
04-24-06 15:07 Raymond        Note Added: 0009451                          
04-24-06 15:48 tiwai          Status                   feedback => resolved
04-24-06 15:48 tiwai          Resolution               reopened => not an issue
04-24-06 15:48 tiwai          Note Added: 0009453                          
04-24-06 16:43 Raymond        Status                   resolved => feedback
04-24-06 16:43 Raymond        Resolution               not an issue => reopened
04-24-06 16:43 Raymond        Note Added: 0009468                          
04-24-06 16:50 tiwai          Status                   feedback => resolved
04-24-06 16:50 tiwai          Resolution               reopened => not an issue
04-24-06 16:50 tiwai          Note Added: 0009472                          
04-25-06 02:59 Raymond        Status                   resolved => feedback
04-25-06 02:59 Raymond        Resolution               not an issue => reopened
04-25-06 02:59 Raymond        Note Added: 0009483                          
04-25-06 11:46 Raymond        File Added: pcm_oss_mulaw_alaw.patch              
     
04-25-06 11:46 tiwai          Status                   feedback => resolved
04-25-06 11:46 tiwai          Resolution               reopened => not an issue
04-25-06 11:46 tiwai          Note Added: 0009487                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
