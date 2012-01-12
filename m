From: Jonathan Andrews <jon@jonshouse.co.uk>
Subject: Trying to understand alsa
Date: Thu, 12 Jan 2012 23:36:53 +0000
Message-ID: <1326411413.23310.46.camel@jonspc>
Reply-To: jon@jonshouse.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.jonshouse.co.uk (unknown [91.84.151.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 25D7F24403
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2012 00:33:28 +0100 (CET)
Received: from [10.10.10.6] (jonspc [10.10.10.6])
	by mail.jonshouse.co.uk (8.14.1/8.13.8) with ESMTP id q0CNb4F7015040
	for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2012 23:37:10 GMT
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> If a packet arrives very late (and one will, eventually), you will
> underrun.  That's unavoidable. You can check for SND_PCM_STATE_XRUN
> from snd_pcm_state().  It's undocumented, but you need to call
> snd_pcm_avail_update() first to get an accurate reading from
> snd_pcm_state(). When an underrun occurs, recover with
> snd_pcm_recover() and then start writing data again.
> 

Ok, this my first attempt at recovery, still haven't solved buffering
problem so it underruns for each and every write.

Does this look roughly correct ?

Thanks,
Jon


#ifdef ALSA
                                // snd_pcm_writen - writes non interleaved (mono) samples
                                // bufs an explicit void* pointer type set to point at real sample buffer "audio"
                                // broken pipe indicates buffer underrun

                                numrecs=sizeof(audio)/2;                // 1k buffer, 512 samples 
                                //printf("%d \n", snd_pcm_wait(playback_handle[activeslot],1));
                                err = snd_pcm_writen (playback_handle[activeslot], &bufs, numrecs);
                                if (err<numrecs)
                                {
                                        fflush(stdout);
                                        if (err>0)
                                        {
                                                fprintf (stderr, "snd_pcm_writen: wrote only %d\n",err);
                                                fflush(stderr);
                                        }
                                        else
                                        {
                                                if (err == EPIPE)      
                                                {
                                                        errb=snd_pcm_recover(playback_handle[activeslot],err,0);                // error passed is resullt of writen
                                                        if (errb<0)
                                                        {
                                                                fprintf(stderr,"Failed to recover from underrun\n");
                                                                fflush(stderr);
                                                                exit(1);
                                                        }
                                                }
                                                else
                                                {
                                                        fprintf (stderr, "snd_pcm_writen:  write to audio interface failed (%s) (%d)\n", snd_strerror (err),err);
                                                        fflush(stdout);
                                                        fflush(stderr);
                                                        exit (1);
                                                }
                                        }
                                }
#endif
