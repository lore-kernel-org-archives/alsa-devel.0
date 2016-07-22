From: Yann COLLETTE <ycollette.nospam@free.fr>
Subject: Re: M-Audio Fast track problem
Date: Fri, 22 Jul 2016 16:16:30 +0200
Message-ID: <150a9f89-1dfb-0c4d-9714-5066ba5cff7a@free.fr>
References: <e1010d1f-8265-7a29-2c49-279a6fceab9f@free.fr>
 <f6c5384c-695c-1ea2-8ce4-a7ca0189dce0@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by alsa0.perex.cz (Postfix) with ESMTP id 23545265713
 for <alsa-devel@alsa-project.org>; Fri, 22 Jul 2016 16:16:32 +0200 (CEST)
Received: from [192.168.0.44] (unknown [82.241.14.88])
 by smtp1-g21.free.fr (Postfix) with ESMTP id 74E32B0054C
 for <alsa-devel@alsa-project.org>; Fri, 22 Jul 2016 14:14:26 +0200 (CEST)
In-Reply-To: <f6c5384c-695c-1ea2-8ce4-a7ca0189dce0@ladisch.de>
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
List-Id: alsa-devel@alsa-project.org

So, my question is: what is a control wrt to alsamixer ?

I hoped it should be possible to control the volume of this usb sound =

card with alsamixer ...
There is also a line out but absolutely no sound comes from this output.
I used it via jack without problem, but I can't use the line out output.
I thought this was due to a volume level set to  0 for the line out and =

I tried to set it via alsamixer  ... without success.


Le 22/07/2016 =E0 14:44, Clemens Ladisch a =E9crit :
> Yann Collette wrote:
>> I've got a M-Audio fast track.
>>
>> If I open alsamixer and select the fast track sound card, alsamixer just=
 displays the message
>>
>> "This device has no command"
> The actual message is "This sound device does not have any controls."
> (Apparently, the translation is somewhat off.)
>
>> Is it a bug or a normal behavior ?
> It were a bug only if that device actually had some control.
>
>
> Regards,
> Clemens
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
