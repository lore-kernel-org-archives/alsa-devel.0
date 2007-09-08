From: Chris Pemberton <cjpembo@gmail.com>
Subject: Re: Lenovo 3000 N100 Laptop quirk
Date: Sat, 08 Sep 2007 01:06:25 -0500
Message-ID: <46E23BE1.3030708@gmail.com>
References: <46E0C0F1.7020008@gmail.com> <s5hmyvyhwb5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 61B631038D8
	for <alsa-devel@alsa-project.org>;
	Sat,  8 Sep 2007 03:08:12 +0200 (CEST)
Received: by wx-out-0506.google.com with SMTP id t11so616100wxc
	for <alsa-devel@alsa-project.org>; Fri, 07 Sep 2007 18:08:10 -0700 (PDT)
In-Reply-To: <s5hmyvyhwb5.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Thu, 06 Sep 2007 22:09:37 -0500,
> Chris Pemberton wrote:
>   
>> To enable sound on a Lenovo 3000 N100 laptop...
>>
>> In patch_realtek.c (near line # 10882):
>>
>> Change:
>>
>> SND_PCI_QUIRK(0x17aa, 0x2066, "Lenovo", ALC861VD_LENOVO),
>>
>> to:
>>
>> SND_PCI_QUIRK(0x17aa, 0x2066, "Lenovo 3000 N100", ALC861VD_3ST),
>>     
>
> Hm, that's bad.  ALC861VD_LENOVO is exactly for your laptop model, so
> it has to be fixed.
>
> What is exactly a problem?  Could you figure out which codec setting
> may trigger the problem by comparing codec#* file between these
> models?
>
> And, above all, which ALSA version are you using and how did you test
> it?  The latest version, and the output from both HP and spekaer?
>
>
> thanks,
>
> Takashi
>
>   
I used the most resent alsa-driver snapshot, but I did the modification 
I detailed above.  This has been my method of getting alsa to work for a 
few months now.

My ALSA information, based on yesterday's snapshot and my modification, 
is located at http://pastebin.ca/686568

I will get those codecs that you are asking for this weekend:  one with 
my modification and the other with whatever the latest snapshot has by 
default.

Let me know what else you need.

Thanks,

Chris
