From: Luka Karinja <luka.karinja@gmail.com>
Subject: Re: [PATCH 18/19] ASoC: Intel: Atom: add support for
	RT5642
Date: Thu, 11 Feb 2016 11:12:51 +0100
Message-ID: <56BC5EA3.5020701@gmail.com>
References: <5679871B.1050200@gmail.com> <56798CFC.7040909@gmail.com>
 <567991B8.4060304@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
 by alsa0.perex.cz (Postfix) with ESMTP id BBBF526063A
 for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2016 11:12:56 +0100 (CET)
Received: by mail-wm0-f54.google.com with SMTP id g62so61905411wme.0
 for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2016 02:12:56 -0800 (PST)
In-Reply-To: <567991B8.4060304@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello

> >> The machine driver is not loaded when the BIOS uses the 10EC5642
>>> _HID. Add it to the white list of known _HIDs, codec_name is
>>> already taken care of by previous commit
>>>
>>> Tested on Asus T100TAF.
>>>
>>
>> I'm trying to get sound working on my T100TAF i did apply all the 19
>> patches
>> on top of broonie/sound and added UCM files to my system.
>> Does the TAF need different UCM file than the T100TA?
>
>
> The probe was tested but I am still fighting to get audio out. There 
> are additional patches needed to work-around a BIOS changes that fixes 
> the download issue shown in your log and also a change in the I2S 
> routing, but we can't figure out if there are any additional changes 
> needed. I suspect something is wrong with the i2S pin configuration 
> (gpio setup)
> Those patches and updated firmware have not been submitted so far, i'd 
> like to do so when it's actually working. This is on our to-do list, 
> along with MCLK support and jack detection. There are so many 
> variations of hardware that we are progressing slowly unfortunately.
>
Are there any updates on the TAF sound? I have been following your 
github, and saw there is a new TAF branch.
Is it already possible to get sound out of our devices?

Thanks

Luka
