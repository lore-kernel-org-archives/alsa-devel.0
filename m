From: Irfan Shaikh <irfan.shaikh@sasken.com>
Subject: Re: snd_pcm_mmap_commit
Date: Fri, 19 Nov 2010 15:46:28 +0530
Message-ID: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE373@EXGMBX01.sasken.com>
References: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE36E@EXGMBX01.sasken.com>,
	<alpine.LNX.2.00.1011190810081.21207@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta-blr1.sasken.com (mta-blr1.sasken.com [203.200.200.72])
	by alsa0.perex.cz (Postfix) with ESMTP id 030451037F2
	for <alsa-devel@alsa-project.org>; Fri, 19 Nov 2010 11:16:33 +0100 (CET)
In-Reply-To: <alpine.LNX.2.00.1011190810081.21207@eeebox2.perex-int.cz>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


As per your valuable inputs modified code using snd_pcm_wait
/$$$$ My code waits indefinetly in snd_pcm_wait() $$$$$/
If i set some timer again frames available shows to be zero.

#ifdef DIRECT1
  snd_pcm_state_t state;
  int err, first = 1;
  snd_pcm_sframes_t frames_available, frames_transmit,commitres;
  snd_pcm_uframes_t size, offset;
  unsigned char *outbuffer;
  const snd_pcm_channel_area_t *area;
  static int irf=0;


  state = snd_pcm_state(alsaParams->pcm_handle);
  if (state == SND_PCM_STATE_XRUN)
  {
    err=xrun_recovery(alsaParams->pcm_handle, -EPIPE);
    if (err < 0) {
      printf("XRUN recovery failed: %s\n", snd_strerror(err));
      exit(EXIT_FAILURE);
    }
    first = 1;
  }
  else if (state == SND_PCM_STATE_SUSPENDED)
  {
    err = xrun_recovery(alsaParams->pcm_handle, -ESTRPIPE);
    if (err < 0) {
      printf("SUSPEND recovery failed: %s\n", snd_strerror(err));
      exit(EXIT_FAILURE);
    }
  }
   frames_available = snd_pcm_avail_update(alsaParams->pcm_handle);
  if (frames_available < 0) {
    err = xrun_recovery(alsaParams->pcm_handle, frames_available);
    if (err < 0) {
      printf("avail update failed: %s\n", snd_strerror(err));
      exit(EXIT_FAILURE);
    }
    first = 1;
    printf("RETURN : Should Be continued\n");
    return;
  }
  printf("Farames available : %d\n", frames_available);
  if(frames_available<=0)
  {
#if 1
      err = snd_pcm_wait(alsaParams->pcm_handle, -1);    /############ WAIT here indefinitely ##############/
      if (err < 0) {
        if ((err = xrun_recovery(alsaParams->pcm_handle, err)) < 0) {
          printf("snd_pcm_wait error: %s\n", snd_strerror(err));
          exit(EXIT_FAILURE);
        }
      }
#endif
      irf=1;
      return;
  }
  else if(irf==1)
  {
      err = snd_pcm_start(alsaParams->pcm_handle);
      if (err < 0) {
        printf("Start error: %s\n", snd_strerror(err));
        exit(EXIT_FAILURE);
      }
      irf=0;
  }
   size=frames_available;
  while (size > 0) {
    frames_transmit = size;
    err=snd_pcm_mmap_begin(alsaParams->pcm_handle, &area, &offset, &frames_transmit);
    if (err < 0) {
      if ((err = xrun_recovery(alsaParams->pcm_handle, err)) < 0) {
        printf("MMAP begin avail error: %s\n", snd_strerror(err));
        exit(EXIT_FAILURE);
      }
      first = 1;
    }
    printf(">>>>Begin result : %d\n", err);
    outbuffer = ((char *) area->addr + (area->first + area->step * offset)/ 8); //Copies Actual data

    commitres = snd_pcm_mmap_commit(alsaParams->pcm_handle, offset, frames_transmit);
    if (commitres < 0 || (snd_pcm_uframes_t)commitres != frames_transmit) {
      if ((err = xrun_recovery(alsaParams->pcm_handle, commitres >= 0 ? -EPIPE : commitres)) < 0) {
        printf("MMAP commit error: %s\n", snd_strerror(err));
        exit(EXIT_FAILURE);
      }
      first = 1;
    }
    printf(">>>>>>>>>>>>>>>>>>>>>>Comit result : %d\n", commitres);
    size -= frames_transmit;
  }
#endif



________________________________________
From: Jaroslav Kysela [perex@perex.cz]
Sent: Friday, November 19, 2010 12:41 PM
To: Irfan Shaikh
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] snd_pcm_mmap_commit

On Fri, 19 Nov 2010, Irfan Shaikh wrote:

> /*************************************************************/
> Code below O/p results runs in a while loop till end of PCM data.
> 1) First time O/p is
>          Farames available : 1024                                                /*Return VALUE of snd_pcm_avail_update*/
>          >>>>>>>>>>>>>>>>>>>>>>>>>Begin result : 0      /*Return VALUE of snd_pcm_mmap_begin*/
>          Address outbuffer : 0xcff88
>          >>>>>>>>>>>>>>>>>>>>>>Comit result : 1024       /*SUCESSFUL - Return VALUE of  snd_pcm_mmap_commi*/
>
> 2) Second time onwards ALWAYS O/p is
>          Farames available : 0                                                      /*Return VALUE of snd_pcm_avail_update*/
>          >>>>>>>>>>>>>>>>>>>>>>>>>Begin result : 0      /*Return VALUE of snd_pcm_mmap_begin*/
>          Address outbuffer : 0xcff88
>          >>>>>>>>>>>>>>>>>>>>>>Comit result : 0             /*FAILURE - Return VALUE of  snd_pcm_mmap_commit*/

You have to use poll()/select() or snd_pcm_wait() to wait for a room in
the playback buffer. The direct mmap I/O is always non-blocked.

                                                Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.


SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any 
 virus transmitted by this email.
Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html
