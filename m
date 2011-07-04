From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: What is correct way to put conditional stuff in
 ASoC codec driver?
Date: Mon, 4 Jul 2011 12:26:50 +0530
Message-ID: <1309762610.15931.119.camel@matrix>
References: <1309437990.15931.67.camel@matrix>
	<20110630163706.GA18120@sirena.org.uk>
	<1309509205.15931.89.camel@matrix>
	<20110701161749.GD23784@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31]) by alsa0.perex.cz (Postfix) with ESMTP id 3D48D24453
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jul 2011 08:50:05 +0200 (CEST)
In-Reply-To: <20110701161749.GD23784@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-07-01 at 21:47 +0530, Mark Brown wrote:
> On Fri, Jul 01, 2011 at 02:03:25PM +0530, Ashish Chavan wrote:
> > On Thu, 2011-06-30 at 22:07 +0530, Mark Brown wrote:
> 
> > > You'd need to implement custom controls for the relevant enables which
> > > check to see what is currently enabled and prevents enables if there
> > > are conflicts.  You should do this dynamically and I'd expect that only
> > > the enables actually need to check anything, adjusting parameters for
> > > things that aren't active is usually no problem.
> 
> > I see. That means it's ok to allow setting up values of five band
> > equalizers even when overall equalizer functionality is disabled.
> > Can you point me to any existing code that has such custom control(s)
> > which need to check for similar conditions? I am sure that many existing
> > codecs would have this kind of inter dependent functions.
> 
> This requirement is actually fairly unusual, but there's plenty of
> drivers with open coded controls for various reasons.  Have you tried
> looking at the existing drivers in mainline?
> 

Do you mean the requirement of having interdependent codec functionality
is unusual? If yes, then it is something different that what I expected
and I need to do some homework before asking further questions. By
"Homework" I roughly mean, 
(1) Going through data sheets of some of Wolfsons' codecs to find out if
they have similar inter dependent functional blocks.
(2) If something is found, have a detailed look at that codec's driver
in mainline. Find out how these functions are handled.

Do you think that this is the correct way to move forward?

I haven't done this exercise yet, mainly because I assumed that my
requirement is common and I could easily find a way to handle it from
existing drivers or experts!

In general, I have gone through some of the existing codec drivers in
mainline to get a feel of them but couldn't find something that handles
conditional part. May be I am missing something.
