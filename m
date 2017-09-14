From: "S. Christian Collins" <s.chriscollins@gmail.com>
Subject: Re: "alsactl store" fails to save Echo Gina3G mixer
Date: Thu, 14 Sep 2017 08:40:35 -0500
Message-ID: <d4b1b2e2-687a-a9fc-4244-9ca54d709f60@gmail.com>
References: <d8d6d07c-ade6-1ccc-7111-ed367fccf0f9@gmail.com>
 <1fa01cef-7159-b1b2-8ec6-5eab7f2a7e29@sakamocchi.jp>
 <7ef92b65-ef37-1a68-b1d8-e3a747859200@gmail.com>
 <e59f34a8-0999-c552-00e0-3d20a0721d3f@sakamocchi.jp>
 <1709042113040.5915@beth.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f181.google.com (mail-io0-f181.google.com
 [209.85.223.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C8F0266986
 for <alsa-devel@alsa-project.org>; Thu, 14 Sep 2017 15:40:39 +0200 (CEST)
Received: by mail-io0-f181.google.com with SMTP id i197so442452ioe.9
 for <alsa-devel@alsa-project.org>; Thu, 14 Sep 2017 06:40:39 -0700 (PDT)
In-Reply-To: <1709042113040.5915@beth.localdomain>
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
To: Mark Hills <mark@xwax.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi, is there anything else you would like me to do to help with 
this issue? Should it perhaps be filed on the bug tracker so it doesn't 
get lost in this list?

-~Chris


On 09/04/2017 03:23 PM, Mark Hills wrote:
> On Thu, 31 Aug 2017, Takashi Sakamoto wrote:
>
>> On Aug 29 2017 12:46, S. Christian Collins wrote:
>>> On 08/28/2017 10:33 PM, Takashi Sakamoto wrote:
>>>> Would you get output from below command line for your Gina 3G?
>>>>
>>>> $ amixer scontrols
>>> The output of "amixer -c 1 scontrols" is attached to this e-mail as
>>> "scontrols.txt".
>>>
>>>> And typically state data is stored into '/var/lib/alsa/asound.state' as a
>>>> default. For my information, could you disclose it if possible?
>>> Yes, it is also attached to this e-mail. The asound.state file was last
>>> modified on March 26th. I remember that I used to not get the error when
>>> using "alsactl store", so perhaps an update caused this issue to appear
>>> around that time?
>> $ alsactl -f ~/asound1.state store 1
>> (alsa-utils:alsactl/alsactl.c)
>> main()
>>    (alsa-utils:alsactl/state.c)
>> ->save_state()
>>    ->get_controls()
>>      ->get_control()
>>        snd_ctl_elem_info(info)
>>        count = snd_ctl_elem_info_get_count(info)
>>        for (i = 0; i < count; i++)
>>          snd_ctl_elem_value_get_integer(ctl, i)
>>
>> I guess that 'snd-echo3g.ko' returns value greater than 128 in a call graph of
>> 'snd_ctl_elem_info_get_count()', then a call of
>> 'snd_ctl_elem_value_get_integer()' hits an assertion in the function.
> This sounds familiar -- would you like to compare to my post earlier in
> the year (for Layla):
>
>    http://mailman.alsa-project.org/pipermail/alsa-devel/2017-March/119125.html
>
> In this post I made a misdiagnosis that it was related to my move to a
> 64-bit userland. When I found I could revert a patch it looks like it was
> coincidence.
>
>> A patch mentioned by Mark Hills (a commit 275353bb684e 'ALSA: echoaudio: purge
>> contradictions between dimension matrix members and total number of members')
>> is fairly valid in a logical design of ALSA control protocol/interface. In
>> detail, please refer to my post[1].
>>
>> Some of ALSA drivers for PCI cards produced by Echo Audio potentially have
>> problems which I mentioned in the post. They can cause buffer-over-run over
>> 'struct snd_ctl_elem_value.value' in user space. The drivers should be going
>> to fix.
>>
>> I wrote a small program to validate dimension information for your card[2].
>> Would you please execute it? Like:
>>
>> $ gcc -o ./test ./alsa-ctl-dimen-check.c
>> $ ./test /dev/snd/controlC[0-9]
> In case it's useful, I've also attached the output for my Layla 3G.
>
> This is with the patch reverted as that's the kernel currently in use.
> If it would be helpful for me to build another kernel, I can do that.
>
