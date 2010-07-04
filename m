From: Florian Scholz <florian90@gmail.com>
Subject: Re: ESI DuaFire Vendor Information
Date: Sun, 4 Jul 2010 12:20:13 +0200
Message-ID: <AANLkTimP6gB0soXH9R7gBohFiG0DUClc6lgzCOtFnt4N@mail.gmail.com>
References: <AANLkTimFQAkrDUrqFixX3zZuY3z69p4Q0jxnfFrN-cey@mail.gmail.com>
	<4C304E3F.7010709@joow.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F9DD1037F5
	for <alsa-devel@alsa-project.org>;
	Sun,  4 Jul 2010 12:20:14 +0200 (CEST)
Received: by bwz4 with SMTP id 4so2431818bwz.38
	for <alsa-devel@alsa-project.org>; Sun, 04 Jul 2010 03:20:14 -0700 (PDT)
In-Reply-To: <4C304E3F.7010709@joow.be>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pieter Palmers <pieterp@joow.be>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I tried it. FFADO can't read the info registers. Also the default
BEBOB driver can't find the streams, so it isn't supported. This is
the reason why I believe that I have to write a driver for it to get
it working. It's hard to find a soundcard in this price range with an
integrated phono amplifer and furthermore a Hi-Z Input :)



2010/7/4, Pieter Palmers <pieterp@joow.be>:
> Have you tried running it with FFADO? There is a good chance that it
> will work.
>
> Regards,
>
> Pieter
>
> On 07/02/2010 05:11 PM, Florian Scholz wrote:
>> Hi
>>
>> I like to implement a driver for the ESI DuaFire Interface and need
>> the information from ESI.
>>
>> Andreas Preuss from ESI wrote me (translated):
>>
>> thanks you for your message. every information that you need for the
>> development of a firewire audio driver are public. the information are
>> accessable for the alsa-project and maybe the ffado project.
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>
>
