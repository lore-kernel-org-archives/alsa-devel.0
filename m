From: Peter Enderborg <pme@ufh.se>
Subject: Re: Memory managment.
Date: Mon, 06 May 2002 12:09:57 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CD65674.3C90FC62@ufh.se>
References: <3CD56D48.E0C82404@ufh.se> <s5hlmaxmx3i.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> Hi Peter,
>
> At Sun, 05 May 2002 19:35:04 +0200,
> Peter Enderborg wrote:
> >
> > I have some memory problems with my alsa programming.
> > And I have tryed to do a small program to see whats wrong.
> > And I still have the same problem with this little program...
> >
> >
> > #include <alsa/asoundlib.h>
> > int main()
> > {
> >   while (1)
> >     {
> >       snd_seq_event_t *foo;
> >       foo = snd_seq_create_event();
> >       snd_seq_free_event(foo);
> >     }
> >   return 0;
> > }
> >
> > I guess that I have missed some fundamental things about the events.
> > This on cvs version from 20020504
>
> err..  please avoid using snd_seq_create_event(), or free the pointer
> by normal free() call.  snd_seq_free_event() doesn't free the
> malloc'ed pointer on alsa 0.9.
>

What is the correct way to create an event then?

>
> if there is no objection, i'll remove snd_seq_create_event() from
> API, or put a warning at least.
>
> Takashi

--
foo!




_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
