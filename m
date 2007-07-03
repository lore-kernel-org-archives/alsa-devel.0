From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: [HDA Intel/STAC92xx] mic not
	working	(retasking?)...
Date: Tue, 03 Jul 2007 08:53:42 -0700
Message-ID: <1183478022.9416.6.camel@razman.gruemaster.com>
References: <6278d2220706271328u79afd988r44cc1fbfc41c6014@mail.gmail.com>
	<s5hved6z75l.wl%tiwai@suse.de>
	<6278d2220706301407p739ebfb5i52d4a2af3a17ecd8@mail.gmail.com>
	<s5habuec264.wl%tiwai@suse.de>
	<6278d2220707021539g1485af71v3cbb639f0844b271@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 6CBC3103812
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Jul 2007 17:53:46 +0200 (CEST)
In-Reply-To: <6278d2220707021539g1485af71v3cbb639f0844b271@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel J Blueman <daniel.blueman@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

You can type "cat /proc/asound/card0/codec#* > codec.txt" for each
state, changing the name of "codec.txt" each time.  When you make a
change in alsamixer (or any other audio mixer), the change will be
reflected here.  

Tobin

On Mon, 2007-07-02 at 23:39 +0100, Daniel J Blueman wrote:

> Hi Takashi,
> 
> On 02/07/07, Takashi Iwai <tiwai@suse.de> wrote:
> > > > Daniel J Blueman wrote:
> > > > >
> > > > > With both 2.6.20 and 2.6.22 kernels on Ubuntu 7.04 on my Sony Vaio
> > > > > SZ240, I'm unable to get my mic connector working at any cost.
> [snip]
> > > > > How can I change the jack retasking with the Intel HDA drivers or get
> > > > > further insight into this problem?
> > > >
> > > > First, show the contents of /proc/asound/card0/codec#* files...
> > >
> > > Firstly, thank you for replying; the only related cases I've been able
> > > to find on the internet suggest to use the 'model=vaio' option to the
> > > snd-hda-intel module, but this does not help.
> >
> > Try the patch below, choose "Line" as the capture source (if you want
> > a mic-input jack -- for the built-in mic, chooes "Mic"), and raise the
> > newly added "Capture Boost" volume.
> 
> Firstly, thank you for your time and help.
> 
> I have discovered the bug preventing me using the external mic socket
> before: in the mixer, the user has to select the [internal] mic input,
> then re-select the line-in (actually external mic) input; reading from
> (eg) /dev/dsp while changing this, the output suddenly is as expected
> when the line-in is re-selected.
> 
> Since we've got started, where should I look for the 'before' and
> 'after' state to compare to see into this?
> 
> This behaviour is reproducible with both 2.6.20 and 2.6.22-rc7.
> 
> Many thanks!
>   Daniel

-- 
Tobin Davis <tdavis@dsl-only.net>
