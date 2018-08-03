From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH 11/11] ASoC: wm8994: Mark expected switch
	fall-through
Date: Fri, 3 Aug 2018 13:24:20 -0500
Message-ID: <c924218b-6b55-1cb2-9773-02befcfa5882@embeddedor.com>
References: <cover.1533151956.git.gustavo@embeddedor.com>
 <8e3df79b1dca92d49fd9d5c97391d31814ab40f9.1533151956.git.gustavo@embeddedor.com>
 <30613.1533313609@turing-police.cc.vt.edu>
 <85d918a5-6a14-ead0-4d0e-d63b5e43ad81@embeddedor.com>
 <20180803164504.GF6591@sirena.org.uk>
 <684a4fe9-6818-d19c-e7b7-fb8d592a0cee@embeddedor.com>
 <39703.1533318918@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway33.websitewelcome.com (gateway33.websitewelcome.com
 [192.185.145.23])
 by alsa0.perex.cz (Postfix) with ESMTP id 50EB02677A8
 for <alsa-devel@alsa-project.org>; Fri,  3 Aug 2018 20:24:29 +0200 (CEST)
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
 by gateway33.websitewelcome.com (Postfix) with ESMTP id 0CBB824397
 for <alsa-devel@alsa-project.org>; Fri,  3 Aug 2018 13:24:29 -0500 (CDT)
In-Reply-To: <39703.1533318918@turing-police.cc.vt.edu>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: valdis.kletnieks@vt.edu
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



On 08/03/2018 12:55 PM, valdis.kletnieks@vt.edu wrote:
> On Fri, 03 Aug 2018 11:56:12 -0500, "Gustavo A. R. Silva" said:
>> On 08/03/2018 11:45 AM, Mark Brown wrote:
>>> Basically nobody ever uses OPCLK so I'd be susprised if anyone ever
>>> noticed.
> 
> I wonder if nobody uses it because any attempts to do so get an error? :)
> 
>> I see. I wonder what's the best approach in this case. Should that code be
>> removed instead of 'fixed'?
> 
> I'm thinking that's a spot that needs a 'break;' added.
> 

Yep. And I think the patch to fix this should be tagged for stable.

So, it seems we have two options:

1. Revert commit 2cea1542859bc812f1ec51ea71c06e927e5b922e and then apply a fix with the break statement.

or

2. Apply a fix with the break statement and then backport the fix to stable.

am I correct?

Thanks
--
Gustavo
