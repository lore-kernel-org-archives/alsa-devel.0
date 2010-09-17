From: Tom Corner <tom.c.corner@gmail.com>
Subject: Re: cmipci CMI8738-MC6 - left channel no sound
Date: Fri, 17 Sep 2010 21:43:18 +0200
Message-ID: <4C93C4D6.7000404@gmail.com>
References: <4C89D660.4020705@gmail.com>
	<4C89D9E2.1070008@ladisch.de>	<4C89DCD5.6040806@gmail.com>
	<4C89DF45.5090100@ladisch.de> <4C90DB4C.2040603@gmail.com>
	<4C9204CD.6030400@ladisch.de> <4C920A43.50308@gmail.com>
	<4C920AE1.2050105@ladisch.de> <4C922859.1040709@gmail.com>
	<4C93129B.3020802@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 441F124529
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Sep 2010 21:43:21 +0200 (CEST)
Received: by bwz4 with SMTP id 4so3344291bwz.38
	for <alsa-devel@alsa-project.org>; Fri, 17 Sep 2010 12:43:20 -0700 (PDT)
In-Reply-To: <4C93129B.3020802@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

 I tried changing these settings, but the Left Speaker is still dead. 
The card has 5 analog jacks:

1. Mic
2. Line-In
3. Line Out 1 (Front) / Headphone Out
4. Line Out 2 (Rear)
5. Line Out 3 (Center/Sub)

Plus a Digital-In and a Digital-out.

I have my speakers connected to 3, 4 and 5.

I will retest the card in windows although it worked last time, but it
is a while since I have heard sound from the left speaker.

Regards,

Tom

On 09/17/10 09:02, Clemens Ladisch wrote:
> Tom Corner wrote:
>> Simple mixer control 'Line-In Mode',0
>>   Items: 'Line-In' 'Rear Output' 'Bass Output'
>>   Item0: 'Line-In'
> OK.
>
>> Simple mixer control 'Mic-In Mode',0
>>   Items: 'Mic-In' 'Center/LFE Output'
>>   Item0: 'Center/LFE Output'
> This should be Min-In (I guess your card doesn't have shared mic-in
> jack).
>
>> Simple mixer control 'Phone',0
>>   Mono: Playback 7 [100%] [on]
> I'd guess you don't need this.
>
>> Simple mixer control 'Four Channel Mode',0
>>   Mono: Playback [off]
> This might have some effect, but I don't know which setting should be
> the correct one.
>
>
> Regards,
> Clemens
