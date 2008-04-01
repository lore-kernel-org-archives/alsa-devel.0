From: Tyson Whitehead <twhitehe@uwo.ca>
Subject: [Fwd: Re: [regression] 2.6.25-rc4 snd-es18xx broken on
 Alpha]
Date: Tue, 01 Apr 2008 17:21:33 -0400
Message-ID: <47F2A75D.9060809@uwo.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_NJKVY6D4OCiISLpcnWEq6w)"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from uwo.ca (v320-147-lb.its.uwo.ca [129.100.74.147])
	by alsa0.perex.cz (Postfix) with ESMTP id BD8D224632
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Apr 2008 23:20:56 +0200 (CEST)
Received: from zeppo.mail.uwo.pri (salk.mail.uwo.pri [172.29.32.41])
	by zeppo.mail.uwo.pri
	(Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007;
	32bit)) with ESMTP id <0JYO00EIC0MVBB00@zeppo.mail.uwo.pri> for
	alsa-devel@alsa-project.org; Tue, 01 Apr 2008 17:20:55 -0400 (EDT)
Received: from [192.168.1.103] ([129.100.171.21])
	by zeppo.mail.uwo.pri (Sun Java(tm) System Messaging Server 6.3-3.01
	(built Jul 12 2007;
	32bit)) with ESMTPSA id <0JYO00EMJ0MVAY30@zeppo.mail.uwo.pri> for
	alsa-devel@alsa-project.org; Tue, 01 Apr 2008 17:20:55 -0400 (EDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: rene.herman@gmail.com, Michael Cree <mcree@orcon.net.nz>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-kernel@vger.kernel.org, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--Boundary_(ID_NJKVY6D4OCiISLpcnWEq6w)
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT

Sorry.  Bob was just saying this could be an important observation, but 
it didn't get to everyone as the CC list got shortened.  Cheers!  -Tyson


--Boundary_(ID_NJKVY6D4OCiISLpcnWEq6w)
Content-type: message/rfc822;
 name="Re: [alsa-devel] [regression] 2.6.25-rc4 snd-es18xx broken on Alpha.eml"
Content-disposition: inline;
 filename*0="Re: [alsa-devel] [regression] 2.6.25-rc4 snd-es18xx broken o";
 filename*1="n Alpha.eml"

Date: Tue, 01 Apr 2008 15:23:58 -0400
From: Tyson Whitehead <twhitehe@uwo.ca>
Subject: Re: [alsa-devel] [regression] 2.6.25-rc4 snd-es18xx broken on Alpha
In-reply-to: <20080329063523.979EEDBA2@gherkin.frus.com>
To: Bob Tracy <rct@frus.com>
Cc: Takashi Iwai <tiwai@suse.de>
Message-id: <47F28BCE.9090108@uwo.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
References: <20080329063523.979EEDBA2@gherkin.frus.com>
User-Agent: Mozilla-Thunderbird 2.0.0.9 (X11/20080109)

Bob Tracy wrote:
> Takashi Iwai wrote:
>> I vaguely remember about the patch...  The patch below was on my local
>> tree but never pushed because of lack of testing.  Does it work for
>> you?
>>
>> ---
>>
>> diff -r 82e6201fc907 sound/isa/es18xx.c
>> --- a/sound/isa/es18xx.c	Mon Mar 17 14:36:24 2008 +0100
>> +++ b/sound/isa/es18xx.c	Mon Mar 17 17:32:59 2008 +0100
>> @@ -765,9 +765,10 @@ static irqreturn_t snd_es18xx_interrupt(
>>  		/* Read Interrupt status */
>>  		status = snd_es18xx_mixer_read(chip, 0x7f) >> 4;
>>  	}
>> -#if 0
>> -	else {
>> -		status = 0;
>> +
>> +#ifdef CONFIG_ALPHA
>> +	if (!(status & (AUDIO1_IRQ | AUDIO2_IRQ))) {
>> +		/* status = 0; */
>>  		if (inb(chip->port + 0x0C) & 0x01)
>>  			status |= AUDIO1_IRQ;
>>  		if (snd_es18xx_mixer_read(chip, 0x7A) & 0x80)
>> @@ -777,7 +778,6 @@ static irqreturn_t snd_es18xx_interrupt(
>>  			status |= HWV_IRQ;
>>  	}
>>  #endif
>> -
>>  	/* Audio 1 & Audio 2 */
>>          if (status & AUDIO2_IRQ) {
>>                  if (chip->active & DAC2)
>> --
> 
> The above patch doesn't make any difference for me as far as how the
> ES1888 works.  I get the same broken behavior as previously described.

I wonder if the difference between Bob and I (i.e., that I can get sound 
working with patching while he cannot) might be that all along I've been 
using CONFIG_ALPHA_GENERIC, while he has (possibly -- he will have to 
confirm this) been using CONFIG_ALPHA_MIATA.

As I mentioned in the email I just sent out, I just finished discovering 
that if I compile with CONFIG_ALPHA_MIATA, I can't get sound to work no 
matter what I do (patched or unpatched es18xx or sb8).

When I compile with CONFIG_ALPHA_GENERIC I can get sound working (modulo 
this new "Bad page state in process 'mpg321'" thing that started 
sometime after 2.6.14) with either the patched es18xx or standard sb8.

Cheers!  -Tyson


--Boundary_(ID_NJKVY6D4OCiISLpcnWEq6w)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary_(ID_NJKVY6D4OCiISLpcnWEq6w)--
