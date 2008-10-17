From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] hda: add SW_LINEOUT_INSERT support
Date: Fri, 17 Oct 2008 15:19:40 +0100
Message-ID: <20081017141939.GG2546@sirena.org.uk>
References: <48F7F600.3040706@embeddedalley.com> <s5hd4hz69ia.wl%tiwai@suse.de>
	<20081017103857.GA2546@sirena.org.uk>
	<48F8833D.8080301@embeddedalley.com>
	<20081017123928.GD2546@sirena.org.uk>
	<48F88ABD.3010905@embeddedalley.com>
	<20081017130504.GE2546@sirena.org.uk>
	<48F89004.7090809@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2095F243A0
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Oct 2008 16:20:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48F89004.7090809@embeddedalley.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Matthew Ranostay <mranostay@embeddedalley.com>
Cc: Takashi Iwai <tiwai@suse.de>, Dmitry Torokhov <dtor@mail.ru>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 17, 2008 at 09:15:48AM -0400, Matthew Ranostay wrote:
> Mark Brown wrote:

[Please fix your MUA to wrap at something less than 80 columns,
currently your lines are ~90 characters long which makes your mails
harder to read.]

> > Could you provide a bit more detail here?  Are you saying that the
> > hardware has several line outputs and can report connection status but
> > is unable to identify which of them is connected?

> Yep, just wondering if that is an incorrect way of using the jack abstraction layer.

It'd be easier to comment if you could provide more detail here.  What
is the hardware actually capable of doing?  Without knowing what you're
trying to represent it's hard to say for sure if your code matches up
with that.

> As of yet we are only using this to confirm if an HP and Line Out is connected for use
> in ALSA plugin, if there is the stream processing is turned off.

Right, that's one of the things I'd expected user space to be able to do
with this.

> So basically if you plug into two or more line outs, each time you unplug a line out,
> it will still send a event as if a line out was connected until all line outs are removed.

I *think* from this that you have multiple line output jacks and the
hardware is able to do detection on each individually?  In that case
then yes, you are using the API incorrectly - you should be registering
one jack per physical jack.
