From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2 v2] crec: Add primitive
	exception	handling
Date: Wed, 11 Dec 2013 11:15:51 +0000
Message-ID: <20131211111551.GA13948@opensource.wolfsonmicro.com>
References: <1386088075-21011-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1386088075-21011-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20131203182256.GL27568@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8AC4A261B07
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2013 12:15:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131203182256.GL27568@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, vinod.koul@linux.intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 03, 2013 at 06:22:56PM +0000, Mark Brown wrote:
> On Tue, Dec 03, 2013 at 04:27:55PM +0000, Charles Keepax wrote:
> 
> > +static void sig_handler(int signum __attribute__ ((unused)))
> > +{
> > +	printf("Interrupted, saving what we have!\n");
> > +
> > +	finish_record();
> > +
> > +	if (file)
> > +		fclose(file);
> > +
> > +	_exit(EXIT_FAILURE);
> > +}
> 
> You can't safely do most of this such as calling fclose() from within a
> signal handler, the set of functions that are guaranteed safe is quite
> limited - see signal(7).

A cool thing would be to use signalfd(2) to serialize the handling of the
signal and getting rid of the traditional signal handler.

>From a quick look at bionic it doesn't seem to define a syscall wrapper for that
so if one really wanted to use it, it would be through syscall(2) but that's
a bit ugly for this purpose.

Thanks,
Dimitris
