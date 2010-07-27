From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: hda-compiler, was: hda-verb, hda-analyzer,
 hda-emu and codecgraph
Date: Tue, 27 Jul 2010 18:33:48 +0200
Message-ID: <4C4F0A6C.6040203@canonical.com>
References: <4C4EC384.4040904@canonical.com>
	<s5hzkxdt6cf.wl%tiwai@suse.de>	<alpine.LNX.2.00.1007271603010.4068@eeebox2.perex-int.cz>	<s5hzkxdc8p6.wl%tiwai@suse.de>	<alpine.LNX.2.00.1007271622510.4068@eeebox2.perex-int.cz>	<4C4EFC4C.40707@canonical.com>
	<s5hmxtdvseg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 1594B103807
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jul 2010 18:33:51 +0200 (CEST)
In-Reply-To: <s5hmxtdvseg.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010-07-27 17:47, Takashi Iwai skrev:
> At Tue, 27 Jul 2010 17:33:32 +0200,
> David Henningsson wrote:
>>
>> 2010-07-27 16:57, Jaroslav Kysela skrev:
>>> A little off topic: hda-compiler . I'm playing with an idea to have the
>>> hda-intel driver behaviour description (patches) in a firmware file.
>>
>> There seem to be more than one thought in that area. Recently there has
>> been some discussion (at least on Ubuntu Developer Summit) whether the
>> device-tree[1] structure could be used in this area as well.
>> Since we would then have separate device-tree files, we could update
>> them independent of the kernel.
> 
> Did it come from Andy?  I've heard the idea to use OF from Grant in
> the last year, and yes, this is feasible.  But I'm not sure how much
> gain we'd get in the end.

I'm not sure who took the initial initiative, but more than one seem to
be interested.
Anyway, the goal is to make maintenance easier, and especially to be
able to update a small quirk, somewhat independent of the kernel.

> For new devices, except for a few ones like AD or Conexant, we usually
> write the generic tree parser so that BIOS information can be parsed
> dynamically.  If BIOS information is broken or insufficient, we can
> add some hints for correction, via sysfs for debugging or statically
> in the code for production.  

So you would prefer BIOS overrides (pin configs etc) to writing new models?
Would you say the entire "model" infrastructure is, or should be,
deprecated?

> And the rest of the problem is very
> specific to devices, and requires often some quirks in the parser
> itself.  So, in this scenario, there is little room OF can help.
> We'd like rather to avoid the static data, no matter in which form.

Whether that is SSID -> Model mappings or quirks for correcting the
BIOS, it seems unavoidable with static data to me?

> Meanwhile, the deployment of OF can be helpful if we move the whole
> parser stuff to the user-space and push the parsed/compiled tree info
> into the kernel (i.e. "firmware").  In such a case, OF representation
> can be more flexible; and the kernel has already the infrastructure.

So move half of the kernel code into userspace? Are you suggesting that
user-space gets a NID-tree, like in the codec-proc file, and returns
back init verbs, controls, etc?
I'm not experienced enough to foresee all the consequences of such a
massive rewriting.


-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
