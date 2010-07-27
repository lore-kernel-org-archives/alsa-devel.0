From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: hda-compiler, was: hda-verb, hda-analyzer,
 hda-emu and codecgraph
Date: Tue, 27 Jul 2010 23:22:06 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1007272306270.4068@eeebox2.perex-int.cz>
References: <4C4EC384.4040904@canonical.com> <s5hzkxdt6cf.wl%tiwai@suse.de>
	<alpine.LNX.2.00.1007271603010.4068@eeebox2.perex-int.cz>
	<s5hzkxdc8p6.wl%tiwai@suse.de>
	<alpine.LNX.2.00.1007271622510.4068@eeebox2.perex-int.cz>
	<4C4EFC4C.40707@canonical.com>
	<s5hmxtdvseg.wl%tiwai@suse.de> <4C4F0A6C.6040203@canonical.com>
	<s5h8w4wbqd1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 4539F243F0
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jul 2010 23:22:08 +0200 (CEST)
In-Reply-To: <s5h8w4wbqd1.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 27 Jul 2010, Takashi Iwai wrote:

>>> Meanwhile, the deployment of OF can be helpful if we move the whole
>>> parser stuff to the user-space and push the parsed/compiled tree info
>>> into the kernel (i.e. "firmware").  In such a case, OF representation
>>> can be more flexible; and the kernel has already the infrastructure.
>>
>> So move half of the kernel code into userspace? Are you suggesting that
>> user-space gets a NID-tree, like in the codec-proc file, and returns
>> back init verbs, controls, etc?
>
> Yes.

I thought about the user space parsing, but I would see rather a simple 
limited special purpose bytecode interpreter in the HDA driver in the 
first state and an one-shot compiler. The bytecode can be eighter static 
(read from a firmware file using a lookup scheme based on SSIDs, BIOS pin 
setups etc.) and later, we may eventually create a complicated user space 
solution (bytecode generator).

Note that for handling unsolicited events, the description of behaviour 
(may be dynamic - based on actual nid state) should be available. The 
bytecode interpreter solution is ideal for both  static and dynamic 
behaviour description. Ideally, everything in patch_* files should be 
rewritten to use the bytecode interpreter (including auto sections).

If we design a special high-level language and a compiler generating the 
bytecode for the driver, we can describe hw <-> ALSA mapping on fewer 
lines and also we can drastically reduce the possibility to introduce an 
error like in C.

 				Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
