From: Josh Haberman <joshua@haberman.com>
Subject: Re: Re: [Jackit-devel] alsa_driver_wait -> libasound?
Date: 15 Jan 2003 16:14:21 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1042676061.10961.175.camel@birdie>
References: <200301142022.h0EKMmCg025158@spider.tela.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200301142022.h0EKMmCg025158@spider.tela.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: jackit-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2003-01-14 at 12:23, Paul Davis wrote:
> >2) start first linked stream (thus all in paralel or serial or combination 
> >   sequence)
> >3) poll the last stream handle for valid position
> >
> >And you don't need your complicate function.
> 
> i just can't agree with that. on return from JACK's alsa_driver_wait, the
> caller knows:
> 
>        * how many frames are available (rounded to whole periods)
>        * what delay was encountered in waiting for the data/space
>        * whether an xrun occured
>        * if some other error occured 
> 
> your proposed snd_pcm_wait_many() doesn't do any of that.
> 
> i think that josh's point was perhaps a little different than you are
> thinking. i don't think he was suggesting a version of snd_pcm_wait()
> that waited on multiple handles instead of just one. i think he was
> suggesting a function that does something that most applications need:
> 
> to wait until a known-sized chunk of data/space (or multiple thereof)
> is ready on *all* handles being used. since doing this involves much
> more than just calling poll(), which is fundamentally all that
> snd_pcm_wait() does, so would the multi-handle version.

You're right, that is really what I'm looking for.  Maybe I could have
avoided confusion by not comparing it with snd_pcm_wait to begin with.

More than anything else, what I want to avoid having to do is set up and
interpret the results of poll() manually.  For example, I infer by
reading the JACK code that POLLERR means an xrun was detected.  It would
be much easier to receive this information from an ALSA function.

So perhaps a revised function signature could be:

   int snd_pcm_poll( snd_pcm_t **handles, int num_handles, int timeout )

   returns:
      the number of frames available on all handles, or negative if an 
      error occured.  -EPIPE if an xrun occured, -ETIMEDOUT if not all
      handles were ready before timeout.

Originally I was going to write "returns the number of frames on all
handles, rounded down to the greatest complete period," but I realized
that the period size could be different for different handles.

Josh


-------------------------------------------------------
This SF.NET email is sponsored by: A Thawte Code Signing Certificate 
is essential in establishing user confidence by providing assurance of 
authenticity and code integrity. Download our Free Code Signing guide:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0028en
