From: =?ISO-8859-1?Q?Ingo=20Br=FCckl?= <ib@wupperonline.de>
Subject: Re: [PATCH] ALSA: hda - Make path_has_mixer() tristate
Date: Thu, 05 Mar 2015 17:44:13 +0100
Message-ID: <54f889c7.6f518a6b.bm000@wupperonline.de>
References: <s5h1tl37jye.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutD.wup.tal.de (moutd.wup.tal.de [213.240.144.30])
 by alsa0.perex.cz (Postfix) with ESMTP id 7941026052B
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2015 17:54:43 +0100 (CET)
In-Reply-To: <s5h1tl37jye.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, superquad.vortex2@gmail.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote on Thu, 05 Mar 2015 12:38:33 +0100:

>> I would love the auto-parser to assign the speaker to node 0x02 (or simply
>> disable the speaker), but unfortunately I'm not getting a surround config
>> with the current code, but only:
>>
>> ==> lo_type=0, wired=1, mio=0
>> multi_outs = 14/0/0/0 : 2/0/0/0 (type LO)
>> hp_outs = 1b/0/0/0 : 4/0/0/0
>> spk_outs = 15/0/0/0 : 3/0/0/0
>>
>> This is unsatisfactory.

> You can force the DAC assignment by specifying
> spec->gen.perferred_dacs.  Did you try it?

Yes, no success. I'm now ignoring speaker 0x15.

Ingo
