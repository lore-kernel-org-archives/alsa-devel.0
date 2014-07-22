From: Akshay Mishra <akshaymishra@gmail.com>
Subject: Re: Fwd: Overrun Errors - SAM9G
Date: Tue, 22 Jul 2014 11:50:11 +0530
Message-ID: <CABSY_ZvgmduDQJP5xwyKTkkaaB6oMUYCwTWiv+KprUeRBPo3rw@mail.gmail.com>
References: <CABSY_ZsjSaZQA+KadBWnzR-9=YQby-Fnb9ZpBGZpXHtVsZZXMw@mail.gmail.com>
 <CABSY_Zsh44D19KtDYkc6ozSsxKpTk+cQJiy4rEGKqWgbv_a=tQ@mail.gmail.com>
 <53CDCC2C.1010400@atmel.com>
 <CABSY_ZuyQU0LX3Qb7sxfH+Xm-Za_syijnDOYz7sBoF9-g3_5+Q@mail.gmail.com>
 <53CDFE65.9090908@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f42.google.com (mail-qa0-f42.google.com
 [209.85.216.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 142D62654D4
 for <alsa-devel@alsa-project.org>; Tue, 22 Jul 2014 08:20:31 +0200 (CEST)
Received: by mail-qa0-f42.google.com with SMTP id j15so6255593qaq.1
 for <alsa-devel@alsa-project.org>; Mon, 21 Jul 2014 23:20:31 -0700 (PDT)
In-Reply-To: <53CDFE65.9090908@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bo Shen <voice.shen@atmel.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 22 July 2014 11:32, Bo Shen <voice.shen@atmel.com> wrote:

> Hi Akshay,
>
>
> On 07/22/2014 10:38 AM, Akshay Mishra wrote:
>
>> On 22 July 2014 07:57, Bo Shen <voice.shen@atmel.com
>> <mailto:voice.shen@atmel.com>> wrote:
>>
>>     Hi Akshay,
>>
>>
>>     On 07/17/2014 08:54 PM, Akshay Mishra wrote:
>>
>>         Hello,
>>               I am trying a simple alsa capture on the Atmel ARM9
>>         (SAM9G45). While
>>         only capture runs fine, putting any os call on the same thread
>>         gives XRUNs.
>>
>>         Even a innocent usleep(1) seems to lead to regular XRUNs.
>>         Eventually I want
>>         to dump this capture on the serial port and I am not able to get
>>         past this.
>>
>>
>>     Do you test with alsa utils. If yes, where you add the usleep(1) in
>>     code?
>>
>>
>>         I have tried on AT91 linux as well as on kernel 3.10.10-rt7 with
>>         no success.
>>
>>
>>     I try both kernel and don't reproduce this issue with alsa utils.
>>
>>
>> Bo, I put usleep(x) after the snd_pcm_readi. I also tried with this code
>> (attached).
>> usleep at Line 88 gives the error.
>>
>> Another observation is, disabling HRTimer the -EPIPE error was not seen
>> but I need further tests to be sure about this behaviour.
>>
>
> In contrast, I enable HRTimer, the -EPIPE error is gone.
> I briefly go through the code: usleep --> .. --> nanosleep (define in
> <kernel/hrtime.c>)
>
>
do you mean, disabling HRTimer you had -EPIPE ? I am positive on disabling
the HRTimer, CPU Freeze which made the -EPIPE vanish and the moment I
enable it, I again get -EPIPE. :-(


> Actually, I can not understand why you add a usleep(1) in this piece of
> code. :(
>
>

Bo, as I mentioned earlier -- the usleep is only a placeholder. Any system
call (like write to serial port) also gives same result but since I cannot
ask you to do serial transmit - you may not have it setup I asked you to do
a usleep since it gives me the same result.

I have requested for a SAM9G45-EK from the local Atmel office and once I
get it I shall inform you further on this on the same platform.

-Akshay



>
>  The code is from here (http://www.linuxjournal.com/node/6735/print).
>>
>>
>>         Please advice,
>>         Akshay
>>
>>
> Best Regards,
> Bo Shen
>
>
