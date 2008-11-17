From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: possible problem in s3c24xx-pcm.c in git-devel
	branch
Date: Mon, 17 Nov 2008 11:00:10 +0000
Message-ID: <20081117110009.GA1559@sirena.org.uk>
References: <cabda6420811130657k4079884cge643c1b33b319b14@mail.gmail.com>
	<20081113151701.GG31592@sirena.org.uk>
	<cabda6420811130740u325cf60bse8401af768fb7340@mail.gmail.com>
	<20081113160936.GH31592@sirena.org.uk>
	<20081114124640.GB25307@sirena.org.uk>
	<cabda6420811140820y23de807fwbc064ce82c011f2c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 439402438E
	for <alsa-devel@alsa-project.org>; Mon, 17 Nov 2008 12:00:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <cabda6420811140820y23de807fwbc064ce82c011f2c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: christian pellegrin <chripell@gmail.com>
Cc: David Anders <dave123_aml@yahoo.com>, alsa-devel@alsa-project.org, Ben Dooks <ben-linux@fluff.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 14, 2008 at 05:20:35PM +0100, christian pellegrin wrote:

> initially loading but I remembered that there were only 2 buffers
> loaded because the lower level dma enqueue function returned error
> after that. I never saw problems with aplay and madplay.

No errors were being returned - the problems were all in the audio
output but the applications weren't aware of this.

> I will try to do some changes in that code but my worry is how to know
> how many periods are filled with data for sure by the upper ALSA
> layers (I'm not an expert in ASLA as you can see).

It's really up to the application how much data it tries to provide.
