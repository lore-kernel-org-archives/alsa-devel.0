From: Hanbiao Wang <hbwang@lecs.cs.ucla.edu>
Subject: Re: what is trigger time?
Date: Fri, 8 Oct 2004 10:16:15 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0410081004450.27057@concorde.cs.ucla.edu>
References: <Pine.LNX.4.58.0410071801160.18124@concorde.cs.ucla.edu>
 <1097208527.9372.50.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1097208527.9372.50.camel@krustophenia.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 8 Oct 2004, Lee Revell wrote:

> On Thu, 2004-10-07 at 21:07, Hanbiao Wang wrote:
> > Hi, All
> >     According to the ALSA documentation, the following two functions
> > snd_pcm_status_get_trigger_tstamp()
> > snd_pcm_status_get_trigger_htstamp()
> > are suppose to get the "trigger time". However, I can not find any
> > documents that explains or define the meaning of the "trigger time".
> > Is that the time when a whole period of samples in the buffer is ready to
> > be read in? Could somebody please give me a hint? Thanks a lot.
> >
>
> I don't have the source in front of me but I would expect this to be the
> time when the ALSA middle layer executed the trigger callback.  This
> happens when a PCM is stopped, started, or paused.
>
> Lee

   Thanks for Lee's answer. Other than start, stop, pause of PCM, are
there any other events that could be regarded as triggered?

After I started a PCM for capture, I immediately examined the trigger time
by calling snd_pcm_status_get_trigger_tstamp(). Then I read data by
calling snd_pcm_readi(). After that I examine the trigger time again by
calling the same snd_pcm_status_get_trigger_tstamp(). However, these two
trigger time has a difference of 1108542 us. The first trigger time could
be the start of PCM, I really have no clue of what the second trigger time
corresponds to. Please enlighten me on this issue. Thanks a lot in
advance.

Hanbiao


>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
> Use IT products in your business? Tell us what you think of them. Give us
> Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
> http://productguide.itmanagersjournal.com/guidepromo.tmpl
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
