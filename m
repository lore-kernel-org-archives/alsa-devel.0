From: Kailang <kailang@realtek.com>
Subject: Re: Remove depop delay for suspend and resume
Date: Fri, 29 Nov 2013 15:08:25 +0800
Message-ID: <AC74BF9D54F2441085B7DF5480D68E29@realtek.com.tw>
References: <F59E396CBAC34485AD04AEDF69643CB9@realtek.com.tw>
 <s5hk3frg0ck.wl%tiwai@suse.de>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 40A962602F3
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 08:08:11 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I know your concerm.
Thanks.

Hi Mengdong,

Could you only remove it on you test image?

Thanks.
Kailang.

> At Fri, 29 Nov 2013 10:48:20 +0800,
> Kailang wrote:
>> 
>> Hi Takashi,
>> 
>> Intel test alc262.
>> They find the suspend and resume time were > 50ms.
>> So, I delete the delay for alc_eapd_shutup and alc_resume.
>> If we want to have depop functions, we will follow like alc283.
> 
> Which delay value to take is pretty specific to machine.  Removing
> delay will likely cause problem on other machines.
> 
> So, if we'd remove delays, do it only for tested machines, not do
> blindly to all machines using the same codec chips.  The pop noise
> isn't only determined by a codec chip but rather influenced by the
> whole hardware analog design.
> 
> 
> thanks,
> 
> Takashi
> 
> ------Please consider the environment before printing this e-mail.
