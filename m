From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002238]: snd_pcm_hw_params() did not
	return error
Date: Fri, 30 Jun 2006 05:22:08 +0200
Message-ID: <9d151898df0510685bdc659d40c3e427@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 034B62AF
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jun 2006 05:22:08 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2238> 
======================================================================
Reported By:                Raymond
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   2238
Category:                   1_pcm - digital audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             06-28-2006 09:53 CEST
Last Modified:              06-30-2006 05:22 CEST
======================================================================
Summary:                    snd_pcm_hw_params() did not return error
Description: 
If alsa-lib require the application to refine hw_params from those values
supported by alsa-driver to a set of unique values

Why do snd_pcm_hw_params() did not return error in the following code ?

Does it mean that snd_pcm_hw_params_set_period_size() or
snd_pcm_hw_params_set_buffer_size() is not necessary for some ALSA driver
?


#include <alsa/asoundlib.h>
   int main()
   {
     snd_pcm_t* pcm;
     snd_pcm_hw_params_t* hwparams;
     int err;
     unsigned int rate = 44100;
     unsigned int channels = 2;
     int dir = 0;
     if ( snd_pcm_open(&pcm, "default", SND_PCM_STREAM_PLAYBACK, 0) < 0 )
       printf("Cannot open pcm.\n");
     else {
         printf("pcm state after pcm open : %d\n",snd_pcm_state(pcm));
         snd_pcm_hw_params_alloca(&hwparams);
         snd_pcm_hw_params_any(pcm, hwparams);
         snd_pcm_hw_params_set_access(pcm, hwparams,
SND_PCM_ACCESS_RW_INTERLEAVED);
         snd_pcm_hw_params_set_format(pcm, hwparams,
SND_PCM_FORMAT_S16_LE);
         snd_pcm_hw_params_set_channels (pcm, hwparams, channels);
         snd_pcm_hw_params_set_rate_near(pcm, hwparams, &rate, &dir);
         printf("pcm state before hw_params : %d\n",snd_pcm_state(pcm));
         err = snd_pcm_hw_params(pcm, hwparams) ;
         if ( err < 0 )
           printf("Error setting hw params: %s.\n", snd_strerror(err));
         printf("pcm state after hw_params : %d\n",snd_pcm_state(pcm));
         snd_pcm_close(pcm);
      }
   }




======================================================================

----------------------------------------------------------------------
 Raymond - 06-30-06 04:53 
----------------------------------------------------------------------
device is "default" and driver use dmix

pcm state after pcm open : 0
pcm state before hw_params : 0
pcm state after hw_params : 2
period size = 940

device is "hw" or "plughw"

pcm state after pcm open : 0
pcm state before hw_params : 0
pcm state after hw_params : 2
period size = 8


 #include <alsa/asoundlib.h>
   int main()
   {
     snd_pcm_t* pcm;
     snd_pcm_hw_params_t* hwparams;
     snd_pcm_uframes_t size;
     int err;
     unsigned int rate = 44100;
     unsigned int channels = 2;
     int dir = 0;
     if ( snd_pcm_open(&pcm, "default", SND_PCM_STREAM_PLAYBACK, 0) < 0 )
       printf("Cannot open pcm.\n");
     else {

         printf("pcm state after pcm open : %d\n",snd_pcm_state(pcm));

         snd_pcm_hw_params_alloca(&hwparams);
         snd_pcm_hw_params_any(pcm, hwparams);
         err = snd_pcm_hw_params_set_access(pcm, hwparams,
SND_PCM_ACCESS_RW_INTERLEAVED);
         if ( err < 0 )
           printf("Error set access : %s\n",snd_strerror(err));
         err = snd_pcm_hw_params_set_format(pcm, hwparams,
SND_PCM_FORMAT_S16_LE);
         if ( err < 0 )
           printf("Error set format : %s\n",snd_strerror(err));
         err = snd_pcm_hw_params_set_channels (pcm, hwparams, channels);
         if ( err < 0 )
           printf("Error set channels : %s\n",snd_strerror(err));
         err = snd_pcm_hw_params_set_rate_near(pcm, hwparams, &rate,
&dir);
         if ( err < 0 )
           printf("Error set rate near : %s\n",snd_strerror(err));

         printf("pcm state before hw_params : %d\n",snd_pcm_state(pcm));
         err = snd_pcm_hw_params(pcm, hwparams) ;
         if ( err < 0 )
           printf("Error setting hw params: %s\n", snd_strerror(err));    
    
         printf("pcm state after hw_params : %d\n",snd_pcm_state(pcm));

	 err = snd_pcm_hw_params_get_period_size(hwparams, &size, &dir);
	 if (err < 0) 
		printf("Unable to get period size for playback: %s\n",
snd_strerror(err));
         else
                printf("period size = %d\n",size);
         snd_pcm_close(pcm);
      }
   }

----------------------------------------------------------------------
 rlrevell - 06-30-06 05:22 
----------------------------------------------------------------------
If you don't set the period size, the default is driver and configuration
dependent.  Applications cannot rely on the default period size being
sane.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-28-06 09:53 Raymond        New Issue                                    
06-30-06 04:53 Raymond        Note Added: 0010717                          
06-30-06 05:22 rlrevell       Note Added: 0010718                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
