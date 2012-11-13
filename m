From: Krakora Robert-B42341 <B42341@freescale.com>
Subject: Re: Races in alsa-lib with threads
Date: Tue, 13 Nov 2012 14:26:33 +0000
Message-ID: <5175C6FEA820754B902FF6873E9285B00C9862A5@039-SN2MPN1-021.039d.mgd.msft.net>
References: <CA+7tXig7cz8bOuKf3Dqk+iPErY9OKz4hD5L=MM=1vHFUdtPJQQ@mail.gmail.com>
 <s5hbof5ef7s.wl%tiwai@suse.de>	<509FD3BE.7090504@perex.cz>
 <loom.20121112T203721-204@post.gmane.org>	<s5hwqxqvwra.wl%tiwai@suse.de>
 <CA+7tXijc833Bvi-E-L2itnRGF0CNBEY-sahgRhzD_uuws+TQwA@mail.gmail.com>,
 <s5h4nktipd5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 7EF6D265201
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2012 15:26:41 +0100 (CET)
In-Reply-To: <s5h4nktipd5.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "kevin.w.kaster@delphi.com" <kevin.w.kaster@delphi.com>, "Huolin.Yang@delphi.com" <Huolin.Yang@delphi.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Trent Piepho <tpiepho@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Takashi Iwai [tiwai@suse.de]
Sent: Tuesday, November 13, 2012 8:50 AM
To: Krakora Robert-B42341
Cc: Trent Piepho; alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Races in alsa-lib with threads

At Tue, 13 Nov 2012 13:39:24 +0000,
Krakora Robert-B42341 wrote:
>
> [1  <text/plain; us-ascii (quoted-printable)>]
> > From: Takashi Iwai [tiwai@suse.de]
> > Sent: Tuesday, November 13, 2012 2:30 AM
> > To: Trent Piepho
> > Cc: Krakora Robert-B42341; alsa-devel@alsa-project.org
> > Subject: Re: [alsa-devel] Races in alsa-lib with threads
> >
> > At Tue, 13 Nov 2012 02:14:08 -0500,
> > Trent Piepho wrote:
> > >
> > > On Tue, Nov 13, 2012 at 1:32 AM, Takashi Iwai <tiwai@suse.de> wrote:
> > > > At Mon, 12 Nov 2012 19:40:42 +0000 (UTC),
> > > > Rob Krakora wrote:
> > > >> Would you be able to point me the the ALSA documentation that indicates the
> > > >> stipulations on handle usage using multiple threads?  I cannot find it.
> > > >
> > > > Think other way round:
> > > > The fact that it isn't documented means it's not safe to use in that
> > > > way :)
> > >
> > >
> > > The introduction on the alsa-project home page says, "SMP and
> > > thread-safe design. "  Some people might misunderstand what
> > > thread-safe means.  Maybe some clarification could be added.
> > > "Different streams are SMP and thread-safe (calls for the same stream
> > > must be serialized)."
> >
> > Yeah this should be corrected.  SMP things are just about the kernel
> > side at that time.
> >
> > It's a Wiki, feel free to correct / improve the text.
> >
> >
> > Takashi
>
> Hi Takashi,
>
> The way that the GStreamer ALSA Sink Plugin is using ALSA Lib assumes that it is thread safe.  The fix crafted by one of Trent's colleagues (attached) seems to be the way to go.  However, I don't know how it would impact other functionality within ALSA Lib.

No, sorry, we don't want to introduce pthread_lock in alsa-lib PCM
stuff.

We already have a few places, yes, but they are exceptional (mostly
for funky rarely used plugins that we can drop or mixer codes that
are no hot path).


Takashi

Hi Takashi,

A colleague found this from two years ago:  http://mailman.alsa-project.org/pipermail/alsa-devel/2010-June/028347.html.

IMHO, it seems trivial and harmless to serialize appl.ptr updates with mutexes unless there is a potential for deadlock or other possible race conditions in the affected ALSA Lib functions.  I know it breaks the paradigm, but you can see how snd_pcm_delay() function can lead a developer to believe that it can be called on a different thread time from snd_pcm_writei().

Best Regards,

Rob Krakora
