From: Tom Corner <tom.c.corner@gmail.com>
Subject: Re: cmipci  CMI8738-MC6 - left channel no sound
Date: Thu, 16 Sep 2010 11:54:06 +0200
Message-ID: <4C91E93E.8080109@gmail.com>
References: <4C89D660.4020705@gmail.com>	<4C89D9E2.1070008@ladisch.de>	<4C89DCD5.6040806@gmail.com>	<4C89DF45.5090100@ladisch.de>
	<4C90DB4C.2040603@gmail.com> <i6qn5o$tmo$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id AC5E224434
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Sep 2010 11:54:11 +0200 (CEST)
Received: by bwz4 with SMTP id 4so1582382bwz.38
	for <alsa-devel@alsa-project.org>; Thu, 16 Sep 2010 02:54:11 -0700 (PDT)
In-Reply-To: <i6qn5o$tmo$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Colin Guthrie <gmane@colin.guthr.ie>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

 I am using kernel 2.6.35 with a gentoo distribution.  Is it possible
that this bug has been fixed since kernel 2.6.35?  Is it possible to try
the latest drivers?

Thanks

Tom


On 09/15/10 17:02, Colin Guthrie wrote:
> 'Twas brillig, and Thomas Corner at 15/09/10 15:42 did gyre and gimble:
>>   I've been going around and around on this.  The surround sound 5.1 is
>> playing fine except channel 0 (front-left) is playing on the woofer. The 
>> card is a Terratec Aureon fun - CMI8738-MC6. I have
>> gotten desperate and have tested this card in Windows and was able to
>> get it working right there. I have been using speaker-test to
>> to test the setup. I am using pulseaudio.
>>
>> This is the summary of my results with speaker-test:
>>
>> speaker-test -c 6 -D surround51 -t wav
>> speaker          output
>>   ----------------------
>>   front L         silence
>>   front R         front R
>>   center          center
>>   bass            mix of front L + bass
>>   surround L      surround L
>>   surround R      surround R
> Smells like something is messed up with the alsa driver. Someone in
> alsa-devel can probably help you best here. Could be a strange mixer
> setting but I doubt it.
>
>
>> I have removed pulseaudio again (recompiled all software with optional
>> pulseaudio support without pulseaudio support)  I should be outputting
>> directly to alsa and the driver now.
> That is massive overkill. I'd just stick with your distro's packages
> rather than recompiling everything and disabling PA support.
>
> The speaker test using the names surround* etc. do not use pulseaudio
> anyway.
>
>> Under pulseaudio speaker-test gives error messages when surround40 and
>> surround51 is specified.
> This will only be true if pulseaudio daemon is running and has the
> device open. Much easier to just run speaker-test as:
>
> pasuspender -- speaker-test -D surround51 ...
>
> than recompiling everything :)
>
> But ultimately it seems to be an alsa problem.
>
> All the best
>
> Col
>
>
>
>
