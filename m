From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] ad1838/cs4231 -- fix MCE timeout upon
	initial load
Date: Mon, 10 Sep 2007 23:43:11 +0200
Message-ID: <46E5BA6F.9070408@gmail.com>
References: <46E58D01.9080809@gmail.com>
	<20070910234034.a052c957.krzysztof.h1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id AEDDC1038AF
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Sep 2007 23:50:10 +0200 (CEST)
In-Reply-To: <20070910234034.a052c957.krzysztof.h1@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 09/10/2007 11:40 PM, Krzysztof Helt wrote:

> On Mon, 10 Sep 2007 20:29:21 +0200
> Rene Herman <rene.herman@gmail.com> wrote:
>> Thanks to Krysztof Helt for pinpointing this problem.
>>
> 
> Please change it to Krzysztof Helt

Oh, very sorry.

>> diff --git a/sound/isa/cs423x/cs4231_lib.c b/sound/isa/cs423x/cs4231_lib.c
>> index 914d77b..9e8e0f1 100644
>> --- a/sound/isa/cs423x/cs4231_lib.c
>> +++ b/sound/isa/cs423x/cs4231_lib.c
>> @@ -346,16 +346,14 @@ void snd_cs4231_mce_down(struct snd_cs4231 *chip)
>>  	}
>>  	snd_cs4231_busy_wait(chip);
>>  
>> -	/* calibration process */
>> -
> 
> The snd_cs4231_busy_wait(chip) is not needed any more here.

I believe it is. I glanced over the CS4232 datasheet (note how cs4232 uses 
snd-cs4332-lib) and it adds a point 4 (see page 53):

* Wait until 80h NOT returned

I didn't read closely, so feel free to point out if I'm misinterpreting that.

Rene.
