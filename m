From: Ricardo Biehl <rbpoficial@gmail.com>
Subject: Re: Real-time audio over local network with good
	quality
Date: Sat, 9 Apr 2016 19:07:58 -0300
Message-ID: <CAAu8Fscu4fUSi8F7M=nkZvxQt5AtWOsyZ2D+GmYp8Nk_7pToHQ@mail.gmail.com>
References: <CAAu8FsdLJfSNau-OYcvja4F6rhFmu9skZvR0DeM38dA_wN+BMA@mail.gmail.com>
 <CAG5mAdwLs8n+a1rx1xEvP65y_EEaz02ekxK7mV=NDDUxHg6Ynw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D2352617BB
 for <alsa-devel@alsa-project.org>; Sun, 10 Apr 2016 00:07:59 +0200 (CEST)
Received: by mail-wm0-f50.google.com with SMTP id n3so60597800wmn.0
 for <alsa-devel@alsa-project.org>; Sat, 09 Apr 2016 15:07:59 -0700 (PDT)
In-Reply-To: <CAG5mAdwLs8n+a1rx1xEvP65y_EEaz02ekxK7mV=NDDUxHg6Ynw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2016-04-05 12:47 GMT-03:00, Caleb Crome <caleb@crome.org>:
> What software is running on the microphone?  If it's linux, you can use
> netjack, or perhaps pulseaudio too.  I'm not familiar with pulse though.
>

Yes, is Linux.
I'll look about netjack! Thank you :-)

Cheers!

> -Caleb
>
>
> On Thu, Mar 31, 2016 at 11:52 AM, Ricardo Biehl <rbpoficial@gmail.com>
> wrote:
>
>> Hello guys! I'm sorry if this mail is not part of the scope of this list
>> :-(
>>
>> I've come from the kernelnewbies mailing list with the same subject as
>> following ...
>>
>> I'm working on a project which aims to be a microphone system that
>> will work over local network <https://github.com/ricardobiehl/ipmic>.
>> So I've found many difficulties in ALSA library and Linux Network.
>> Basically, I need help to make my software get low latency and high
>> quality audio :-) .
>>
>> When I said "high quality audio" I'm referring to (1channel * 16bit
>> sample * 22050Hz) without noise. And "low latency" is about to 0.1
>> second or less.
>>
>> Any contribution with the project is welcome!
>>
>> Thank you a lot!
>>
>> --
>> Ricardo Biehl Pasquali
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>


-- 
Ricardo Biehl Pasquali
