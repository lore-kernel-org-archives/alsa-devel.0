From: "Men Muheim" <muheim@gmx.ch>
Subject: RE: snd_pcm_status_get_trigger_tstamp
Date: Wed, 13 Nov 2002 16:04:12 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <004a01c28b25$ed6c1710$461d8481@profi>
References: <004601c28afe$94d57aa0$461d8481@profi>
Reply-To: <men@ife.ee.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <004601c28afe$94d57aa0$461d8481@profi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I have just installed alsa-0.9.0rc5, but this does not change
anything...

> -----Original Message-----
> From: alsa-devel-admin@lists.sourceforge.net [mailto:alsa-devel-
> admin@lists.sourceforge.net] On Behalf Of Men Muheim
> Sent: Mittwoch, 13. November 2002 11:23
> To: alsa-devel@lists.sourceforge.net
> Subject: [Alsa-devel] snd_pcm_status_get_trigger_tstamp
> 
> Hello,
> 
> I am having a problem using the function
> snd_pcm_status_get_trigger_tstamp(). I expect the function to return
the
> sample time of the latest trigger, which corresponds to the time of
the
> first sample in the actual channel area.
> 
> Instead the function returns zero in my case. Am I misunderstanding
the
> means of the function or is the function not supported in
> alsa-0.9.0beta10?
> 
> I appreciate any comments on this...
> 
> Regards, Men
> 
> 
> 
> PS: I am using SND_PCM_ACCESS_MMAP_NONINTERLEAVED from
>
(http://www.alsa-project.org/alsa-doc/alsa-lib/_2test_2pcm_8c-example.ht
> ml#example_test_pcm) and want to get the time of the first sample in
the
> actual channel area by calling
> 
> 
> void gettimestamp(snd_pcm_t *handle, snd_timestamp_t *timestamp)
> {
>         int err;
>         snd_pcm_status_t *status;
> 
>         snd_pcm_status_alloca(&status);
>         if ((err = snd_pcm_status(handle, status)) < 0) {
>                 printf("Stream status error: %s\n",
snd_strerror(err));
>                 exit(0);
>         }
>         snd_pcm_status_get_trigger_tstamp(status, timestamp);
> }
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by: Are you worried about
> your web server security? Click here for a FREE Thawte
> Apache SSL Guide and answer your Apache SSL security
> needs: http://www.gothawte.com/rd523.html
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel



-------------------------------------------------------
This sf.net email is sponsored by: Are you worried about 
your web server security? Click here for a FREE Thawte 
Apache SSL Guide and answer your Apache SSL security 
needs: http://www.gothawte.com/rd523.html
