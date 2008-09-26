From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ALSA:ATMEL: common arch for audio via ssc(patch
	3/3: adding directories)
Date: Fri, 26 Sep 2008 14:15:29 +0100
Message-ID: <20080926131528.GC15493@sirena.org.uk>
References: <48DCAA3A.8030209@atmel.com> <20080926125035.GB15493@sirena.org.uk>
	<48DCDC32.8060207@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 283BE103819
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Sep 2008 15:15:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48DCDC32.8060207@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Cc: alsa-devel@alsa-project.org, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, Geoffrey Wossum <geoffrey@pager.net>, Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 26, 2008 at 02:57:22PM +0200, Sedji Gaouaou wrote:

> Furthermore I didn't change the i2c initialization since I don't know 
> what is the status of the patch(I tried this one: 
> http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=commitdiff;h=be99827ea333eb15560a8b52ba57a2dce1bdfbb8
> but I not sure whether it is complete or not?

I'm not sure exactly what your concern is here?  Anything you submit
needs to be against what's in Takashi's tree.

> I have send a first patch which is removing the two directories(at91 and 
> at32), but I am not sure it is the proper way to do it.(it seems that it 
> is blocked by the moderator).

The patch was just too large for the mailing list and got trapped by the
size limits.  It's probably better to make that the final patch of the
series but it doesn't make a huge amount of difference overall.
