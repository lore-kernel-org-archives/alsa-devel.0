From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: MPC5200: Support for buffer
	wrap	around
Date: Sun, 2 Aug 2009 12:49:50 +0100
Message-ID: <20090802114950.GA1778@sirena.org.uk>
References: <20090731230311.17686.46431.stgit@riker>
	<9e4733910908010647k3a4a22c5jf9b9eda482f016b1@mail.gmail.com>
	<1249139096.4582.13.camel@riker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9FDAF24159
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Aug 2009 13:49:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1249139096.4582.13.camel@riker>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Bonesio <bones@secretlab.ca>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 01, 2009 at 08:04:56AM -0700, John Bonesio wrote:

> When I umuted the PCM mixer setting, this printk text did not appear,
> yet when I read the mixer register setting for the headphone, it was set
> back to mute.

Like I said before, exactly which control are you adjusting here?

> If there is code in software doing this, it's very subtle.

My money would be on the AC97 controller having problems; the quality of
SoC AC97 controllers is variable.  It certainly doesn't sound like a
WM9712 issue; as I say I'd be very surprised if such an issue hadn't
come up before given how widely deployed the part is.
