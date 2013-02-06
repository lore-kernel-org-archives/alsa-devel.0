From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: hda_analyzer failed
Date: Wed, 6 Feb 2013 13:35:37 +0800
Message-ID: <CAN8cciYR8Z4M+Knh1P=Pe10xjTXNJ9pRdjdxEz7K2bu7T5bRDQ@mail.gmail.com>
References: <CAN8cciaewnb1f9G7nhE+06GBZiUgJvZ5LwTz+AFmLcHJoYjzhw@mail.gmail.com>
 <CAN8cciZqkGH5mK_vn20m023YYgc3UC7okBXHobmdj3Tqibamiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f180.google.com (mail-ie0-f180.google.com
 [209.85.223.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C9B32625CB
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2013 06:35:38 +0100 (CET)
Received: by mail-ie0-f180.google.com with SMTP id bn7so1361173ieb.39
 for <alsa-devel@alsa-project.org>; Tue, 05 Feb 2013 21:35:37 -0800 (PST)
In-Reply-To: <CAN8cciZqkGH5mK_vn20m023YYgc3UC7okBXHobmdj3Tqibamiw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org, =?UTF-8?B?TWFub2xvIETDrWF6?= <diaz.manolo@gmail.com>, Miro Hodak <mhodak127@gmail.com>, Takashi Iwai <tiwai@suse.de>, basinilya@gmail.com
List-Id: alsa-devel@alsa-project.org

>>
>>  > File "/dev/shm/hda-analyzer/hda_proc.py", line 143, in wrongfile
>>  >     raise ValueError, "wrong proc file format (%s)" % msg
>>  > ValueError: wrong proc file format (integer decode 'State of AFG node
>> 0x01:' ('Node '))
>>  >
>>  > Any ideas?
>>
>> This patch add lines which make the parser of hda_proc.py fail
>>
>>
http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.git;a=commitdiff;h=f4f0a8c4783a0258f2d0020a67fd619ce41a02a3;hp=e4cc6153401fc59d6d4ca0317be5774bdbd399ba
>>
>
> Sigh, this is not the first time new stuff in the proc file crashes
hda_analyzer.
>
> Jaroslav, can you please fix hda_analyzer so that it ignores new stuff in
the proc file instead of crashing, so we don't have this problem over and
over again?
>

I don`t understand why the parser have to ignore new stuff

BTW, why hda_proc query the connection list of vendor defined widget ?

http://git.kernel.org/?p=linux/kernel/git/tiwai/hda-emu.git;a=blob;f=codecs/ad1882-sparta;hb=HEAD

Node 0x23 [Vendor Defined Widget] wcaps 0xf00100: Mono
   Connection: -22
