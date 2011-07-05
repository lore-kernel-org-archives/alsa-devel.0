From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: What is correct way to put conditional stuff in
 ASoC codec driver?
Date: Tue, 5 Jul 2011 19:55:22 +0530
Message-ID: <1309875922.15931.169.camel@matrix>
References: <1309437990.15931.67.camel@matrix>
	<20110630163706.GA18120@sirena.org.uk>
	<1309509205.15931.89.camel@matrix>
	<20110701161749.GD23784@opensource.wolfsonmicro.com>
	<1309762610.15931.119.camel@matrix>
	<20110704223419.GA1030@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE005.bigfish.com (am1ehsobe005.messaging.microsoft.com
	[213.199.154.208])
	by alsa0.perex.cz (Postfix) with ESMTP id 196A724377
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jul 2011 16:18:12 +0200 (CEST)
In-Reply-To: <20110704223419.GA1030@opensource.wolfsonmicro.com>
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

On Tue, 2011-07-05 at 04:04 +0530, Mark Brown wrote:
> > Do you mean the requirement of having interdependent codec functionality
> > is unusual? If yes, then it is something different that what I expected
> 
> Yes, or at least the need to actually worry about it is.

OK, I will stop worrying about it as of now and concentrate on other
stuff :-)

> > (1) Going through data sheets of some of Wolfsons' codecs to find out if
> > they have similar inter dependent functional blocks.
> 
> There should be no need to look at one particular vendor.

I just selected Wolfson because their ASoC codec drivers are in majority
if I look at sound/soc/codecs dir. So in my opinion, it just raises the
probability of finding the required thing.

> | You'd need to implement custom controls for the relevant enables which
> | check to see what is currently enabled and prevents enables if there
> | are conflicts.  You should do this dynamically and I'd expect that only

Yes, I got what you meant here and after some homework also found the
example of this. You are trying to convey something similar to what is
done within "outmixer_event()" function of sound/soc/codecs/wm8991.c (at
lest the condition checking part), right?

> All you're doing is trying to restrict the values that can be set on a
> control dynamically.

I think, it is more about restricting access to a set of controls
dynamically based of enable/disable of some other control(s).

I guess now I have enough details to start off implementation part. I
will pop up a query again, if I am stuck somewhere.

BTW thanks for helping me out in getting things clear. 
