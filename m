From: Brad Figg <brad.figg@canonical.com>
Subject: Re: [PATCH 1/1] Daily snapshot not building on 2.6.32
Date: Thu, 24 Jun 2010 11:07:27 -0700
Message-ID: <4C239EDF.1040006@canonical.com>
References: <4C22545C.2060101@canonical.com>	<s5h8w65djy1.wl%tiwai@suse.de>	<4C237223.6060606@canonical.com>	<s5hbpb079ua.wl%tiwai@suse.de>	<4C237969.2090109@canonical.com>	<s5h1vbw78ba.wl%tiwai@suse.de>	<4C237BC4.6020304@canonical.com>
	<s5hwrto5tie.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 3819D2443A
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jun 2010 20:07:45 +0200 (CEST)
In-Reply-To: <s5hwrto5tie.wl%tiwai@suse.de>
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

On 06/24/2010 08:40 AM, Takashi Iwai wrote:
> At Thu, 24 Jun 2010 08:37:40 -0700,
> Brad Figg wrote:
>>
>> On 06/24/2010 08:35 AM, Takashi Iwai wrote:
>>> At Thu, 24 Jun 2010 08:27:37 -0700,
>>> Brad Figg wrote:
>>>>
>>>> On 06/24/2010 08:02 AM, Takashi Iwai wrote:
>>>>> At Thu, 24 Jun 2010 07:56:35 -0700,
>>>>> Brad Figg wrote:
>>>>>>
>>>>>> On 06/23/2010 11:27 PM, Takashi Iwai wrote:
>>>>>>> At Wed, 23 Jun 2010 11:37:16 -0700,
>>>>>>> Brad Figg wrote:
>>>>>>>>
>>>>>>>> I've had to apply the following patch to successfully build
>>>>>>>> the daily snapshot on 2.6.32. Without this patch I get:
>>>>>>>
>>>>>>> Which tarball?  The latest one works fine for me.
>>>>>>>
>>>>>>>
>>>>>>> Takashi
>>>>>>
>>>>>> Today's snapshot is giving me the exact same error.
>>>>>
>>>>> Did you get from the URL below, right?
>>>>>
>>>>>      ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa=
-driver-snapshot.tar.gz
>>>>>
>>>>> Then check config.log whether usb_alloc_coherent() check worked.
>>>>>
>>>>>
>>>>> Takashi
>>>>>
>>>>
>>>> I'm pulling the snapshot from the correct location. However:
>>>>         checking usb_alloc_coherent... no
>>>
>>> That's correct.  Then it must have
>>> 	#undef CONFIG_SND_HAVE_USB_ALLOC_COHERENT
>>> in include/config.h, and incldue/adriver.h should define a wrapper for
>>> the function.  Please check it.
>>>
>>>
>>> Takashi
>>
>> include/config.h:
>>
>> /* #undef CONFIG_SND_HAVE_USB_ALLOC_COHERENT */
>>
>>
>>
>> include/adriver.h:
>>
>> #ifndef CONFIG_SND_HAVE_USB_ALLOC_COHERENT
>> #define usb_alloc_coherent      usb_buffer_alloc
>> #define usb_free_coherent       usb_buffer_free
>> #endif
>
> Check whether the code patch there reaches while compiling ua101.c.
>
>
> Takashi

And, by the way, I'm getting this error when trying to build today's snapsh=
ot
on 2.6.35.

   CC [M]  /home/work/alsa/alsa-driver/acore/pcm_native.o
/home/work/alsa/alsa-driver/acore/pcm_native.c: In function =91snd_pcm_hw_p=
arams=92:
/home/work/alsa/alsa-driver/acore/pcm_native.c:468: error: implicit declara=
tion of function =91pm_qos_remove_requirement=92
/home/work/alsa/alsa-driver/acore/pcm_native.c:471: error: implicit declara=
tion of function =91pm_qos_add_requirement=92
make[3]: *** [/home/work/alsa/alsa-driver/acore/pcm_native.o] Error 1
make[2]: *** [/home/work/alsa/alsa-driver/acore] Error 2
make[1]: *** [_module_/home/work/alsa/alsa-driver] Error 2

Which I've not been able to figure out any work around after an hour or
more of working on it.

Brad
-- =

Brad Figg brad.figg@canonical.com http://www.canonical.com
