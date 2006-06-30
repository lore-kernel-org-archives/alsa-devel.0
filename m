From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002238]: snd_pcm_hw_params() did not
	return error
Date: Fri, 30 Jun 2006 16:15:17 +0200
Message-ID: <aa50d9f55d98ea908460a9ce90885054@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D0DD823E
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jun 2006 16:15:17 +0200 (MEST)
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


The following issue has been CLOSED
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
Status:                     closed
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             06-28-2006 09:53 CEST
Last Modified:              06-30-2006 16:15 CEST
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
 Raymond - 06-30-06 09:43 
----------------------------------------------------------------------
It seem that the default value is minimum and always sane.


The application are required to select period size and buffer size from
possibe set of values.

It seem that snd_pcm_hw_params_test_period_size() may fail at min/max
values and there is no simple method to find out all possible values.

In general, is there any difference if the application set period_size
first or set buffer_size first ?


#include <alsa/asoundlib.h>
   int main()
   {
     snd_pcm_t* pcm;
     snd_pcm_hw_params_t* hwparams;
     snd_pcm_uframes_t
size,size_min,size_max,buf_size,buf_size_min,buf_size_max;
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

/* print possible period size */

	 err = snd_pcm_hw_params_get_period_size_min(hwparams, &size_min, &dir);
	 if (err < 0) 
		printf("Unable to get period size min for playback: %s\n",
snd_strerror(err));
	 err = snd_pcm_hw_params_get_period_size_max(hwparams, &size_max, &dir);
	 if (err < 0) 
		printf("Unable to get period size max for playback: %s\n",
snd_strerror(err));
         
         printf("period size (min =%d max = %d)\n",size_min,size_max);
	 for (size=size_min; size<=size_max; size++)
	    if ( snd_pcm_hw_params_test_period_size(pcm,hwparams,size,dir) == 0
)
                printf("    %d\n",size);

/* print possible buffer size */
           
	 err = snd_pcm_hw_params_get_buffer_size_min(hwparams, &buf_size_min);
	 if (err < 0) 
		printf("Unable to get buffer size min for playback: %s\n",
snd_strerror(err));
	 err = snd_pcm_hw_params_get_buffer_size_max(hwparams, &buf_size_max);
	 if (err < 0) 
		printf("Unable to get buffer size max for playback: %s\n",
snd_strerror(err));
         
         printf("buffer size (min =%d max =
%d)\n",buf_size_min,buf_size_max);
	 for (buf_size=buf_size_min; buf_size<=buf_size_max; buf_size++)
	    if ( snd_pcm_hw_params_test_buffer_size(pcm,hwparams,buf_size) == 0
)
                printf("    %d\n",buf_size);


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
	 err = snd_pcm_hw_params_get_buffer_size(hwparams, &buf_size);
	 if (err < 0) 
		printf("Unable to get buffer size for playback: %s\n",
snd_strerror(err));
         else
                printf("buffer size = %d\n",buf_size);
         snd_pcm_close(pcm);
      }
   }



----------------------------------------------------------------------
 rlrevell - 06-30-06 16:15 
----------------------------------------------------------------------
This is not a bug.  These questions belong on the alsa-devel mailing list.

Raymond, you DO know how to use email right?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-28-06 09:53 Raymond        New Issue                                    
06-30-06 04:53 Raymond        Note Added: 0010717                          
06-30-06 05:22 rlrevell       Note Added: 0010718                          
06-30-06 07:10 Raymond        Note Added: 0010719                          
06-30-06 07:16 Raymond        Note Edited: 0010719                         
06-30-06 09:43 Raymond        Note Edited: 0010719                         
06-30-06 16:15 rlrevell       Status                   new => closed       
06-30-06 16:15 rlrevell       Note Added: 0010738                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
