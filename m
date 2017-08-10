From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 3/5] ASoC: codecs: msm8916-wcd-analog:
	add MBHC support
Date: Thu, 10 Aug 2017 11:02:34 +0100
Message-ID: <76eb6edf-1754-6679-6218-028b12dce49a@linaro.org>
References: <20170809164927.19663-1-srinivas.kandagatla@linaro.org>
 <20170809164927.19663-4-srinivas.kandagatla@linaro.org>
 <20170809211054.4owecfeoxxud5evh@workotop.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 3961E266EAF
 for <alsa-devel@alsa-project.org>; Thu, 10 Aug 2017 12:02:36 +0200 (CEST)
Received: by mail-wm0-f52.google.com with SMTP id f15so17929775wmg.1
 for <alsa-devel@alsa-project.org>; Thu, 10 Aug 2017 03:02:36 -0700 (PDT)
In-Reply-To: <20170809211054.4owecfeoxxud5evh@workotop.localdomain>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Damien Riegel <damien.riegel@savoirfairelinux.com>
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, linux-kernel@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Damien,
Thanks for testing.

On 09/08/17 22:10, Damien Riegel wrote:
> Hi Srinivas,
> 
> On Wed, Aug 09, 2017 at 06:49:25PM +0200, srinivas.kandagatla@linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> MBHC (MultiButton Headset Control) support is available in pm8921 in two
>> blocks, one to detect mechanical headset insertion and removal and other
>> block to support headset type detection and 5 button detection and othe
>> features like impedance calculation.
>>
>> This patch adds support to:
>> 1> Support to NC and NO type of headset Jacks.
>> 2> Mechanical insertion and detection of headset jack.
>> 3> Detect a 3 pole Headphone and a 4 pole Headset.
>> 4> Detect 5 buttons.
>>
>> Tested it on DB410c with Audio Mezz board with 4 pole and 3 pole
>> headset/headphones.
> 
> I have the same issue with this patchset, KEY_MEDIA is being reported
> when unplugging a headset. I added a few traces and what I observe is
Am unable to reproduce the same issue, I tried atleast 6 different mix 
of headset/headphones.
here is my evtest log:  http://paste.ubuntu.com/25282592/

Could you explain bit more about your setup, so that I can try to 
reproduce the same issue.

My setup is DB410c + Audio Mezz board 
https://www.arrow.com/en/products/audiomezz/seeed-technology-limited


> that the "button pressed" irq is fired when unplugging, but no "button
> released" irq follows. To get a "button released" irq, I need to either
> plug a headset, or plug-and-unplug headphones.
> 
> So basically, detection fails because we don't get the "button pressed"
> irq prior to the mechanical switch irq. Do you know what could explain
> the MBHC not firing the "button released" irq when unplugging headset?
> 
Can you also share output of evetest and /proc/interrupts so that i can 
see if the extra logic of masking btn0 is creating the issue, we can 
also try removing the btn0 accessory detect logic and see if we get 
correct button press/releases.

thanks,
srini


> 
> Thanks,
> 
