From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: hda-verb, hda-analyzer, hda-emu and codecgraph
Date: Tue, 27 Jul 2010 16:57:44 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1007271622510.4068@eeebox2.perex-int.cz>
References: <4C4EC384.4040904@canonical.com> <s5hzkxdt6cf.wl%tiwai@suse.de>
	<alpine.LNX.2.00.1007271603010.4068@eeebox2.perex-int.cz>
	<s5hzkxdc8p6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E0FB245CD
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jul 2010 16:57:45 +0200 (CEST)
In-Reply-To: <s5hzkxdc8p6.wl%tiwai@suse.de>
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

> At Tue, 27 Jul 2010 16:07:31 +0200 (CEST),
> Jaroslav Kysela wrote:
>>
>> On Tue, 27 Jul 2010, Takashi Iwai wrote:
>>
>>> At Tue, 27 Jul 2010 13:31:16 +0200,
>>> David Henningsson wrote:
>>>>
>>>> Hi Takashi,
>>>>
>>>> Do you plan to make hda-verb, hda-analyzer, hda-emu and/or codecgraph a
>>>> part of alsa-tools/alsa-utils/pyalsa in the future?
>>>>
>>>> I'm asking because I would like to know if it makes sense to package
>>>> them separately for Debian.
>>>
>>> I can put hda-emu to alsa-tools if anyone wants.
>>> This is a really small code.  (But I didn't put it because I didn't
>>> want to 100 times bigger auto-tools stuff for it :)
>>>
>>> But, hda-emu doesn't suit with alsa-tools category.  It's a tool to
>>> be built with the latest (or the version to be tested) sound kernel
>>> tree.  So, it's not much worth to package.
>>>
>>> hda-analyzer is already in alsa.git.  I guess it depends on Jaroslav.
>>
>> What about an idea to move all hda related stuff to new git repository
>> like alsa-hda-tools ? It will make packaging more easy with uniform
>> name and developers will find all recent stuff at one place.
>
> Well, hda-emu shouldn't be packaged together, so I'd like to keep it

I would just put the hda-emu to repo for reference and access. The 
packaging is different thing.

> separately.  So, what else?  hda-verb and hda-analyzer?  hda-verb
> hasn't been updated since long time ago :)

A little off topic: hda-compiler . I'm playing with an idea to have the 
hda-intel driver behaviour description (patches) in a firmware file. This 
file would contain an indexing against the hw identification and will 
contain instruction like:

32-bit 	(size and instruction)
 	16-bit - instruction code
 	16-bit - instruction size in 32-bit words

Possible instructions examples:

0x00010001 0x00000010	- attach beep device for NID 0x10
0x00020003 <nid> <verb> <param> - hda_verb initialization

Instruction blocks:
- hw initialization and controls, PCMs + etc. allocation (patch callback)
- function blocks - control info/get/put callbacks, unsolicited events

Variables, arrays:
- instructions to set/fetch information
- instructions to allocate and manage arrays

It's just a rough idea - many things must be designed and thinked out. But 
we need a compiler from an easy readable text syntax to generate these 
"firmware" files - hda-compiler.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
