From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ASoC machine driver: use more than one at91 ssc
Date: Wed, 13 Aug 2008 10:47:07 +0100
Message-ID: <20080813094706.GB30710@sirena.org.uk>
References: <loom.20080812T193653-308@post.gmane.org>
	<loom.20080813T060220-577@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 48611244A5
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Aug 2008 11:47:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <loom.20080813T060220-577@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Simon Tremblay <bidou@videotron.qc.ca>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 13, 2008 at 06:03:40AM +0000, Simon Tremblay wrote:
> Simon Tremblay <bidou <at> videotron.qc.ca> writes:

> > Does I need more than one snd_soc_dai_link in my snd_soc_machine? But for
> what I
> > understand for now, I need one SSC for sound output and 2 SSC for sound input.

If the two SSCs were completely independant you'd have separate DAIs for
SSC0 and SSC1 but it looks like you need to use both in a closely
coupled configuration to get stereo record.

> > I don't know if there is some example about how to do that.

Not that spring to mind - the SoCs I'm aware of all support stereo
natively.

> I was thinking about that and maybe the best way to resolve this is to modify
> at91-ssc.c and add a new entry in at91_ssc_dai that supports ssc0 and ssc1
> together (and modify / add some functions to support this new entry). Humm, I
> need to find a way to be able to reuse code here. What do you think about all of
> that ?

That looks like the best bet for this situation unless you treat the
stereo signal as two mono channels.  The WM8753 driver does something
vaugely similar with the DAI mode configuration it offers, you might
find some inspiration there, though in this case simply declaring an
additional link and leaving it up to the machine driver to only register
the desired one might be the best bet.

Code reuse shouldn't be too much of a problem - many of the DAI
operations will be shared and at worst I'd expect you'll end up writing
wrapper functions to pass through the operations to both DAIs.
