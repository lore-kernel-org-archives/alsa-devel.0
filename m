From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] Allow a custom ASOC machine driver
	with soc-of-simple
Date: Wed, 23 Jul 2008 16:36:55 +0100
Message-ID: <20080723153642.GB22926@sirena.org.uk>
References: <20080722235349.11648.90112.stgit@terra>
	<20080722235351.11648.56387.stgit@terra>
	<20080723105334.GC8377@sirena.org.uk>
	<9e4733910807230709l4249eaf6m750bad811342ba13@mail.gmail.com>
	<20080723151431.GA22926@sirena.org.uk>
	<9e4733910807230816m474af04ch9b6650cdbb96ffec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BBCBC24405
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jul 2008 17:36:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910807230816m474af04ch9b6650cdbb96ffec@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 23, 2008 at 11:16:17AM -0400, Jon Smirl wrote:
> On 7/23/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> >  I'd also expect something to handle the existing user.

> This is a modification to Grant's new driver. Grant is the only other user.

Right, hence my use of the singular : ) .  Since you are adding this new
of_snd_soc_register_machine() Grant's existing platform won't be calling
it yet and will therefore stop instantiating the ASoC subsystem until it
is changed to do so.
