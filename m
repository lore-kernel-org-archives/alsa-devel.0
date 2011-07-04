From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: What is correct way to put conditional stuff in
 ASoC codec driver?
Date: Mon, 4 Jul 2011 15:34:20 -0700
Message-ID: <20110704223419.GA1030@opensource.wolfsonmicro.com>
References: <1309437990.15931.67.camel@matrix>
	<20110630163706.GA18120@sirena.org.uk>
	<1309509205.15931.89.camel@matrix>
	<20110701161749.GD23784@opensource.wolfsonmicro.com>
	<1309762610.15931.119.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0278724380
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jul 2011 00:34:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1309762610.15931.119.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 04, 2011 at 12:26:50PM +0530, Ashish Chavan wrote:
> On Fri, 2011-07-01 at 21:47 +0530, Mark Brown wrote:

> > This requirement is actually fairly unusual, but there's plenty of
> > drivers with open coded controls for various reasons.  Have you tried
> > looking at the existing drivers in mainline?

> Do you mean the requirement of having interdependent codec functionality
> is unusual? If yes, then it is something different that what I expected

Yes, or at least the need to actually worry about it is.

> and I need to do some homework before asking further questions. By
> "Homework" I roughly mean, 

> (1) Going through data sheets of some of Wolfsons' codecs to find out if
> they have similar inter dependent functional blocks.

There should be no need to look at one particular vendor.

> (2) If something is found, have a detailed look at that codec's driver
> in mainline. Find out how these functions are handled.

I really don't understand the difficulties you are having here.  There
are many examples of drivers implementing custom handling for controls
in the kernel, some of which do things that sound fairly similar to what
you're doing (though not exactly the same thing mostly).

> I haven't done this exercise yet, mainly because I assumed that my
> requirement is common and I could easily find a way to handle it from
> existing drivers or experts!

So when you looked at the drivers what did you see?  I already told you
what you need to do:

| You'd need to implement custom controls for the relevant enables which
| check to see what is currently enabled and prevents enables if there
| are conflicts.  You should do this dynamically and I'd expect that only

All you're doing is trying to restrict the values that can be set on a
control dynamically.

> In general, I have gone through some of the existing codec drivers in
> mainline to get a feel of them but couldn't find something that handles
> conditional part. May be I am missing something.

Please be more concrete about what you looked at and what you didn't
find which you were expecting.  Any custom control should at least
include some bounds checking so it's very surprising you weren't able to
find any examples of how you could prevent the user setting invalid
settings.
