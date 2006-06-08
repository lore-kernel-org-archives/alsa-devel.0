From: "Kacper Wysocki" <kacperw@gmail.com>
Subject: Re: es1938 kernel panic - buffer overrun on recording
Date: Thu, 8 Jun 2006 13:25:56 -0400
Message-ID: <367a23780606081025p10270a95y3adaa12aaad045cb@mail.gmail.com>
References: <367a23780606061401h6edfb8bcvf9b77f24415aa45f@mail.gmail.com>
	<1149727433.3151.1.camel@mindpipe>
	<367a23780606080048i434393c2r37d9b4d7d8e46f48@mail.gmail.com>
	<367a23780606080953i61c326d2u2b606e24a4621046@mail.gmail.com>
	<s5h8xo760ke.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h8xo760ke.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

2006/6/8, Takashi Iwai <tiwai@suse.de>:
> At Thu, 8 Jun 2006 12:53:09 -0400,
> Kacper Wysocki wrote:
> >
> > 2006/6/8, Kacper Wysocki <kacperw@gmail.com>:
> > > 2006/6/7, Lee Revell <rlrevell@joe-job.com>:
> > > > On Tue, 2006-06-06 at 17:01 -0400, Kacper Wysocki wrote:
> > > > > I'm running linux 2.6.16.5 and have a esssolo1 soundcard built into my
> > > > > IBM Thinkpad 240. Anytime I try to record from the soundcard I get the
> > > > > following message on the console:
> > > > >
> > > > > kernel panic - not syncing: Buffer above 16M boundry
> > > > >
> > > > > This is reproducible with for example 'sound-recorder foo.wav' [snip]
> The error message comes from OSS essolo1 driver...

Wow. I failed to notice that my system was loading the oss driver
alongside the alsa driver. Thanks for spotting this for me. Sorry for
the noise.

-Kacper
