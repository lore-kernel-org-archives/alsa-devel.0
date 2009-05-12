From: Karl Beldan <karl.beldan@gmail.com>
Subject: Re: [PATCH 2/4] pxa2xx-i2s: Handle SACR1_DRPL and
 SACR1_DREC separately
Date: Tue, 12 May 2009 14:38:19 +0200
Message-ID: <4A096DBB.1080909@gmail.com>
References: <4A03748B.1010302@gmail.com> <20090508104229.GD5654@sirena.org.uk>
	<20090511190504.GF20283@sirena.org.uk> <4A087FCF.2080304@gmail.com>
	<20090511210729.GA4404@sirena.org.uk> <4A08A001.4050003@gmail.com>
	<20090512085838.GB29889@sirena.org.uk> <4A094867.2010600@gmail.com>
	<20090512103243.GH29889@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f175.google.com (mail-ew0-f175.google.com
	[209.85.219.175])
	by alsa0.perex.cz (Postfix) with ESMTP id B65EF103840
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 14:38:23 +0200 (CEST)
Received: by ewy23 with SMTP id 23so4531052ewy.32
	for <alsa-devel@alsa-project.org>; Tue, 12 May 2009 05:38:23 -0700 (PDT)
In-Reply-To: <20090512103243.GH29889@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, Matthieu Dumont <matthieu.dumont@mobile-devices.fr>, liam.girdwood@wolfsonmicro.com, Eric Miao <eric.miao@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Tue, May 12, 2009 at 11:59:03AM +0200, Karl Beldan wrote:
>> Mark Brown wrote:
> 
>>> That doesn't seem to tie up - I can see the initialisation changing the
>>> behaviour on first run but it seems surprising that this should happen
>>> on subsequent runs too.  Alternatively, is your initialisation patch
>>> safe to apply by itself?
> 
>> Well 2/4 stops the clocks only if both REC and RPL are disabled.
>> Without 1/4 you end up with REC enabled at startup.
>> In a scenario where you have never used REC you end up RPLing with REC always on.
>> REC being on at shutdown(),clocks won't stop.
> 
> Yet they are being stopped by something...
> 
You said that clocks are NOT stopped when applying patch 2/4 without 1/4.
I detailed a fairly likely code path.


>>> As previously discussed you need to rework the patch to not do the reset
>>> on initial probe not when the module is loaded, you need to address this
>>> rather than reposting.
> 
>> The patch in question is moving the reset in probe rather than module init - with comment updated.
>> What is wrong ?
> 
> A repost is where you send exactly the same thing again.  When you say
> you're reposting something it means you've not made any changes; if you
> say that's what you're doing and your code has problems that need to be
> fixed it's fairly obvious that all the previous comments are going to
> continue to apply.
> 
When I said I 'resent' it, my meaning was not to let you understand that I did not modify it obviously.

>>> I'll try to find time to re-review the series but I'm going to need to
>>> sit down with the datasheet and check this in much more detail.
> 
>> For 1/4 and 2/4 there should not be great need, Really.
> 
> There's been enough stuff with the series that I've got a few alarm
> bells ringing, if only with obscure relationships between the patches.
I could say the same about the current status and handling but I will ask you to point precise points instead, please.
As of the current status of the driver there is not even full duplex, maintainance is likewise.
The patches I am sending are quite easy to discuss.

Could you point what is wrong in the code or comments ?
Nitpicking about "A repost is where you send exactly the same thing again." and talking so much about
pb applying 2/4 without 1/4 really sucks.

I said and am saying my patches improve greatly the code quality/functionnality, if you think otherwise, give tangible reasons and I'll be really happy to discuss/rework/abandon the patches.

Since I have no feedback from Maintainers, I am pinging the original author hoping I won't disturb too much.


-- 
Karl
