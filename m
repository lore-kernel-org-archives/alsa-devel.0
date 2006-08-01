From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001823]: surround40 memory leak
Date: Tue, 1 Aug 2006 06:39:42 +0200
Message-ID: <fe0a654b0e9d50c83dff501cf4bfba68@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3DFEA12A
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Aug 2006 06:39:43 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1823> 
======================================================================
Reported By:                darkbrain
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1823
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-05-2006 22:59 CET
Last Modified:              08-01-2006 06:39 CEST
======================================================================
Summary:                    surround40 memory leak
Description: 
It seems that surround40 has a memory leak or somthing similar, playing a
game in surround40 mode the game result unplayable after some minutes. 
And there is a problem in CS46xx.conf file, i need to remove the hook on
the rear pcm to permit multiple surround40 subdevices to be opened.
======================================================================

----------------------------------------------------------------------
 Raymond - 08-01-06 03:52 
----------------------------------------------------------------------
>> No, the 'DAC Playback Volume' only works on Front (aka Master) and Rear.
It does not have any effect on Center and LFE.

It is because only the list of master_mix_scb and rear_mix_scb were
changed in cs46xx_dsp_set_dac_volume 

	/* main output */
	scb = ins->master_mix_scb->sub_list_ptr;
	while (scb != ins->the_null_scb) {
		cs46xx_dsp_scb_set_volume (chip,scb,left,right);
		scb = scb->next_scb_ptr;
	}

	/* rear output */
	scb = ins->rear_mix_scb->sub_list_ptr;
	while (scb != ins->the_null_scb) {
		cs46xx_dsp_scb_set_volume (chip,scb,left,right);
		scb = scb->next_scb_ptr;
	}

----------------------------------------------------------------------
 Raymond - 08-01-06 06:39 
----------------------------------------------------------------------
In theory, you should able to run 31 instances of 'speaker-test -c 2 -t
wav' concurrently , the 32th instances will be blocked on cs46xx

If you specify different rate in 'speaker-test -c 2 -r 8000 -t sine', the
driver  only allow to play DSP_MAX_SRC_NR instances different rates.

  if (ins->nsrc_scb >= DSP_MAX_SRC_NR) {
         snd_printk(KERN_ERR "dsp_spos: to many SRC instances\n!"); 


>> For testing I tried to play back more than 32 channels via speaker-test
. I did >>this for checking whether channels 33 and above would go on the
second AC97. But ...
>> 1) The channels above 32 just produce nonsense sounds (short, looping
sounds)
>> 2) The volume of the nonsense soundss could not be controlled (not by
KMix, and >> also not by alsamixer)

No, running speaker-test -c N with N > 2 on default device 'plughw' of
cs46xx is the side effect of 'plug' plugin in CS46xx.conf

Try open different device "default", "hw:0", "plughw:0" , "surround40" and
"surround51"

    snd_pcm_t *pcm;
    snd_pcm_hw_params_t *hwparams;
    int channel_max;
    if ( snd_pcm_open(&pcm, "default", SND_PCM_STREAM_PLAYBACK, 0) < 0 )
     	printf("Cannot open pcm.\n");
    else {
       	snd_pcm_hw_params_alloca(&hwparams);
       	snd_pcm_hw_params_any(pcm, hwparams);
	snd_pcm_hw_params_get_channels_max(hwparams, &channel_max);
        printf("max channels = %d\n",channel_max);
        snd_pcm_close(pcm);
   };

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-05-06 22:59 darkbrain      New Issue                                    
02-06-06 06:32 Raymond        Note Added: 0007943                          
02-06-06 07:10 Raymond        Note Edited: 0007943                         
02-06-06 07:31 Raymond        Note Edited: 0007943                         
02-06-06 07:32 Raymond        Note Edited: 0007943                         
02-06-06 10:46 darkbrain      Note Added: 0007945                          
02-06-06 10:46 darkbrain      Note Added: 0007946                          
02-06-06 10:47 darkbrain      Note Deleted: 0007946                        
02-06-06 18:37 darkbrain      Note Added: 0007950                          
02-11-06 15:01 darkbrain      Note Added: 0008018                          
02-12-06 05:09 Raymond        Note Added: 0008025                          
02-15-06 06:21 Raymond        Note Added: 0008076                          
02-21-06 07:56 Raymond        Note Added: 0008152                          
03-27-06 04:42 Raymond        Note Added: 0008987                          
06-02-06 09:33 Raymond        Note Deleted: 0008152                        
06-02-06 09:33 Raymond        Note Deleted: 0008987                        
06-02-06 09:34 Raymond        Note Deleted: 0008076                        
07-11-06 13:28 Raymond        Note Added: 0010970                          
07-24-06 21:21 bitmage2       Note Added: 0011215                          
07-24-06 21:25 bitmage2       Note Added: 0011216                          
07-25-06 02:41 Raymond        Note Added: 0011222                          
07-25-06 05:47 Raymond        Note Edited: 0011222                         
07-25-06 10:18 darkbrain      Note Added: 0011224                          
07-25-06 16:03 Raymond        Note Added: 0011228                          
07-25-06 20:29 bitmage2       Note Added: 0011231                          
07-26-06 02:21 Raymond        Note Added: 0011236                          
07-26-06 02:26 Raymond        Note Edited: 0011236                         
07-26-06 02:30 Raymond        Note Edited: 0011236                         
07-26-06 08:34 bitmage2       Note Added: 0011244                          
07-26-06 09:45 Raymond        Note Added: 0011246                          
07-26-06 09:51 Raymond        Note Edited: 0011246                         
07-26-06 09:56 Raymond        Note Edited: 0011246                         
07-26-06 10:04 Raymond        Note Edited: 0011246                         
07-26-06 10:08 Raymond        Note Edited: 0011246                         
07-26-06 10:14 Raymond        Note Edited: 0011246                         
07-26-06 16:26 Raymond        Note Added: 0011249                          
07-26-06 16:28 Raymond        Note Edited: 0011249                         
07-26-06 16:31 Raymond        Note Edited: 0011249                         
07-28-06 05:03 Raymond        Note Added: 0011282                          
07-28-06 10:25 Raymond        Note Edited: 0011282                         
07-29-06 05:13 Raymond        Note Added: 0011298                          
07-29-06 09:06 Raymond        Note Deleted: 0011298                        
07-29-06 12:20 bitmage2       Note Added: 0011299                          
07-29-06 12:23 bitmage2       Note Added: 0011300                          
07-29-06 14:02 Raymond        Note Added: 0011302                          
07-29-06 14:12 Raymond        Note Added: 0011303                          
07-29-06 14:50 bitmage2       Note Added: 0011304                          
07-29-06 14:51 bitmage2       File Added: proc-asound-card0-codec               
    
07-29-06 15:01 bitmage2       Note Added: 0011305                          
07-29-06 15:03 bitmage2       File Added: test.state                       
07-29-06 17:23 Raymond        Note Added: 0011309                          
07-29-06 22:44 bitmage2       Note Added: 0011311                          
07-30-06 03:26 Raymond        Note Added: 0011313                          
07-30-06 03:33 Raymond        Note Added: 0011314                          
07-30-06 03:39 Raymond        Note Edited: 0011314                         
07-30-06 03:41 Raymond        Note Edited: 0011314                         
07-30-06 11:52 darkbrain      Note Added: 0011317                          
07-31-06 05:39 Raymond        Note Added: 0011336                          
07-31-06 05:40 Raymond        Note Edited: 0011336                         
07-31-06 05:43 Raymond        Note Edited: 0011336                         
07-31-06 05:45 Raymond        Note Edited: 0011336                         
07-31-06 05:47 Raymond        Note Edited: 0011336                         
07-31-06 06:36 Raymond        Note Edited: 0011336                         
07-31-06 08:40 Raymond        Note Edited: 0011336                         
07-31-06 09:51 Raymond        Note Edited: 0011336                         
07-31-06 09:56 Raymond        Note Edited: 0011336                         
07-31-06 09:59 Raymond        Note Edited: 0011336                         
07-31-06 10:06 Raymond        Note Edited: 0011336                         
07-31-06 10:11 Raymond        Note Edited: 0011336                         
07-31-06 22:42 bitmage2       Note Added: 0011350                          
07-31-06 22:52 bitmage2       Note Added: 0011352                          
08-01-06 02:48 Raymond        Note Added: 0011363                          
08-01-06 02:53 Raymond        Note Edited: 0011363                         
08-01-06 03:52 Raymond        Note Added: 0011366                          
08-01-06 06:39 Raymond        Note Added: 0011370                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
