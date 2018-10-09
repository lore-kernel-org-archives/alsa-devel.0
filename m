From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH][RFC][alsa-utils 5/9] alsactl: use link
 list to maintain source of events
Date: Tue, 9 Oct 2018 12:15:58 +0900
Message-ID: <507ea2a5-34c3-60ac-4bc1-4d0abf324d70@sakamocchi.jp>
References: <20181005144729.21388-1-o-takashi@sakamocchi.jp>
 <20181005144729.21388-6-o-takashi@sakamocchi.jp>
 <ebd92686-31d6-1c2b-42bc-5e9dd9679cf6@perex.cz>
 <c878435f-ec5c-5136-d1f0-9288aff38b33@sakamocchi.jp>
 <2e7f6db4-24a4-fc4d-cd11-b14480038734@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 8F8B7267987
 for <alsa-devel@alsa-project.org>; Tue,  9 Oct 2018 05:16:05 +0200 (CEST)
In-Reply-To: <2e7f6db4-24a4-fc4d-cd11-b14480038734@perex.cz>
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
To: Jaroslav Kysela <perex@perex.cz>, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Jaroslav,

On Oct 9 2018 00:14, Jaroslav Kysela wrote:
> Dne 7.10.2018 v 05:04 Takashi Sakamoto napsal(a):
>> Hi Jaroslav,
>>
>> On Oct 6 2018 02:14, Jaroslav Kysela wrote:
>>> Dne 5.10.2018 v 16:47 Takashi Sakamoto napsal(a):
>>>> At present, handlers for control nodes are maintained by one-dimensional
>>>> array. This is not necessarily useful to maintain handlers with
>>>> associated information.
>>>>
>>>> This commit adds link-list for the maintenance.
>>>
>>> Thanks for the improved code.
>>>
>>> Please, use macros in list.h to manage linked list which are inherited
>>> from the kernel here.
>>
>> Let me confirm the macro about which you mention.
>>
>> This patchset is for alsa-utils. In a package of alsa-utils, there's no
>> such header.
>>
>> A package of alsa-lib v1.1.6 has 'include/list.h', however this is not
>> installation target.
>>
>> Would I ask you where the list is available?
> 
> [alsa-utils]$ git log alsactl/list.h
> commit b402cf543aee5f6cd7561d964065a26f07459c8c
> Author: Jaroslav Kysela <perex@perex.cz>
> Date:   Thu Jul 31 15:45:08 2008 +0200
> 
>      Initial 'alsactl init' implementation
> 
>      See 'man 7 alsactl_init' for more details.
> 
>      Signed-off-by: Jaroslav Kysela <perex@perex.cz>

Ah..., exactly. I overlooked this probability. I'll use it for next
patchset.


Thanks

Takashi Sakamoto
