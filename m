From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: sgtl5000: Use devm_ functions
Date: Mon, 07 Jul 2014 17:34:14 +0200
Message-ID: <53BABDF6.4090400@metafoo.de>
References: <20140706070800.GA2927@himangi-Dell>
 <20140707144832.GL30458@sirena.org.uk>
 <alpine.DEB.2.10.1407071655171.4757@hadrien>
 <CAOMZO5AiFCnfTzo4TyB5e5c+xiHQiHUbhRVY7z=AbjOWZDX3NA@mail.gmail.com>
 <alpine.DEB.2.10.1407071721270.4757@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-166.synserver.de (smtp-out-167.synserver.de
 [212.40.185.167])
 by alsa0.perex.cz (Postfix) with ESMTP id D590B265475
 for <alsa-devel@alsa-project.org>; Mon,  7 Jul 2014 17:35:17 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.10.1407071721270.4757@hadrien>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <julia.lawall@lip6.fr>, Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Himangi Saraogi <himangi774@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 07/07/2014 05:23 PM, Julia Lawall wrote:
>
>
> On Mon, 7 Jul 2014, Fabio Estevam wrote:
>
>> On Mon, Jul 7, 2014 at 11:58 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>>
>>> Nevertheless, there is already a call to devm_regulator_bulk_get in
>>> sgtl5000_enable_regulators which calls sgtl5000_replace_vddd_with_ldo
>>> which calls ldo_regulator_register.  That call was introduced by
>>>
>>> commit 63e54cd9caa3ce03635810608519e2b37d8bc706
>>> Author: Fabio Estevam <fabio.estevam@freescale.com>
>>> Date:   Thu Apr 24 14:13:08 2014 -0300
>>>
>>> It seems that that patch should be reverted?
>>
>> I think so. Russell also reported a kernel oops when unbinding this
>> module, so I will prepare a patch reverting it.
>
> There is documentation about what kinds of devm functions exist, but it is
> too bad that there is no documentation about where they can be used.
> Often there are several levels of function pointers involved, so it can be
> hard to figure out whether they can be used just by looking at the code.
> I have only taken the strategy of using them in kinds of functions where
> someone else has alreadyy figured out that they can be used.

Yes, it is probably a bit underdocumented. The rule of thumb is don't use it 
anywhere else except for device probe callbacks (and functions that are only 
called from a device probe function) and only for the device that is being 
probed. There are probably a couple of instances in the kernel where the 
manged resource allocators are used in places where they shouldn't be used.

- Lars
