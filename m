From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: Remove clkdiv and pll setters from pxa dais
Date: Wed, 30 May 2018 21:15:37 +0200
Message-ID: <87tvqprm3q.fsf@belgarion.home>
References: <ca4efb05-36d3-1571-6336-394b75ecc843@zonque.org>
 <20180530092445.GC6920@sirena.org.uk>
 <47e32456-c603-1c9c-b6ef-3c98f000caf9@zonque.org>
 <20180530102028.GF6920@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp11.smtpout.orange.fr
 [80.12.242.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 867DE267796
 for <alsa-devel@alsa-project.org>; Wed, 30 May 2018 21:15:40 +0200 (CEST)
In-Reply-To: <20180530102028.GF6920@sirena.org.uk> (Mark Brown's message of
 "Wed, 30 May 2018 11:20:28 +0100")
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
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, ALSA development <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@kernel.org> writes:

> On Wed, May 30, 2018 at 11:47:15AM +0200, Daniel Mack wrote:
>> On Wednesday, May 30, 2018 11:24 AM, Mark Brown wrote:
>
>> > I think it's copied from somewhere else probably, it looks like there's
>> > a bit of code motion going on.  I bet it was just for I2S, keeping the
>> > extra clock cycle for the initial rising edge in the frame but not
>> > actually required.
>
>> Hmm, okay. You happen to still have access to that board for regression
>> tests?
>
> No, I doubt anyone does - it was the PXA32x reference platform.  The
> ones I'm aware of unfortunately got thrown out.

I have a zylonite based on a pxa310 in my non-regression bench, if that can
help. That's one of the targets I use to validate patches against the PXA tree.

I'll let you come up with a patch. Meanwhile I'll try to figure out if I can
make the audio alive again.

Cheers.

-- 
Robert
