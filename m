From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001318]: Volume control per PCM
Date: Tue, 14 Feb 2006 03:05:39 +0100
Message-ID: <3c9a0d16145f78c78ddae8b423d6a804@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CF0DC169
	for <alsa-devel@alsa-project.org>; Tue, 14 Feb 2006 03:05:39 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1318> 
======================================================================
Reported By:                darkbrain
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1318
Category:                   PCI - cs46xx
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             08-07-2005 14:45 CEST
Last Modified:              02-14-2006 03:05 CET
======================================================================
Summary:                    Volume control per PCM
Description: 
Hi, i'm trying to implement a volume control per PCM streams, i've attached
a function that does the job. Unfortunally when it change the volume it
also change the equalizer cutting off low frequencyes. I think 
there is a problem with the second poke, infact withot that poke, the
volume works correctly for left case. Any suggestion? Any documentation?
Thanks,
   Dino

======================================================================

----------------------------------------------------------------------
 Raymond - 02-13-06 17:30 
----------------------------------------------------------------------
It is possible to find out the iface_pcm control of pcm SND_PCM_TYPE_HW.

int find_iface_pcm_elem(snd_pcm_t *pcm)
{
	snd_ctl_card_info_t *hw_info;
	snd_hctl_t *hctl;
	snd_hctl_elem_t *elem;
	snd_pcm_info_t *pcm_info;	
	char card[8];
	int card_number,no_of_elem,err;
	if ( pcm == NULL )
		return -EINVAL;
	no_of_elem=0;
	if ( snd_pcm_type(pcm) == SND_PCM_TYPE_HW ) {
	        snd_pcm_info_alloca(&pcm_info);
	        err = snd_pcm_info(pcm, pcm_info);
	        if ( err < 0 ) {
			return -ENOMEM;
	        };	
		card_number=snd_pcm_info_get_card(pcm_info);
		if ( card_number < 0 ) {
			return -EINVAL;
	    	};
	    	sprintf(card,"hw:%d",card_number);
	    	if ((err = snd_ctl_open(&ctl, card, 0)) < 0) {
			return -EINVAL;
 		};
		snd_ctl_card_info_alloca(&hw_info);
		if ((err = snd_ctl_card_info(ctl, hw_info)) < 0) {
			return -ENOMEM;
		}
		if ((err = snd_hctl_open(&hctl, card, 0)) < 0) {
			return err;
		}
		if ((err = snd_hctl_load(hctl)) < 0) {
			return err;
		}	
		snd_ctl_elem_info_alloca(&info);
		snd_ctl_elem_value_alloca(&val);
 		snd_ctl_elem_id_alloca(&id);
		for (elem = snd_hctl_first_elem(hctl); elem; elem =
snd_hctl_elem_next(elem)) {
        	    	if ( (err = snd_hctl_elem_info(elem, info)) < 0) 
				return err;
		    	else {
				if ( snd_ctl_elem_info_get_interface(info) == SND_CTL_ELEM_IFACE_PCM )
{
				        if ( snd_pcm_info_get_device(pcm_info) ==
snd_ctl_elem_info_get_device(info) ) {
				        	if ( snd_pcm_info_get_subdevice(pcm_info) ==
snd_ctl_elem_info_get_subdevice(info) ) {
					    		if ((err = snd_hctl_elem_read(elem, val)) < 0) 								
								return err;
							else {
							        snd_hctl_elem_get_id(elem, id);
								printf("%s device=%d subdevice=%d
%s\n",snd_pcm_info_get_name(pcm_info),
snd_ctl_elem_info_get_device(info),
snd_ctl_elem_info_get_subdevice(info),
snd_ctl_elem_id_get_name(id));
								no_of_elem++;
						    	};
                        			};
                    			};
                		};
            		};
        	};
		snd_hctl_close(hctl);
		snd_ctl_close(ctl);
	};
	return no_of_elem;
}

----------------------------------------------------------------------
 Raymond - 02-14-06 03:05 
----------------------------------------------------------------------
For SND_PCM_TYPE_MULIT and all slaves pcm are SND_PCM_TYPE_HW


void find_multi_iface_pcm_elem(snd_pcm_t *pcm)
{
	snd_pcm_multi_t *multi = pcm->private_data;
	unsigned int i;
	for (i = 0; i < multi->slaves_count; ++i) {
		snd_pcm_multi_slave_t *slave = &multi->slaves[i];
                if ( snd_pcm_type(slave->pcm) == SND_PCM_TYPE_HW ) {
                       find_hw_iface_pcm_elem(slave->pcm);
		}
	}
}

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-07-05 14:45 darkbrain      New Issue                                    
08-07-05 14:45 darkbrain      File Added: volume.c                         
08-13-05 10:43 darkbrain      Note Added: 0005802                          
01-10-06 12:55 darkbrain      Note Added: 0007548                          
02-05-06 04:55 Raymond        Note Added: 0007929                          
02-05-06 05:33 Raymond        Note Edited: 0007929                         
02-05-06 13:19 darkbrain      Note Added: 0007932                          
02-05-06 14:42 Raymond        Note Added: 0007934                          
02-06-06 03:43 Raymond        Note Edited: 0007934                         
02-07-06 21:04 darkbrain      File Added: pcm1.patch                       
02-07-06 21:05 darkbrain      Note Added: 0007960                          
02-08-06 02:39 Raymond        Note Edited: 0007934                         
02-08-06 03:24 Raymond        Note Added: 0007962                          
02-08-06 03:31 Raymond        Note Edited: 0007962                         
02-08-06 09:54 Raymond        Note Edited: 0007934                         
02-08-06 10:41 darkbrain      Note Added: 0007964                          
02-09-06 08:06 Raymond        Note Added: 0007970                          
02-09-06 08:11 Raymond        Note Edited: 0007970                         
02-09-06 10:37 Raymond        Note Deleted: 0007970                        
02-10-06 12:59 Raymond        Note Added: 0008002                          
02-10-06 15:29 darkbrain      Note Added: 0008005                          
02-11-06 02:38 Raymond        Note Added: 0008011                          
02-11-06 02:51 Raymond        Note Edited: 0007962                         
02-11-06 02:53 Raymond        Note Edited: 0008011                         
02-11-06 03:00 Raymond        Note Edited: 0008011                         
02-11-06 14:30 darkbrain      Note Added: 0008017                          
02-11-06 15:16 Raymond        Note Added: 0008019                          
02-13-06 08:32 Raymond        Note Edited: 0008019                         
02-13-06 13:30 Raymond        Note Edited: 0008019                         
02-13-06 13:34 Raymond        Note Added: 0008047                          
02-13-06 17:03 darkbrain      Note Added: 0008056                          
02-13-06 17:04 darkbrain      Note Edited: 0008056                         
02-13-06 17:24 Raymond        Note Added: 0008058                          
02-13-06 17:30 Raymond        Note Added: 0008059                          
02-14-06 02:50 Raymond        Note Edited: 0008058                         
02-14-06 03:05 Raymond        Note Added: 0008068                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
