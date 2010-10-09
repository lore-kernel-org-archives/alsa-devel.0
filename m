From: Dan Carpenter <error27@gmail.com>
Subject: Re: bug report: aloop: potential signedness bug
	in	loopback_prepare()
Date: Sat, 9 Oct 2010 16:58:46 +0200
Message-ID: <20101009145845.GS11681@bicker>
References: <20101009114218.GQ11681@bicker>
	<alpine.LNX.2.00.1010091413020.17757@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C4B02450F
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Oct 2010 16:59:03 +0200 (CEST)
Received: by wwb28 with SMTP id 28so1799229wwb.20
	for <alsa-devel@alsa-project.org>; Sat, 09 Oct 2010 07:59:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1010091413020.17757@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 09, 2010 at 02:14:30PM +0200, Jaroslav Kysela wrote:
> On Sat, 9 Oct 2010, Dan Carpenter wrote:
>
>> Hi Jaroslav,
>>
>> sound/drivers/aloop.c +287 loopback_prepare(10)
>> 	warn: bogus compare against zero: 'bps'
>>   282          unsigned int bps, salign;
>>   283
>>   284          salign = (snd_pcm_format_width(runtime->format) *
>>   285							runtime->channels) / 8;
>>   286          bps = salign * runtime->rate;
>>   287          if (bps <= 0 || salign <= 0)
>>                    ^^^^^^^^^^^^^^^^^^^^^^^
>>
>>
>> 	Both "bps" and "salign" are unsigned and are never less than
>> 	zero.  Should this just be checking for == 0?  Or was the check
>> 	supposed to catch integer overflows?
>
> The condition works for both signed and unsigned values. That was only  
> reason why I did not write '==' there.
>
> 					Jaroslav
>

What I mean is that the less than zero part is never true.  For example,
the following test program will print "more" instead of "less".

regards,
dan carpenter

#include <stdio.h>

int main(int argc, char **argv)
{
	unsigned int x = -3;

	if (x <= 0)
		printf("less\n");
	else
		printf("more\n");

	return 0;
}
