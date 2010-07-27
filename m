From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: hda-verb, hda-analyzer, hda-emu and codecgraph
Date: Tue, 27 Jul 2010 16:07:31 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1007271603010.4068@eeebox2.perex-int.cz>
References: <4C4EC384.4040904@canonical.com> <s5hzkxdt6cf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B6492446C
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jul 2010 16:07:32 +0200 (CEST)
In-Reply-To: <s5hzkxdt6cf.wl%tiwai@suse.de>
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

> At Tue, 27 Jul 2010 13:31:16 +0200,
> David Henningsson wrote:
>>
>> Hi Takashi,
>>
>> Do you plan to make hda-verb, hda-analyzer, hda-emu and/or codecgraph a
>> part of alsa-tools/alsa-utils/pyalsa in the future?
>>
>> I'm asking because I would like to know if it makes sense to package
>> them separately for Debian.
>
> I can put hda-emu to alsa-tools if anyone wants.
> This is a really small code.  (But I didn't put it because I didn't
> want to 100 times bigger auto-tools stuff for it :)
>
> But, hda-emu doesn't suit with alsa-tools category.  It's a tool to
> be built with the latest (or the version to be tested) sound kernel
> tree.  So, it's not much worth to package.
>
> hda-analyzer is already in alsa.git.  I guess it depends on Jaroslav.

What about an idea to move all hda related stuff to new git repository 
like alsa-hda-tools ? It will make packaging more easy with uniform 
name and developers will find all recent stuff at one place.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
