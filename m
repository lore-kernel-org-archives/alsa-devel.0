From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] amidi: add delay option
Date: Fri, 12 Aug 2016 13:38:06 +0200
Message-ID: <feb1fb88-ab3f-1c77-3c21-88fb74a6b7dc@ladisch.de>
References: <20160811163106.15063-1-eu@felipetonello.com>
 <9210b56c-04ec-70c7-dc66-0478f13636d1@ladisch.de>
 <7ebeac6f-f7b9-5c1e-bfda-c4df607fb6df@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 1C303268683
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 13:38:07 +0200 (CEST)
In-Reply-To: <7ebeac6f-f7b9-5c1e-bfda-c4df607fb6df@felipetonello.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Felipe Ferreri Tonello <eu@felipetonello.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Felipe Ferreri Tonello wrote:
> On 12/08/16 08:10, Clemens Ladisch wrote:
>> Felipe F. Tonello wrote:
>>> +	case 0xf4:
>>> +	case 0xf5:
>>> +		return 0; /* ignore */
>>> +	case 0xf7:
>>> +		return 0; /* ignore */
>>
>> Silent data loss is bad.
>
> What do you mean by that?

When you want to send the byte F5, this code will silently drop it.

>>> +	case 0x00 ... 0x7f:
>>> +		return rstate_len ?: rstate_len - 1;
>>
>> rstate_len - 1 == -1
>
> ?
>
> That's why there is this condition, if rstate_len is zero, than it
> returns 0.

There is not need to use rstate_len when its value is already known and
does not affect the computation; it could just be written as:

        return rstate_len ?: -1;

>> The most robust way to find message boundaries probably would be a state
>> machine.  However, there is actually no requirement to find all message
>> boundaries; the _actual_ requirement is to insert pauses between SysEx
>> messages.  So don't bother to try to parse everything; just search for
>> F0 or F7.
>
> Well, I tough it would be useful to work in any type of MIDI message not
> just SysEx.

But there is no _actual_ use case, where somebody actually needed it.
And as shown by all those problems, handling all types of messages makes
the code too complex.


Regards,
Clemens
