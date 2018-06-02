From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: Remove clkdiv and pll setters from pxa dais
Date: Sat, 02 Jun 2018 21:26:42 +0200
Message-ID: <87k1rhrnv1.fsf@belgarion.home>
References: <ca4efb05-36d3-1571-6336-394b75ecc843@zonque.org>
 <20180530092445.GC6920@sirena.org.uk>
 <47e32456-c603-1c9c-b6ef-3c98f000caf9@zonque.org>
 <20180530102028.GF6920@sirena.org.uk> <87tvqprm3q.fsf@belgarion.home>
 <20180531102250.GA13319@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp11.smtpout.orange.fr
 [80.12.242.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 7468D26795C
 for <alsa-devel@alsa-project.org>; Sat,  2 Jun 2018 21:26:49 +0200 (CEST)
In-Reply-To: <20180531102250.GA13319@sirena.org.uk> (Mark Brown's message of
 "Thu, 31 May 2018 11:22:50 +0100")
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

>> I'll let you come up with a patch. Meanwhile I'll try to figure out if I can
>> make the audio alive again.
>
> Probably worth taking a look at the big AC'97 refactoring that happened
> a while ago I guess...

Ah that was already the case, I had tested on the zylonite platform, up to the
point where the asound zylonite card was correctly probed.

That reminds me that the last patch of the AC97 serie was not merged (the PXA
specific one), so I'll repost it :
 - original https://patchwork.kernel.org/patch/9951919/
 - repost will add a NULL pointer check + rebase, in its v8 version

Cheers.

-- 
Robert
