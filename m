From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: IO plugin and multiple poll descriptors
Date: Wed, 18 May 2005 14:05:43 +0200
Message-ID: <1116417943.10063.234.camel@pegasus>
References: <1116173811.8886.55.camel@pegasus>
	 <s5h3bsmqlq2.wl@alsa2.suse.de> <1116335015.10063.91.camel@pegasus>
	 <s5h7jhxq15v.wl@alsa2.suse.de>  <s5hu0l0okxs.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hu0l0okxs.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Mailing List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

> > > > > for the IO plugin we can specify one descriptor for poll().
> > > > > 
> > > > > 	io.poll_fd = fd;
> > > > > 	io.poll_events = POLLIN;
> > > > > 
> > > > > I like to use more than one, because in the Bluetooth cases I always
> > > > > have to deal with a signal and a separate media channel. Is it possible
> > > > > to add support for that or do I must work around it.
> > > > 
> > > > Currently, the alsa-lib handles only one poll_fd internally although
> > > > API allows the multiple poll_fds.  So, it's not quite easy to add the
> > > > multiple fds...
> > > 
> > > are there any plans to change this in the future?
> > > 
> > > Maybe it is a good idea to retrieve the poll_fd through a callback. I
> > > think of something like you already do in the library:
> > > 
> > > 	poll_descriptors(snd_pcm_ioplug_t *io, struct pollfd *pfds)
> > > 	poll_descriptors_count(snd_pcm_ioplug_t *io)
> > > 
> > > Or do you have a good idea on how to workaround it?
> > 
> > I agree, adding the appropriate new callbacks would be the simplest
> > solution.  I'll implement it soon if no one is against it.
> 
> I added the new callbacks to CVS.
> The following two fields are added to snd_pcm_ioplug_callback_t:
> 
> 	/**
> 	 * poll descriptors count; optional
> 	 */
> 	int (*poll_descriptors_count)(snd_pcm_ioplug_t *io);
> 	/**
> 	 * poll descriptors; optional
> 	 */
> 	int (*poll_descriptors)(snd_pcm_ioplug_t *io, struct pollfd *pfd, unsigned int space);
> 
> If they are NULL, poll_fd is used as well as in the former version.

should we set poll_fd to -1 or leave it untouched when using the new
callbacks.

We can set poll_events through the callback now, right? I like to have
different events for different descriptors. One POLLIN and one POLLOUT.

What happens at the moment when I really return two poll_fd.

> This change breaks the compatibility with older versions.
> For the future compatibility, I added a new field to
> snd_pcm_ioplug_t.

Does it? If the new callbacks are not used you will fall back to poll_fd
and so no difference at all.

And you never released a final version with IOPLUG support.

> The first field of snd_pcm_ioplug_t is "version" now.  This field must
> be filled by the caller with SND_PCM_IOPLUG_VERSION constant defined
> in pcm_ioplug.h.
> 
> struct snd_pcm_ioplug {
> 	/**
> 	 * protocol version; SND_PCM_IOPLUG_VERSION must be filled here
> 	 * before calling #snd_pcm_ioplug_create()
> 	 */
> 	unsigned int version;
> 	/**
> 	 * name of this plugin; must be filled before calling #snd_pcm_ioplug_create()
> 	 */
> 	const char *name;
> 	...
> 
> Could you change your driver to follow this?

As soon as the anonymous CVS gives me the code ;)

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
