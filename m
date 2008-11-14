From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: possible problem in s3c24xx-pcm.c in git-devel
	branch
Date: Fri, 14 Nov 2008 12:46:41 +0000
Message-ID: <20081114124640.GB25307@sirena.org.uk>
References: <cabda6420811130657k4079884cge643c1b33b319b14@mail.gmail.com>
	<20081113151701.GG31592@sirena.org.uk>
	<cabda6420811130740u325cf60bse8401af768fb7340@mail.gmail.com>
	<20081113160936.GH31592@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A79141037F3
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 13:46:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081113160936.GH31592@sirena.org.uk>
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

On Thu, Nov 13, 2008 at 04:09:36PM +0000, Mark Brown wrote:

> AIUI it's a bootstrapping issue: the problem is what happens when the
> first DMA buffer completes if there isn't a new buffer ready.  Once
> there's a loaded buffer ready things are happy.

More info provided by Dave on IRC:

15:46 < prpplague> now the big difference between the 2410 and 2440 is ofcourse 
                   the primary clock, the 2410 generally running 200mhz whereas 
                   the 2440 is at 400mhz

...

15:49 < prpplague> i'm wondering if that when on a 200mhz s3c2410 that the 
                   second dma enqueued buffer is done, that it has been long 
                   enough for the dma channel to have started, but on the 2440 
                   running at 400mhz it hasn't had time to start

...

16:38 < prpplague> broonie: i wonder if i clock the my s3c2440 board at 200mhz 
                   and retested if i would see the issue
16:41 < prpplague> broonie: yep, i can recreate christians problem when using 
                   the s3c2440 at 200mhz
16:42 < prpplague> broonie: and also if i use the stock code, i.e. without the 
                   enqueue limit being 1, and running at 200mhz the audio issue 
                   goes away
