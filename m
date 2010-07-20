From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] wm8960: fix compile error
Date: Tue, 20 Jul 2010 16:18:52 +0100
Message-ID: <20100720151852.GA20241@rakim.wolfsonmicro.main>
References: <1279619362.11179.2.camel@mola>
	<20100720110722.GN10222@rakim.wolfsonmicro.main>
	<AANLkTinTT3_yy02wGJfKwannKT2rrZN899JKrdlvtLz7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 99A85245EC
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jul 2010 17:18:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTinTT3_yy02wGJfKwannKT2rrZN899JKrdlvtLz7@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 20, 2010 at 11:02:37PM +0800, Axel Lin wrote:
> 2010/7/20 Mark Brown <broonie@opensource.wolfsonmicro.com>:

> > but please do try to bear in mind the feedback you've previously been
> > given about formatting your patches so they can be easily applied. =A0Y=
ou

> I'm a little bit confused about the meaning of "formatting your patches"?
> Do you mean my patches cannot be applied by git am command? or?
> ( I tried the git am command with the mail I sent and it looks ok )

In this case the main thing is the subject line which is not consistent
with other subject lines for patches in this area of code.  This sort of
stuff is particularly important when you're submitting large numbers of
very small fixes.

> > probably also want to look at the CC list for your patches, I'm not sure
> > why you're CCing Tejun here.

> I get the CC list by get_maintainer.pl. Looks like the script gives me wr=
ong
> CC list.

Yes, you need to apply a bit of taste to the output - it's inclined to
generate false positives.  For matches from MAINTAINERS it's good but
for things generated from the git logs it can easily miss people or pick
up people who've been doing kernel wide cleanup work.
