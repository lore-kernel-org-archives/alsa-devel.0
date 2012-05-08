From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: Distorted jackd output on Macbooks
Date: Tue, 8 May 2012 16:45:30 +0200
Message-ID: <20120508144530.GZ6396@ltw.loris.tv>
References: <4F9AEFEC.4070509@drcomp.erfurt.thur.de>
	<s5hk40nndgz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [188.40.101.23])
	by alsa0.perex.cz (Postfix) with ESMTP id 4094824354
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 16:45:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hk40nndgz.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, May 08, 2012 at 01:01:32PM +0200, Takashi Iwai wrote:

> > JFTR, we've seen users that report distorted sound on their macbooks
> > when using jackd.
> > 
> > The workaround is to force 16-bit output:
> > 
> >     http://jackaudio.org/macbook_distortion
> > 
> > Chip in question was the Cirrus Logic CS4206. We don't know yet which of
> > the formats (32/24) is broken, maybe only one, maybe both.
> 
> Distrotion means noisy outputs or complete noise?

Noisy output, like clipping. As if the MSB would be wrong.

Here's an example:

   http://www.youtube.com/watch?v=QD23mC_Dbek


> And does this happen only with JACK?  That is, if you run "aplay -Dhw"
> with 32bit PCM, does it play normally?

I've installed Linux on my spare MacBookPro and can report that JACKD is
not to blame. aplay and jackd behave the same:

   FLOAT_LE is distorted
   S32LE is fine


So only FLOAT_LE is broken, S32LE and S24_3LE are fine.


HTH

-- 
mail: adi@thur.de  	http://adi.thur.de	PGP/GPG: key via keyserver
