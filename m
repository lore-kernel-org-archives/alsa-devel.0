From: Manuel Naranjo <manuel@aircable.net>
Subject: Re: Possible regression on Sigmatel 9205
Date: Wed, 15 Oct 2008 12:02:50 -0300
Message-ID: <48F6061A.8050001@aircable.net>
References: <48F4AD76.8010409@aircable.net>	<s5hk5ca10o5.wl%tiwai@suse.de>	<a10be5a00810150636u2f465feey5e4050d69980d386@mail.gmail.com>	<48F5F527.7050802@embeddedalley.com>	<a10be5a00810150714p3c4ae907o33ad145d14d17f3@mail.gmail.com>	<s5h4p3e0woy.wl%tiwai@suse.de>	<48F5FCDC.1010509@aircable.net>
	<s5hzll6ylos.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by alsa0.perex.cz (Postfix) with ESMTP id AB42C103822
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Oct 2008 17:03:17 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id e27so1893220nfd.32
	for <alsa-devel@alsa-project.org>; Wed, 15 Oct 2008 08:02:59 -0700 (PDT)
In-Reply-To: <s5hzll6ylos.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Matthew Ranostay <mranostay@embeddedalley.com>
List-Id: alsa-devel@alsa-project.org

     

>>>> Sorry, ok I did that. With pulseaudio running calling to arecord
>>>> fails.
>>>>     
>>>>         
>>> Maybe a bug of pulse alsa-plugin I posted today?
>>>
>>>
>>> Takashi
>>>
>>>   
>>>       
>> I just thought it could be pulse. Where's the bug report? I would like 
>> to take a look, maybe I can help.
>>     
>
> http://mailman.alsa-project.org/pipermail/alsa-devel/2008-October/011425.html
>
>
> Takashi
>
>   

I'll check the patch and see if it makes a difference.

BTW how are the pin config information stored in structures like 
dell_9205_m42_pin_configs been filled? I'm comparing this values to the 
ones in dell .ini files and they aren't all the same. According to the 
inf file I should use version M_4_8 and not M_4_2.

Thanks,
Manuel
