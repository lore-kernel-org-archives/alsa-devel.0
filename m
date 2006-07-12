From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0001228]: Skype Does not work with aoss
Date: Wed, 12 Jul 2006 17:52:48 +0200
Message-ID: <96d307bd6a589b587e3e2f8ae66dfba4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4FBEA1A2
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Jul 2006 17:52:48 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1228> 
======================================================================
Reported By:                hil
Assigned To:                
======================================================================
Project:                    ALSA - liboss
Issue ID:                   1228
Category:                   
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-03-2005 09:09 CEST
Last Modified:              07-12-2006 17:52 CEST
======================================================================
Summary:                    Skype Does not work with aoss
Description: 
I downloaded alsa-oss-1.0.9rc2 and install by
# ./configure --with-aoss=yes && make && make install
as root. Virtually every program works except skype
(http://www.skype.com/) version 1.1.0.13_API. I downloaded the Fedora
version of skype from the skype official website. Skype only uses
/dev/dsp. I guess skype uses /dev/dsp as microphone input as well. I could
not hear anything and the microphone did not work as well if I run  skype
like aoss /usr/bin/skype. If I run skype without aoss, then skype works
just fine.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001224 artsd-like style
======================================================================

----------------------------------------------------------------------
 Raymond - 06-09-06 03:28 
----------------------------------------------------------------------
It depend on aoss open which pcm device and the sound card 

1) hw
2) plughw
3) default
4) ALSA_OSS_PCM_DEVICE

The "type plug" allow mono/stereo conversion, but it also changed the
values return by snd_pcm_hw_params_get_xxx_min() and
snd_pcm_hw_params_get_xxx_max()



#include <alsa/asoundlib.h>
#include <stdio.h>

char *device_name[3]={"hw:0","plughw:0","default"};

int main(int argc, char **argv)
{
    snd_pcm_t *pcm;
    snd_pcm_info_t *pcm_info;
    snd_pcm_hw_params_t *hw_params;
    snd_pcm_format_t format;
    char device[16];
    int err,i;
    int dir,sub;
    int channels,chn_min,chn_max;
	
    printf("ALSA %s\n",snd_asoundlib_version());
    for (i=0; i<3; i++) {
	strcpy(device,device_name[i]);
        for (dir=SND_PCM_STREAM_PLAYBACK; dir<= SND_PCM_STREAM_CAPTURE;
dir++) {
            err = snd_pcm_open(&pcm, device, dir,SND_PCM_NONBLOCK);
            if ( err < 0 ) {
   	        printf(" open %s fail : %s\n",device,snd_strerror(err));
            }
            else {
                snd_pcm_info_alloca(&pcm_info);
 	        err = snd_pcm_info(pcm, pcm_info);
	        if ( err < 0 ) {
 	      	    printf(" pcm_info : %s\n",snd_strerror(err));
	        };
		printf("%s %s %s\n",device,snd_pcm_info_get_name(pcm_info),dir ==
SND_PCM_STREAM_PLAYBACK ? "Playback" : "Capture");
                snd_pcm_hw_params_malloc(&hw_params);
		err = snd_pcm_hw_params_any(pcm, hw_params);
		if ( err < 0 ) {
		    printf("hw_params_any error %s\n",snd_strerror(err));
		} else {
	            err = snd_pcm_hw_params_get_channels_min(hw_params,
&chn_min);
		    printf("%s channel min=%d\n",device,chn_min);
		    err = snd_pcm_hw_params_get_channels_max(hw_params, &chn_max);
		    printf("%s channel max=%d\n",device,chn_max);

		    for (channels=chn_min; channels<=chn_max; channels++) {
			if ( snd_pcm_hw_params_test_channels(pcm,hw_params,channels) == 0 ) 
			    printf(" channel : %d\n",channels);
		    };
                };
	        snd_pcm_close(pcm);
   	    };
        };
    };
}

----------------------------------------------------------------------
 Raymond - 07-12-06 17:52 
----------------------------------------------------------------------
It seem to be an AOSS bug, it can return all format unless device has
'plug'


case SNDCTL_DSP_GETFMTS:
    {
    *(int *)arg = (AFMT_MU_LAW | AFMT_A_LAW | AFMT_IMA_ADPCM |
    AFMT_U8 | AFMT_S16_LE | AFMT_S16_BE |
    AFMT_S8 | AFMT_U16_LE | AFMT_U16_BE);
    DEBUG("SNDCTL_DSP_GETFMTS, %p) -> [%d]\n", arg, *(int *)arg);
    break;
}

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-03-05 09:09 hil            New Issue                                    
08-09-05 15:33 rapand         Note Added: 0005732                          
08-10-05 00:49 rlrevell       Relationship added       duplicate of 0001224
08-10-05 00:50 rlrevell       Note Added: 0005740                          
12-31-05 00:19 rlrevell       Note Added: 0007315                          
01-02-06 18:54 rlrevell       Relationship deleted     duplicate of 0001224
01-02-06 18:55 rlrevell       Relationship added       related to 0001224  
01-02-06 18:56 rlrevell       Note Added: 0007375                          
01-05-06 21:36 Hetfield       Note Added: 0007479                          
01-05-06 21:40 rlrevell       Note Added: 0007480                          
01-05-06 21:42 rlrevell       Note Added: 0007481                          
01-05-06 22:01 Hetfield       Note Added: 0007482                          
01-28-06 05:34 nono31         Note Added: 0007824                          
01-28-06 05:35 nono31         Issue Monitored: nono31                      
01-28-06 05:38 rlrevell       Note Added: 0007825                          
01-28-06 06:11 nono31         Note Added: 0007826                          
01-28-06 06:12 nono31         File Added: strace_aoss_kiax.bz2                  
 
01-28-06 06:13 nono31         Note Added: 0007827                          
03-22-06 00:28 rlrevell       Note Added: 0008761                          
03-22-06 10:02 Hetfield       Note Added: 0008849                          
04-01-06 10:55 Hetfield       Note Added: 0009054                          
06-08-06 04:01 Raymond        Note Added: 0010107                          
06-08-06 17:30 pzad           Note Added: 0010114                          
06-09-06 03:28 Raymond        Note Added: 0010125                          
07-12-06 17:52 Raymond        Note Added: 0010984                          
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
