From: Simon Tremblay <bidou@videotron.qc.ca>
Subject: Re: ASoC machine driver: use more than one at91 ssc
Date: Wed, 13 Aug 2008 16:49:37 +0000 (UTC)
Message-ID: <loom.20080813T163128-717@post.gmane.org>
References: <loom.20080812T193653-308@post.gmane.org>
	<loom.20080813T060220-577@post.gmane.org>
	<20080813094706.GB30710@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 992A824537
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Aug 2008 18:49:50 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KTJXe-0003En-7R
	for alsa-devel@alsa-project.org; Wed, 13 Aug 2008 16:49:46 +0000
Received: from modemcable024.51-130-66.mc.videotron.ca ([66.130.51.24])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2008 16:49:46 +0000
Received: from bidou by modemcable024.51-130-66.mc.videotron.ca with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2008 16:49:46 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie <at> sirena.org.uk> writes:

> 
> On Wed, Aug 13, 2008 at 06:03:40AM +0000, Simon Tremblay wrote:
> > Simon Tremblay <bidou <at> videotron.qc.ca> writes:
> 
> > > Does I need more than one snd_soc_dai_link in my snd_soc_machine? But for
> > what I
> > > understand for now, I need one SSC for sound output and 2 SSC for sound
 input.
> 
> If the two SSCs were completely independant you'd have separate DAIs for
> SSC0 and SSC1 but it looks like you need to use both in a closely
> coupled configuration to get stereo record.
> 
> > > I don't know if there is some example about how to do that.
> 
> Not that spring to mind - the SoCs I'm aware of all support stereo
> natively.
> 
> > I was thinking about that and maybe the best way to resolve this is to modify
> > at91-ssc.c and add a new entry in at91_ssc_dai that supports ssc0 and ssc1
> > together (and modify / add some functions to support this new entry). Humm,
 I
> > need to find a way to be able to reuse code here. What do you think about
all of
> > that ?
> 
> That looks like the best bet for this situation unless you treat the
> stereo signal as two mono channels.  The WM8753 driver does something
> vaugely similar with the DAI mode configuration it offers, you might
> find some inspiration there, though in this case simply declaring an
> additional link and leaving it up to the machine driver to only register
> the desired one might be the best bet.
> 
> Code reuse shouldn't be too much of a problem - many of the DAI
> operations will be shared and at worst I'd expect you'll end up writing
> wrapper functions to pass through the operations to both DAIs.
> 

Ok thank you for comments. Currently I'm working on that to be able to use my
codec properly (because the two SSC are connected to my codec).

But just for to test, I activated only SSC1 and I got a weird problem. When my
machine driver module is loaded, I hear something from my headphone like it
"synced" with console serial output (I hear noise when characters are
transmitted to console serial output). But I don't know if there is something
about not activating SSC0 that could cause that...
