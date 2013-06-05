From: Andy Whitcroft <apw@canonical.com>
Subject: Re: CONFIG_SND_DEBUG (was: Re: [alsa-devel] [PATCH] ALSA: get rid of
 CONFIG_SND_VERBOSE_PRINTK)
Date: Wed, 5 Jun 2013 11:53:45 +0100
Message-ID: <20130605105345.GG3073@dm>
References: <Pine.LNX.4.44L0.1306041646240.1093-100000@iolanthe.rowland.org>
 <s5hobblrt2s.wl%tiwai@suse.de>
 <1370412921.2385.111.camel@joe-AO722>
 <s5hli6prrsb.wl%tiwai@suse.de>
 <1370415121.2385.124.camel@joe-AO722>
 <s5hfvwxrqsc.wl%tiwai@suse.de>
 <1370416077.2385.137.camel@joe-AO722>
 <s5ha9n5rpia.wl%tiwai@suse.de>
 <1370417670.2385.148.camel@joe-AO722>
 <51AEED12.20502@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-team-bounces@lists.ubuntu.com>
Content-Disposition: inline
In-Reply-To: <51AEED12.20502@canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/options/kernel-team>,
 <mailto:kernel-team-request@lists.ubuntu.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/kernel-team>
List-Post: <mailto:kernel-team@lists.ubuntu.com>
List-Help: <mailto:kernel-team-request@lists.ubuntu.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/kernel-team>,
 <mailto:kernel-team-request@lists.ubuntu.com?subject=subscribe>
Errors-To: kernel-team-bounces@lists.ubuntu.com
Sender: kernel-team-bounces@lists.ubuntu.com
To: David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Kernel team list <kernel-team@lists.ubuntu.com>, Alan Stern <stern@rowland.harvard.edu>, Joe Perches <joe@perches.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 05, 2013 at 09:47:30AM +0200, David Henningsson wrote:
> >>>On Wed, 2013-06-05 at 08:54 +0200, Takashi Iwai wrote:
> >>>>At Tue, 04 Jun 2013 23:52:01 -0700, Joe Perches wrote:
> >>>>>On Wed, 2013-06-05 at 08:32 +0200, Takashi Iwai wrote:
> >>>>>>Yes.  These are snd_printd() just to be conditionally built in.
> >>>>>>But in most cases it's rather useful to print them (as most distros
> >>>>>>set CONFIG_SND_DEBUG=y).
> >>>>>Ubuntu doesn't,  I believe Fedora doesn't.
> >>>>Then they should have done so :)
> >>>But they don't, so what distros do?
> >>
> >>RedHat (including Fedora) and SUSE do at least.
> >
> >Mandriva does too.  (still looking around for others)
> >
> >We can ask Ubuntu to enable CONFIG_SND_DEBUG.
> >(cc'd Andy Whitcroft, Leann Ogasawara and David Henningsson)
> >
> >Maybe there are others Canonical folk that
> >should be cc'd?
> 
> Adding kernel team mailing list to CC.
> 
> Andy/Leann - apparently CONFIG_SND_DEBUG is on by default from
> upstream, and we explicitly disable it. Is there any reason why we
> do that?

config SND_DEBUG
        bool "Debug"
        help
          Say Y here to enable ALSA debug code.

It is off by default in upstream, and the really helpful description
would cirtainly tend to lead to it being disabled.  But if it is helpful
to your debugging efforts David then I suspect we can enable it in Saucy
and see what happens.

-apw
