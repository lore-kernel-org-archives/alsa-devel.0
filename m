From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH 11/11] ASoC: wm8994: Mark expected switch fall-through
Date: Mon, 6 Aug 2018 06:48:13 -0500
Message-ID: <e839abf4-cf54-fe2e-7eb8-57b12106b586@embeddedor.com>
References: <cover.1533151956.git.gustavo@embeddedor.com>
 <8e3df79b1dca92d49fd9d5c97391d31814ab40f9.1533151956.git.gustavo@embeddedor.com>
 <30613.1533313609@turing-police.cc.vt.edu>
 <85d918a5-6a14-ead0-4d0e-d63b5e43ad81@embeddedor.com>
 <20180803164504.GF6591@sirena.org.uk>
 <684a4fe9-6818-d19c-e7b7-fb8d592a0cee@embeddedor.com>
 <39703.1533318918@turing-police.cc.vt.edu>
 <20180806113426.GA17525@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180806113426.GA17525@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, valdis.kletnieks@vt.edu
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org



On 08/06/2018 06:34 AM, Mark Brown wrote:
> On Fri, Aug 03, 2018 at 01:55:18PM -0400, valdis.kletnieks@vt.edu wrote:
>> On Fri, 03 Aug 2018 11:56:12 -0500, "Gustavo A. R. Silva" said:
>>> On 08/03/2018 11:45 AM, Mark Brown wrote:
>>>> Basically nobody ever uses OPCLK so I'd be susprised if anyone ever
>>>> noticed.
> 
>> I wonder if nobody uses it because any attempts to do so get an error? :)
> 
> No, nobody ever physically wires up an OPCLK.  If one was there it'd be
> unavoidable.
> 
>>> I see. I wonder what's the best approach in this case. Should that code be
>>> removed instead of 'fixed'?
> 
>> I'm thinking that's a spot that needs a 'break;' added.
> 
> Yes.
> 

OK. I'll send a patch for this. But I wonder what's the best approach in this case,
so the fix can also be applied to stable.

Thanks
--
Gustavo
