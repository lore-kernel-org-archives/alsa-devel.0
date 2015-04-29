From: Gabriele Martino <g.martino@gmx.com>
Subject: Re: Intel HDA / ca0132: support for Alienware 15
 Creative Sound Core3D-EX
Date: Thu, 30 Apr 2015 01:40:30 +0200
Message-ID: <55416BEE.5090003@gmx.com>
References: <553AE4CF.3070805@gmx.com> <s5hh9s2lyz0.wl-tiwai@suse.de>
 <553E7B34.2080501@gmx.com> <s5h4mo14d72.wl-tiwai@suse.de>
 <553EB55D.4060701@gmx.com> <s5hlhhc3hiy.wl-tiwai@suse.de>
 <55400DF4.2080309@gmx.com> <s5hpp6nf41g.wl-tiwai@suse.de>
 <5540FBFF.6020904@gmx.com> <s5h8uda93pf.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 58B072606E8
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 01:40:03 +0200 (CEST)
Received: from [192.168.69.6] ([79.6.218.1]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M20Jj-1Z7jdR39qd-00u3I4 for
 <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 01:40:03 +0200
In-Reply-To: <s5h8uda93pf.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 29/04/2015 20:42, Takashi Iwai wrote:
> At Wed, 29 Apr 2015 17:42:55 +0200,
> Gabriele Martino wrote:
>> On 29/04/2015 15:38, Takashi Iwai wrote:
>>> At Wed, 29 Apr 2015 00:47:16 +0200,
>>> Gabriele Martino wrote:
>>>> Thank you for your explanation.
>>>> I managed to fix the pin address, but as I told before the jack
>>>> detection is totally messed up.
>>>> "hdajacksensetest" fails with:
>>>> Ioctl call failed with error 16
>>> The error message looks irrelevant with the patch itself.
>>> Did you build with proper kernel configs?
>>> CONFIG_SND_HDA_HWDEP=y
>>> CONFIG_SND_HDA_RECONFIG=y
>>> CONFIG_SND_HDA_PATCH_LOADER=y
>> It should be ok:
>>
>> $ grep CONFIG_SND_HDA_ /usr/src/linux/.config | grep -v '^#'
>> CONFIG_SND_HDA_INTEL=m
>> CONFIG_SND_HDA_DSP_LOADER=y
>> CONFIG_SND_HDA_PREALLOC_SIZE=2048
>> CONFIG_SND_HDA_HWDEP=y
>> CONFIG_SND_HDA_RECONFIG=y
>> CONFIG_SND_HDA_INPUT_JACK=y
>> CONFIG_SND_HDA_PATCH_LOADER=y
>> CONFIG_SND_HDA_CODEC_HDMI=m
>> CONFIG_SND_HDA_I915=y
>> CONFIG_SND_HDA_CODEC_CA0132=m
>> CONFIG_SND_HDA_CODEC_CA0132_DSP=y
>> CONFIG_SND_HDA_GENERIC=m
>> CONFIG_SND_HDA_POWER_SAVE_DEFAULT=60
> OK, then it's something else.  Errno 16 is EBUSY, so something else
> must be accessing the same device (e.g. hwdep) and blocking the
> operation.
>
> Are you sure that you never see this error when a kernel is without
> the patch?
It was an error on my part, my apologies.
I did a full kernel clean and rebuild, and the error 16 went away.
But the jack detection is still broken.

hdajacksensetest -c 1 -a
Pin 0x0b (Internal Speaker): present = Yes
Pin 0x0c (Not connected): present = No
Pin 0x0d (Not connected): present = No
Pin 0x0e (Not connected): present = No
Pin 0x0f (Not connected): present = Yes
Pin 0x10 (Not connected): present = No
Pin 0x11 (Black Line In, Left side): present = No
Pin 0x12 (Internal Mic, Mobile-In): present = No
Pin 0x13 (Not connected): present = No
Pin 0x18 (Not connected): present = No

Pin 0x0f is still reported as not connected, but correctly detects the
jack if plugged.
If I turn off and on the "HP/Speaker Auto Detect" in alsamixer while
"HP/Speaker" is off, the correct output is detected.
If "HP/Speaker" is on, the behaviour is inconsistent.

Is there a configuration file? Where can I find the metadata "Black Line
In, Left side"?
I don't know if it is related, but pavucontrol detects only the
"speakers" port.
On my previous laptop (with Creative Recon 3Di, another ca0132 card) I
could choose between "speakers and "headphones".

Regards,
Gabriele
