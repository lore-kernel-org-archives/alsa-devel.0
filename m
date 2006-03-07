From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001724]: au88x0 PCM configuration problem - buffer_size constraint
Date: Tue, 7 Mar 2006 11:08:52 +0100
Message-ID: <99647bf02768ce28cda00593c8995b2c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A3C9E1BA
	for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2006 11:08:52 +0100 (MET)
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
Last Modified:              03-07-2006 11:08 CET
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
 Raymond - 02-19-06 06:39 
----------------------------------------------------------------------
What is the difference between "default" and "hw:0" pcm of au88x0 in
alsa-1.0.11rc3 ?

1) Do "default" pcm support more format than "hw:0" ? 

(e.g. SNDRV_PCM_FMTBIT_S16_BE, SNDRV_PCM_FMTBIT_S8, 24 bits format)

2) Do "default" pcm allow resample ? (e.g. 96000Hz )

3) Is the usage of snd_pcm_set_params() limited to "default" ?

4) What is the effect of set soft_resample = 1 in snd_pcm_set_params() for
SND_PCM_TYPE_HW pcm ?



----------------------------------------------------------------------
 Raymond - 03-07-06 11:08 
----------------------------------------------------------------------
Patch to make snd_pcm_set_params() work for au88x0


Index: alsa-lib/src/pcm/pcm.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm.c,v
retrieving revision 1.323
diff -u -r1.323 pcm.c
--- alsa-lib/src/pcm/pcm.c	27 Feb 2006 09:58:32 -0000	1.323
+++ alsa-lib/src/pcm/pcm.c	7 Mar 2006 10:05:12 -0000
@@ -7088,7 +7088,7 @@
         const char *s = snd_pcm_stream_name(snd_pcm_stream(pcm));
         snd_pcm_uframes_t buffer_size, period_size;
         unsigned int rrate, period_time;
-        int err;
+        int err, dir;
 
         snd_pcm_hw_params_alloca(&params);
         snd_pcm_sw_params_alloca(&swparams);
@@ -7135,17 +7135,24 @@
 		SNDERR("Rate doesn't match (requested %iHz, get %iHz)", rate, err);
 		return -EINVAL;
 	}
-	/* set the buffer time */
-	err = INTERNAL(snd_pcm_hw_params_set_buffer_time_near)(pcm, params,
&latency, NULL);
+	/* test the buffer time */
+	err = snd_pcm_hw_params_test_buffer_time(pcm, params, latency, NULL);
 	if (err < 0) {
 	        /* error path -> set period size as first */
-        	/* set the period time */
-        	period_time = latency / 4;
-        	err = INTERNAL(snd_pcm_hw_params_set_period_time_near)(pcm,
params, &period_time, NULL);
-        	if (err < 0) {
-        		SNDERR("Unable to set period time %i for %s: %s", period_time,
s, snd_strerror(err));
-        		return err;
-        	}
+		err = INTERNAL(snd_pcm_hw_params_get_period_size_max)(params,
&period_size, NULL);
+                if (err < 0) {
+                	SNDERR("Unable to get period size max for %s: %s", s,
snd_strerror(err));
+                	return err;
+        	}                
+/*
+	FIXME - calculate period_size according to latency if necessary
+*/
+		dir=-1;
+		err = INTERNAL(snd_pcm_hw_params_set_period_size_near)(pcm, params,
&period_size, &dir);
+                if (err < 0) {
+                	SNDERR("Unable to set period size for %s: %s", s,
snd_strerror(err));
+                	return err;
+        	}                
                 err = INTERNAL(snd_pcm_hw_params_get_period_size)(params,
&period_size, NULL);
                 if (err < 0) {
                 	SNDERR("Unable to get period size for %s: %s", s,
snd_strerror(err));
@@ -7163,6 +7170,12 @@
         		return err;
         	}
 	} else {
+		/* set the buffer time */
+		err = INTERNAL(snd_pcm_hw_params_set_buffer_time_near)(pcm, params,
&latency, NULL);
+		if (err < 0) {
+        		SNDERR("Unable to set buffer time for %s: %s", s,
snd_strerror(err));
+        		return err;
+		}
 	        /* standard configuration buffer_time -> periods */
         	err = INTERNAL(snd_pcm_hw_params_get_buffer_size)(params,
&buffer_size);
         	if (err < 0) {

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
02-19-06 06:31 Raymond        Note Added: 0008130                          
02-19-06 06:39 Raymond        Note Edited: 0008130                         
03-07-06 11:08 Raymond        Note Added: 0008362                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
