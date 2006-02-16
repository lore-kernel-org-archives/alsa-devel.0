From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001724]: au88x0 PCM configuration problem - buffer_size constraint
Date: Thu, 16 Feb 2006 04:01:51 +0100
Message-ID: <52210c6f3ed8cd7d84e89f8d864679e4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3301219A
	for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2006 04:01:51 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1724> 
======================================================================
Reported By:                Raymond
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   1724
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-07-2006 05:10 CET
Last Modified:              02-16-2006 04:01 CET
======================================================================
Summary:                    au88x0 PCM configuration problem - buffer_size
constraint
Description: 
/cvs/alsa-lib/test/pcm_min

ALSA lib pcm.c:7127:(snd_pcm_set_params) Unable to set buffer time
(latency) 500000 for PLAYBACK: Invalid argument
Playback open error: Invalid argument

sound card is au8830, the au88x0 driver only accept period size in power
of 2.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001766 jackd : ALSA: cannot set period size to...
======================================================================

----------------------------------------------------------------------
 Raymond - 02-13-06 17:02 
----------------------------------------------------------------------
Is it possible for au8830 to support surround51 by panning the center to
front speakers and bass to 4 speakers ?

<confdir:pcm/surround51.conf>

AU8830.pcm.surround51.0 {
	@args [ CARD ]
	@args.CARD {
		type string
	}
	type multi
	slaves [
		{
			pcm {
				@func concat
				strings [
					"cards.AU8830.pcm.surround40.0:CARD=" $CARD
				]
			}
			channels 4
		}
		{
			pcm {
				@func concat
				strings [
					"cards.AU8830.pcm.front.0:CARD=" $CARD
				]
			}
			channels 1
		}
		{
			pcm {
				@func concat
				strings [
					"cards.AU8830.pcm.surround40.0:CARD=" $CARD
				]
			}
			channels 1
		}
	]
	bindings [
		{ slave 0 channel 0 }
		{ slave 0 channel 1 }
		{ slave 0 channel 2 }
		{ slave 0 channel 3 }
		{ slave 1 channel 0 }
		{ slave 2 channel 0 }
	]
}



----------------------------------------------------------------------
 Raymond - 02-16-06 04:01 
----------------------------------------------------------------------
http://www.alsa-project.org/~iwai/writing-an-alsa-driver/x639.htm#PCM-INTERFACE-OPERATORS-PREPARE-CALLBACK

Can those parameters runtime->rate, runtime->format, runtime->channels
pass to prepare callback different from those accepted by hw_params
callback ?

As mixer, src are dynamically allocated, the current au88x0 driver do not
support any change in runtime->channels after hw_params callback.

snd_pcm_recover() will call snd_pcm_prepare() when underrun occur.

Which runtime parameters will be changed when underrun occur ?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-07-06 05:10 Raymond        New Issue                                    
01-09-06 15:19 Raymond        Note Added: 0007537                          
01-19-06 15:04 Raymond        Note Deleted: 0007537                        
01-19-06 15:36 Raymond        Note Added: 0007721                          
01-28-06 07:58 Raymond        Note Added: 0007828                          
01-28-06 07:58 Raymond        Note Deleted: 0007721                        
01-30-06 18:46 Raymond        Note Added: 0007840                          
01-31-06 03:15 Raymond        Note Added: 0007844                          
01-31-06 06:41 Raymond        Note Edited: 0007840                         
01-31-06 07:03 Raymond        Note Edited: 0007840                         
01-31-06 07:08 Raymond        Note Edited: 0007840                         
01-31-06 07:11 Raymond        Note Edited: 0007840                         
01-31-06 08:31 Raymond        Note Edited: 0007840                         
01-31-06 09:48 Raymond        Note Edited: 0007844                         
01-31-06 10:19 perex          Note Added: 0007845                          
01-31-06 10:26 perex          Note Added: 0007847                          
01-31-06 10:26 perex          Note Edited: 0007847                         
01-31-06 10:48 perex          Project                  ALSA - lib => ALSA -
driver
01-31-06 10:49 perex          Category                 0_general => PCI - au88x0
01-31-06 10:49 perex          Summary                  simple PCM helper
function => au88x0 PCM configuration problem - buffer_size constraint
01-31-06 11:06 Raymond        Note Added: 0007848                          
01-31-06 13:48 perex          Status                   new => assigned     
01-31-06 13:48 perex          Assigned To               => mjander         
01-31-06 13:49 perex          Relationship added       related to 0001766  
01-31-06 15:59 Raymond        Note Added: 0007852                          
02-01-06 07:35 perex          Note Added: 0007857                          
02-01-06 10:32 Raymond        Note Added: 0007858                          
02-01-06 10:37 Raymond        Note Edited: 0007848                         
02-01-06 17:15 Raymond        Note Edited: 0007844                         
02-01-06 17:20 Raymond        Note Added: 0007860                          
02-02-06 10:23 Raymond        Note Added: 0007874                          
02-02-06 11:10 Raymond        Note Edited: 0007874                         
02-02-06 15:48 Raymond        Note Edited: 0007874                         
02-03-06 14:26 Raymond        Note Added: 0007897                          
02-04-06 02:46 Raymond        Note Edited: 0007874                         
02-04-06 02:52 Raymond        Note Edited: 0007858                         
02-04-06 02:56 Raymond        Note Edited: 0007858                         
02-05-06 16:39 Raymond        Note Added: 0007939                          
02-05-06 16:48 Raymond        Note Added: 0007940                          
02-06-06 04:40 Raymond        Note Deleted: 0007939                        
02-06-06 06:15 Raymond        Note Edited: 0007940                         
02-07-06 07:35 Raymond        Note Added: 0007954                          
02-13-06 03:11 Raymond        Note Added: 0008036                          
02-13-06 08:52 mjander        Note Added: 0008039                          
02-13-06 16:57 Raymond        Note Added: 0008055                          
02-13-06 17:02 Raymond        Note Edited: 0008055                         
02-13-06 17:02 Raymond        Note Edited: 0008055                         
02-16-06 04:01 Raymond        Note Added: 0008083                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
