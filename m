From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH] BAT: Change maximum number of channels
	from 2 to 64
Date: Fri, 23 Oct 2015 12:06:14 -0700
Message-ID: <CAG5mAdx0GBc=uVSANVCyNGk5jYQOSotp6b5axw7ahUELTtR0Mg@mail.gmail.com>
References: <CAG5mAdx9iZC=JPKdShjqayaU3pEOa67Wb58CNyc-YNdJE2W1SA@mail.gmail.com>
 <s5hd1w6w4z4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
 [209.85.212.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FA51264ED5
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 21:06:34 +0200 (CEST)
Received: by wijp11 with SMTP id p11so90424119wij.0
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 12:06:34 -0700 (PDT)
In-Reply-To: <s5hd1w6w4z4.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Lu,
 Han" <han.lu@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Gautier,
 Bernard" <bernard.gautier@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 22, 2015 at 10:04 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Fri, 23 Oct 2015 00:05:24 +0200,
> Caleb Crome wrote:
>>
>> commit 23521f2e04df7ae39ccdbc7b4a9aa59220b56495
>> Author: Caleb Crome <ccrome@gmail.com>
>> Date:   Tue Oct 20 20:57:57 2015 +0000
>>
>>     Change maximum number of channels from 2 to 64.
>>
>>     Added a round-robbin frequency assignment from the command line so that
>>     if you specify -F 100:200:250 on the command line, then all subsequent
>>     channels will get assigned frequencies like this first set.  So by
>>     specifying
>>
>>        -c 6 -F 100:200:250
>>
>>     the resulting frequencies for the 6 channels will be the same as if you
>>     specified
>>
>>        -c 6 -F 100:200:250:100:200:250
>
> Could you reformat the patch properly as applicable via git-am?
> Use git-format-patch or any other command.  Also, don't forget to give
> your signed-off-by tag.
>


Done!  I knew there must be a better way than copy-paste of git diff
outputs. :-)

I had to send twice because the first commit I forgot to add my
sign-off key.  Sorry.

-Caleb


>>
>> diff --git a/bat/bat.c b/bat/bat.c
>> index 56cfaf6..57c9db8 100644
>> --- a/bat/bat.c
>> +++ b/bat/bat.c
>> @@ -72,16 +72,31 @@ err_exit:
>>
>>  static void get_sine_frequencies(struct bat *bat, char *freq)
>>  {
>> -    char *tmp1;
>
> The indentation looks wrong.
>
>
> thanks,
>
> Takashi
