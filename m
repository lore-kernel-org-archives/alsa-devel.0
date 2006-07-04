From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001724]: au88x0 PCM configuration
	problem - buffer_size constraint
Date: Tue, 4 Jul 2006 13:37:08 +0200
Message-ID: <cd5db738130e95c6e101ab78d4b48a1f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6255C13D
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Jul 2006 13:37:08 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
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
Last Modified:              07-04-2006 13:37 CEST
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
 Raymond - 07-02-06 09:24 
----------------------------------------------------------------------
Refer to alsa-lib-1.0.12rc1/test/pcm_min.c

Is the parameter "latency" used to refine the two constraints (period_size
and buffer_size) to an unique value ?

As pcm_min.c use "default" in snd_pcm_set_params(), and "default" of
intel8x0 use dmix. 

Do dmix introduce any latency when mixing several PCM playback streams ?

Do snd_pcm_set_params() return error if the specified latency is less than
the latency of dmix ?

----------------------------------------------------------------------
 Raymond - 07-04-06 13:37 
----------------------------------------------------------------------
period time (min=21333   max=85334)
           21334
           42667
           85334
buffer time (min=42666   max=1365334)
           42667
           85334
           106667
           149334
           170667
           213334
           234667
           277334
           298667
           341334
           362667
           405334
           426667
           469334
           490667
           533334
           554667
           597334
           618667
           661334
           682667
           725334
           810667
           853334
           938667
           981334
           1066667
           1109334
           1194667
           1237334
           1322667
           1365334


	 err = snd_pcm_hw_params_get_period_time_min(hwparams, &time_min, &dir);
	 if (err < 0) 
	     printf("Unable to get period time min for playback: %s\n",
snd_strerror(err));
	 err = snd_pcm_hw_params_get_period_time_max(hwparams, &time_max, &dir);
	 if (err < 0) 
		printf("Unable to get period time max for playback: %s\n",
snd_strerror(err));
         
         printf("period time (min=%d   max=%d)\n",time_min,time_max);
	 for (size=time_min; size<=time_max; size++)
	     if ( snd_pcm_hw_params_test_period_time(pcm,hwparams,size,dir) == 0
)
                 printf("           %d\n",size);


	 err = snd_pcm_hw_params_get_buffer_time_min(hwparams, &time_min, &dir);
	 if (err < 0) 
	     printf("Unable to get buffer time min for playback: %s\n",
snd_strerror(err));
	 err = snd_pcm_hw_params_get_buffer_time_max(hwparams, &time_max, &dir);
	 if (err < 0) 
		printf("Unable to get buffer time max for playback: %s\n",
snd_strerror(err));
         
         printf("buffer time (min=%d   max=%d)\n",time_min,time_max);
	 for (size=time_min; size<=time_max; size++)
	     if ( snd_pcm_hw_params_test_buffer_time(pcm,hwparams,size,dir) == 0
)
                 printf("           %d\n",size);

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
03-07-06 14:18 Raymond        Note Edited: 0007844                         
03-24-06 10:51 Raymond        File Added: snd_pcm_set_params.patch              
     
03-30-06 18:35 Raymond        Note Added: 0009036                          
05-22-06 15:11 Raymond        Note Deleted: 0008055                        
05-22-06 15:12 Raymond        Note Deleted: 0008362                        
05-22-06 15:13 Raymond        Note Deleted: 0008130                        
05-22-06 15:14 Raymond        Note Deleted: 0008083                        
05-22-06 15:15 Raymond        Note Deleted: 0009036                        
05-22-06 15:16 Raymond        Note Deleted: 0007860                        
05-22-06 15:17 Raymond        Note Deleted: 0007848                        
05-22-06 15:20 Raymond        Note Deleted: 0007940                        
05-22-06 15:24 Raymond        Note Deleted: 0007954                        
05-22-06 15:48 Raymond        Note Added: 0009912                          
05-30-06 09:36 Raymond        Note Added: 0010017                          
05-30-06 09:38 Raymond        Note Edited: 0010017                         
05-30-06 18:31 rlrevell       Note Added: 0010020                          
06-30-06 13:49 Raymond        File Added: test.c                           
06-30-06 13:53 Raymond        Note Added: 0010734                          
06-30-06 13:55 Raymond        Note Edited: 0010734                         
07-01-06 04:20 Raymond        Note Added: 0010756                          
07-01-06 04:21 Raymond        Note Edited: 0010756                         
07-01-06 04:22 Raymond        Note Edited: 0010756                         
07-02-06 09:24 Raymond        Note Added: 0010773                          
07-04-06 13:37 Raymond        Note Added: 0010820                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
