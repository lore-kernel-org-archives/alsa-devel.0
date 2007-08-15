From: Nicola Fagnani <nicfagn@iol.it>
Subject: Re: Recent code changes for HD-audio on HG repo
Date: Wed, 15 Aug 2007 21:40:33 +0200
Message-ID: <B1DD4D6F-7455-40E2-B253-FB7C6010DAF1@iol.it>
References: <JMS18G$D6593E93F61285FE8A75013EC0062E59@libero.it>
	<s5hlkcdjeg9.wl%tiwai@suse.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out2.libero.it (smtp-out2.libero.it [212.52.84.42])
	by alsa0.perex.cz (Postfix) with ESMTP id 027C324388
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Aug 2007 21:40:35 +0200 (CEST)
Received: from localhost (172.31.0.50) by smtp-out2.libero.it (7.3.120)
	id 4688F31B03D9BCA3 for alsa-devel@alsa-project.org;
	Wed, 15 Aug 2007 21:40:34 +0200
Received: from smtp-out1.libero.it ([172.31.0.37])
	by localhost (asav-out9.libero.it [192.168.32.37]) (amavisd-new,
	port 10024)
	with ESMTP id o1lQdtFbtZHg for <alsa-devel@alsa-project.org>;
	Wed, 15 Aug 2007 21:40:34 +0200 (CEST)
Received: from MailRelay10.libero.it (192.168.32.119) by smtp-out1.libero.it
	(7.3.120) id 46A71E790116DA9D for alsa-devel@alsa-project.org;
	Wed, 15 Aug 2007 21:40:34 +0200
In-Reply-To: <s5hlkcdjeg9.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Il giorno 15/ago/07, alle ore 12:10, Takashi Iwai ha scritto:

> At Tue, 14 Aug 2007 20:41:04 +0200,
> nicfagn wrote:
>>
>> I tested the alsa-driver-hg20070814 snapshot on my system and  
>> after the power save timeout (10 secs) the sound stops working.
>> I am on an iMac 24''(2006) with hda and realtek ALC885 and Ubuntu  
>> Gutsy with a 2.6.22-9 kernel.
>> If I can help in some way, let me know.
>
> Try hg20070815.  Some bugs were fixed yesterday :)
>
>
> Takashi

Sorry, but hg20070815 still not working. After 10 seconds the sound  
goes mute.
hg20070812 is the last snapshot where the sound worked as usual, but  
that didn't include the fix for the test at the entry of the  
azx_stop_chip() function in hda_intel.c, so the code in that function  
was always skipped and the azx_init_chip() function was called only  
once.
What these functions do is clear enough from their names, but the low  
level details are a bit too much in depth for me. :-)
Is there anything I could check or test to help?

Thanks 
