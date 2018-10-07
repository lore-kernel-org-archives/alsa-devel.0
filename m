From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH][RFC][alsa-utils 5/9] alsactl: use link
 list to maintain source of events
Date: Sun, 7 Oct 2018 12:04:36 +0900
Message-ID: <c878435f-ec5c-5136-d1f0-9288aff38b33@sakamocchi.jp>
References: <20181005144729.21388-1-o-takashi@sakamocchi.jp>
 <20181005144729.21388-6-o-takashi@sakamocchi.jp>
 <ebd92686-31d6-1c2b-42bc-5e9dd9679cf6@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 79384267783
 for <alsa-devel@alsa-project.org>; Sun,  7 Oct 2018 05:04:41 +0200 (CEST)
Received: by mail-pl1-f193.google.com with SMTP id v5-v6so8511891plz.13
 for <alsa-devel@alsa-project.org>; Sat, 06 Oct 2018 20:04:41 -0700 (PDT)
In-Reply-To: <ebd92686-31d6-1c2b-42bc-5e9dd9679cf6@perex.cz>
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
To: Jaroslav Kysela <perex@perex.cz>, tiwai@suse.de, thomas@coldfix.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Jaroslav,

On Oct 6 2018 02:14, Jaroslav Kysela wrote:
> Dne 5.10.2018 v 16:47 Takashi Sakamoto napsal(a):
>> At present, handlers for control nodes are maintained by one-dimensional
>> array. This is not necessarily useful to maintain handlers with
>> associated information.
>>
>> This commit adds link-list for the maintenance.
> 
> Thanks for the improved code.
> 
> Please, use macros in list.h to manage linked list which are inherited
> from the kernel here.

Let me confirm the macro about which you mention.

This patchset is for alsa-utils. In a package of alsa-utils, there's no
such header.

A package of alsa-lib v1.1.6 has 'include/list.h', however this is not
installation target.

Would I ask you where the list is available?


Thanks

Takashi Sakamoto
