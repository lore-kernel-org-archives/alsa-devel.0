From: jimqu <jimqu-5C7GfCeVMHo@public.gmane.org>
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiBbYWxzYS1kZXZlbF0g562U5aSNOiBb?=
 =?UTF-8?Q?PATCH]_vgaswitchroo:_set_audio_client_id_according_to_bound_gpu_c?=
 =?UTF-8?Q?lient_id?=
Date: Tue, 10 Jul 2018 17:13:27 +0800
Message-ID: <a37f08e7-734e-977c-597f-46d5c3ec34bc@amd.com>
References: <20180629080634.GA7357@wunner.de>
 <DM3PR12MB08737DC9FB94BB6F3AEF5634994E0@DM3PR12MB0873.namprd12.prod.outlook.com>
 <20180629092138.GA11849@wunner.de>
 <DM3PR12MB08732DAAAA57739DCE431D66994E0@DM3PR12MB0873.namprd12.prod.outlook.com>
 <20180629111108.GA11609@wunner.de>
 <DM3PR12MB0873FEC702770190057B49F799440@DM3PR12MB0873.namprd12.prod.outlook.com>
 <20180709092759.GA3649@wunner.de>
 <DM3PR12MB087309CBC2CD3A934327EBCE99440@DM3PR12MB0873.namprd12.prod.outlook.com>
 <CADnq5_OpZz=AgNomX7+5BzeN77CRZT7mXDT7kn620TE-OjqS0w@mail.gmail.com>
 <s5hr2kco3gp.wl-tiwai@suse.de> <20180709155643.GE3008@phenom.ffwll.local>
 <s5hpnzwcsf7.wl-tiwai@suse.de>
 <DM3PR12MB0873E9DD8B7448CB8A6829DA99440@DM3PR12MB0873.namprd12.prod.outlook.com>
 <s5hr2kbr03k.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0344648761=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <s5hr2kbr03k.wl-tiwai-l3A5Bk7waGM@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, "Qu, Jim" <Jim.Qu-5C7GfCeVMHo@public.gmane.org>
Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--===============0344648761==
Content-Type: multipart/alternative;
 boundary="------------A379C6F358FA36B8D457551F"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------A379C6F358FA36B8D457551F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2018年07月10日 16:01, Takashi Iwai wrote:
> On Tue, 10 Jul 2018 09:44:42 +0200,
> Qu, Jim wrote:
>> Hi Takashi,
>>
>> I am not expert in audio driver, so I just update some test result, please help triage the issue.
>>
>> With audio runtime pm:
> What does this mean?  Is it the stock 4.17.x (or 4.18-rc)?
> Please clarify your test environment at first: which kernel, which
> hardware setup.
>
This is v4.15 which backport Lukas' patches and also one bug fix 
https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/?id=57cb54e53bdd.
The platform is AMDAPU(with audio) + AMD dGPU , it is a hybird GFX 
platform. In generic, dGPU will always be suspended.
>> 1. ubuntu audio setting use pactl to query audio card/output sink. Attachment is pactl output with audio runtime pm.
>> 2. cat /proc/asound/card0/eld* can get nothing.
>>
>> Without audio runtime pm:
>> 1. pactl can get available audio output/sink
>> 2. can get eld info from eld#0.1
>>
>> IMO, the issue should be:
>>
>> Current operations like HDMI hotplug in/out, pactl command, they do
>> not access audio HW, so the audio could not resume back at this
>> period.
> Sorry, not understood.  Why they don't access the audio hardware?
This is my guess, since I do not get azx_runtime_resume() print info 
which I added. it maybe access HW during this period, but do not trigger 
audio resume progress.
<https://elixir.bootlin.com/linux/v4.18-rc3/ident/azx_runtime_resume>
>> Therefore, upper software could not get HDMI ELD info, can select a available card/output sink.
>> I am also confuse that if there is no ELD info, how driver to steam audio device to wake up itself? It's sort of a chicken-or-egg question.
> As long as it's i915 and HD-audio, the hotplug and ELD info transfer
> doesn't trigger the runtime PM since it's done via the direct
> callback.  And ELD value is cached in HD-audio side.
Yeah, I have reviewed these code, it constructs ELD after reading EDID, 
and write them into HW buffer when set display mode.
> The exception is that if the notification is done during the PM
> operation.  But, the connection and ELD query is performed at the end
> of codec resume, hence it'll be covered there.
>
> So in theory, ELD information should be passed from the GPU to
> HD-audio no matter whether runtime PM is enabled or not.
>
>
> BTW, please stop top-posting.  It makes the thread readability awfully
> worse.
>
Sorry, I justed used outlook client.
> thanks,
>
> Takashi
>
>> Thanks
>> JimQu
>>
>> ________________________________________
>> 发件人: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
>> 发送时间: 2018年7月10日 1:09
>> 收件人: Qu, Jim
>> 抄送: Daniel Vetter; Alex Deucher; alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander
>> 主题: Re: 答复: [alsa-devel]        答复: [PATCH] vgaswitchroo: set audio client id according to bound gpu client id
>>
>> On Mon, 09 Jul 2018 18:05:09 +0200,
>> Qu, Jim wrote:
>>> Hi Takashi,
>>>
>>> Not intel, but it is AMD APU+ AMD GFX, the APU has a local HDMI port for extension. And dGPU is only for offloading render via PRIME.
>>>
>>> Originally, the HDA driver before v4.17, there is a bug, that all the audio is set to CLIENT_DIS, so the when the dGPU suspend, the audio which is bound to iGPU will also be suspend.
>>>
>>> Now, after Lukas' patches. The audio will auto suspend. It make ubuntu audio setting could not detect HDMI audio, even if HDMI has light up.
>> OK, and it has all necessary patches including the one Lukas
>> suggested, right?
>>
>> If so, figure out what you're actually seeing as "PA could not detect
>> HDMI audio".  For example, is it the HDMI (jack) detection (giving
>> false even if it's connected)?  Or is it an error at opening the given
>> device? Does the driver give the proper ELD bytes as well as the jack
>> state?
>>
>>
>> Takashi
>>
>>> Thanks
>>> JimQu
>>>
>>> -----邮件原件-----
>>> 发件人: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
>>> 发送时间: 2018年7月9日 23:58
>>> 收件人: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
>>> 抄送: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Qu, Jim <Jim.Qu-5C7GfCeVMHo@public.gmane.org>; dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
>>> 主题: Re: [alsa-devel] 答复: [PATCH] vgaswitchroo: set audio client id according to bound gpu client id
>>>
>>> On Mon, 09 Jul 2018 17:56:43 +0200,
>>> Daniel Vetter wrote:
>>>> On Mon, Jul 09, 2018 at 05:04:22PM +0200, Takashi Iwai wrote:
>>>>> On Mon, 09 Jul 2018 15:58:51 +0200,
>>>>> Alex Deucher wrote:
>>>>>> On Mon, Jul 9, 2018 at 6:16 AM, Qu, Jim <Jim.Qu-5C7GfCeVMHo@public.gmane.org> wrote:
>>>>>>> Hi Lukas,
>>>>>>>
>>>>>>> Thanks to your explanation, and see comments in line.
>>>>>>>
>>>>>>>
>>>>>>> Do you need to runtime resume the HDA controller even if user
>>>>>>> space isn't streaming audio?  Why, and in which situation exactly?
>>>>>>>
>>>>>>> Jim: OEM system uses pactl to queiry audio card and audio output sink, since the audio has power down by runtime pm, so the audio card and output sink are all unavailable. they could not select the available HDMI audio for audio playing.
>>>>>>>
>>>>>>> You're saying above that the HDA controller isn't runtime
>>>>>>> resumed on hotplug of a display.  Is that necessary to retrieve ELD or something?
>>>>>>> I'm not sure if there's code in the HDA driver to acquire a
>>>>>>> runtime PM ref on HPD, but maybe it's necessary.  Or maybe the
>>>>>>> code is there but somehow no HPD interrupt is received by the HDA driver?
>>>>>>>
>>>>>>> Jim: So far, I do not find any code about audio response HPD in kernel. the HPD interrupt will sent to user mode via uevent, not sure whether audio user mode driver can receive the event or not.
>>>>>> On the gfx side at least, we can get a hotplug event via ACPI
>>>>>> (depending on the OEM design) if displays are attached/detached
>>>>>> while the dGPU is powered down.  I suppose the gfx driver could
>>>>>> call into the audio driver during one of those events.  On the gfx
>>>>>> side at least we just generate the gfx hotplug event and let userspace deal with it.
>>>>> IMO, a more proper way would be to have the direct communication
>>>>> between the graphics driver and the audio driver like i915 driver
>>>>> does.  Then the audio driver can get plug/unplug event at more
>>>>> accurate timing without races.
>>>>>
>>>>> (Though, it will cause another mess wrt the weak module dependency,
>>>>> but it's another story :)
>>>> Just don't do what snd-hda-intel did and instead implement the
>>>> component stuff properly :-)
>>> A patch is welcome :)
>>>
>>>
>>> thanks,
>>>
>>> Takashi
>>>
>>>> -Daniel
>>>>
>>>>>
>>>>> thanks,
>>>>>
>>>>> Takashi
>>>>>
>>>>>
>>>>>> Alex
>>>>>>
>>>>>>> Thanks
>>>>>>> JimQu
>>>>>>>
>>>>>>> ________________________________________
>>>>>>> 发件人: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
>>>>>>> 发送时间: 2018年7月9日 17:27
>>>>>>> 收件人: Qu, Jim
>>>>>>> 抄送: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org;
>>>>>>> dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander;
>>>>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>>>> 主题: Re: [PATCH] vgaswitchroo: set audio client id according to
>>>>>>> bound gpu client id
>>>>>>>
>>>>>>> On Mon, Jul 09, 2018 at 08:52:33AM +0000, Qu, Jim wrote:
>>>>>>>> Now, I found the audio device will auto suspend even if the gpu
>>>>>>>> is active, and if I plug in a HDMI device it also do not resume back.
>>>>>>>>
>>>>>>>> 1. Did you encounter similar issue before?
>>>>>>>> 2. audio will auto suspend as default at beginning of boot, is
>>>>>>>> it expect behaviour?
>>>>>>> Yes, that's expected.  Once you start streaming audio to
>>>>>>> attached displays, user space opens the codec device and this
>>>>>>> causes the HDA controller to runtime resume.  If the discrete
>>>>>>> GPU is suspended at that moment, it will be powered on and kept powered on as long as user space is streaming audio.
>>>>>>>
>>>>>>> Do you need to runtime resume the HDA controller even if user
>>>>>>> space isn't streaming audio?  Why, and in which situation exactly?
>>>>>>>
>>>>>>> You're saying above that the HDA controller isn't runtime
>>>>>>> resumed on hotplug of a display.  Is that necessary to retrieve ELD or something?
>>>>>>> I'm not sure if there's code in the HDA driver to acquire a
>>>>>>> runtime PM ref on HPD, but maybe it's necessary.  Or maybe the
>>>>>>> code is there but somehow no HPD interrupt is received by the HDA driver?
>>>>>>>
>>>>>>> Thanks,
>>>>>>>
>>>>>>> Lukas
>>>>>>> _______________________________________________
>>>>>>> dri-devel mailing list
>>>>>>> dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>>>>> _______________________________________________
>>>>>> Alsa-devel mailing list
>>>>>> Alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
>>>>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>>>> _______________________________________________
>>>>> dri-devel mailing list
>>>>> dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>>> --
>>>> Daniel Vetter
>>>> Software Engineer, Intel Corporation
>>>> http://blog.ffwll.ch
>>>>
>> [2 pactl_with_runtimepm <application/octet-stream (base64)>]
>>


--------------A379C6F358FA36B8D457551F
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 2018年07月10日 16:01, Takashi Iwai
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:s5hr2kbr03k.wl-tiwai-l3A5Bk7waGM@public.gmane.org">
      <pre wrap="">On Tue, 10 Jul 2018 09:44:42 +0200,
Qu, Jim wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">
Hi Takashi,

I am not expert in audio driver, so I just update some test result, please help triage the issue.

With audio runtime pm:
</pre>
      </blockquote>
      <pre wrap="">
What does this mean?  Is it the stock 4.17.x (or 4.18-rc)?
Please clarify your test environment at first: which kernel, which
hardware setup.

</pre>
    </blockquote>
    This is v4.15 which backport Lukas' patches and also one bug fix
<a class="moz-txt-link-freetext" href="https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/?id=57cb54e53bdd">https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/?id=57cb54e53bdd</a>.<br>
    The platform is AMDAPU(with audio) + AMD dGPU , it is a hybird GFX
    platform. In generic, dGPU will always be suspended.<br>
    <blockquote type="cite" cite="mid:s5hr2kbr03k.wl-tiwai-l3A5Bk7waGM@public.gmane.org">
      <blockquote type="cite">
        <pre wrap="">1. ubuntu audio setting use pactl to query audio card/output sink. Attachment is pactl output with audio runtime pm.
2. cat /proc/asound/card0/eld* can get nothing.

Without audio runtime pm:
1. pactl can get available audio output/sink
2. can get eld info from eld#0.1

IMO, the issue should be:

Current operations like HDMI hotplug in/out, pactl command, they do
not access audio HW, so the audio could not resume back at this
period.
</pre>
      </blockquote>
      <pre wrap="">
Sorry, not understood.  Why they don't access the audio hardware?
</pre>
    </blockquote>
    This is my guess, since I do not get azx_runtime_resume() print info
    which I added. it maybe access HW during this period, but do not
    trigger audio resume progress. <span class="nf"><a
href="https://elixir.bootlin.com/linux/v4.18-rc3/ident/azx_runtime_resume"><br>
      </a></span>
    <blockquote type="cite" cite="mid:s5hr2kbr03k.wl-tiwai-l3A5Bk7waGM@public.gmane.org">
      <pre wrap="">
</pre>
      <blockquote type="cite">
        <pre wrap="">Therefore, upper software could not get HDMI ELD info, can select a available card/output sink.
I am also confuse that if there is no ELD info, how driver to steam audio device to wake up itself? It's sort of a chicken-or-egg question.
</pre>
      </blockquote>
      <pre wrap="">
As long as it's i915 and HD-audio, the hotplug and ELD info transfer
doesn't trigger the runtime PM since it's done via the direct
callback.  And ELD value is cached in HD-audio side.
</pre>
    </blockquote>
    Yeah, I have reviewed these code, it constructs ELD after reading
    EDID, and write them into HW buffer when set display mode.<br>
    <blockquote type="cite" cite="mid:s5hr2kbr03k.wl-tiwai-l3A5Bk7waGM@public.gmane.org">
      <pre wrap="">
The exception is that if the notification is done during the PM
operation.  But, the connection and ELD query is performed at the end
of codec resume, hence it'll be covered there.

So in theory, ELD information should be passed from the GPU to
HD-audio no matter whether runtime PM is enabled or not.


BTW, please stop top-posting.  It makes the thread readability awfully
worse.

</pre>
    </blockquote>
    Sorry, I justed used outlook client.<br>
    <blockquote type="cite" cite="mid:s5hr2kbr03k.wl-tiwai-l3A5Bk7waGM@public.gmane.org">
      <pre wrap="">
thanks,

Takashi

</pre>
      <blockquote type="cite">
        <pre wrap="">
Thanks
JimQu

________________________________________
发件人: Takashi Iwai <a class="moz-txt-link-rfc2396E" href="mailto:tiwai-l3A5Bk7waGM@public.gmane.org">&lt;tiwai-l3A5Bk7waGM@public.gmane.org&gt;</a>
发送时间: 2018年7月10日 1:09
收件人: Qu, Jim
抄送: Daniel Vetter; Alex Deucher; <a class="moz-txt-link-abbreviated" href="mailto:alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org">alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org</a>; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>; <a class="moz-txt-link-abbreviated" href="mailto:dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>; Deucher, Alexander
主题: Re: 答复: [alsa-devel]        答复: [PATCH] vgaswitchroo: set audio client id according to bound gpu client id

On Mon, 09 Jul 2018 18:05:09 +0200,
Qu, Jim wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="">
Hi Takashi,

Not intel, but it is AMD APU+ AMD GFX, the APU has a local HDMI port for extension. And dGPU is only for offloading render via PRIME.

Originally, the HDA driver before v4.17, there is a bug, that all the audio is set to CLIENT_DIS, so the when the dGPU suspend, the audio which is bound to iGPU will also be suspend.

Now, after Lukas' patches. The audio will auto suspend. It make ubuntu audio setting could not detect HDMI audio, even if HDMI has light up.
</pre>
        </blockquote>
        <pre wrap="">
OK, and it has all necessary patches including the one Lukas
suggested, right?

If so, figure out what you're actually seeing as "PA could not detect
HDMI audio".  For example, is it the HDMI (jack) detection (giving
false even if it's connected)?  Or is it an error at opening the given
device? Does the driver give the proper ELD bytes as well as the jack
state?


Takashi

</pre>
        <blockquote type="cite">
          <pre wrap="">
Thanks
JimQu

-----邮件原件-----
发件人: Takashi Iwai <a class="moz-txt-link-rfc2396E" href="mailto:tiwai-l3A5Bk7waGM@public.gmane.org">&lt;tiwai-l3A5Bk7waGM@public.gmane.org&gt;</a>
发送时间: 2018年7月9日 23:58
收件人: Daniel Vetter <a class="moz-txt-link-rfc2396E" href="mailto:daniel-/w4YWyX8dFk@public.gmane.org">&lt;daniel-/w4YWyX8dFk@public.gmane.org&gt;</a>
抄送: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org">alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org</a>; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>; Qu, Jim <a class="moz-txt-link-rfc2396E" href="mailto:Jim.Qu-5C7GfCeVMHo@public.gmane.org">&lt;Jim.Qu-5C7GfCeVMHo@public.gmane.org&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>; Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org">&lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;</a>
主题: Re: [alsa-devel] 答复: [PATCH] vgaswitchroo: set audio client id according to bound gpu client id

On Mon, 09 Jul 2018 17:56:43 +0200,
Daniel Vetter wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="">
On Mon, Jul 09, 2018 at 05:04:22PM +0200, Takashi Iwai wrote:
</pre>
            <blockquote type="cite">
              <pre wrap="">On Mon, 09 Jul 2018 15:58:51 +0200,
Alex Deucher wrote:
</pre>
              <blockquote type="cite">
                <pre wrap="">
On Mon, Jul 9, 2018 at 6:16 AM, Qu, Jim <a class="moz-txt-link-rfc2396E" href="mailto:Jim.Qu-5C7GfCeVMHo@public.gmane.org">&lt;Jim.Qu-5C7GfCeVMHo@public.gmane.org&gt;</a> wrote:
</pre>
                <blockquote type="cite">
                  <pre wrap="">Hi Lukas,

Thanks to your explanation, and see comments in line.


Do you need to runtime resume the HDA controller even if user
space isn't streaming audio?  Why, and in which situation exactly?

Jim: OEM system uses pactl to queiry audio card and audio output sink, since the audio has power down by runtime pm, so the audio card and output sink are all unavailable. they could not select the available HDMI audio for audio playing.

You're saying above that the HDA controller isn't runtime
resumed on hotplug of a display.  Is that necessary to retrieve ELD or something?
I'm not sure if there's code in the HDA driver to acquire a
runtime PM ref on HPD, but maybe it's necessary.  Or maybe the
code is there but somehow no HPD interrupt is received by the HDA driver?

Jim: So far, I do not find any code about audio response HPD in kernel. the HPD interrupt will sent to user mode via uevent, not sure whether audio user mode driver can receive the event or not.
</pre>
                </blockquote>
                <pre wrap="">
On the gfx side at least, we can get a hotplug event via ACPI
(depending on the OEM design) if displays are attached/detached
while the dGPU is powered down.  I suppose the gfx driver could
call into the audio driver during one of those events.  On the gfx
side at least we just generate the gfx hotplug event and let userspace deal with it.
</pre>
              </blockquote>
              <pre wrap="">
IMO, a more proper way would be to have the direct communication
between the graphics driver and the audio driver like i915 driver
does.  Then the audio driver can get plug/unplug event at more
accurate timing without races.

(Though, it will cause another mess wrt the weak module dependency,
but it's another story :)
</pre>
            </blockquote>
            <pre wrap="">
Just don't do what snd-hda-intel did and instead implement the
component stuff properly :-)
</pre>
          </blockquote>
          <pre wrap="">
A patch is welcome :)


thanks,

Takashi

</pre>
          <blockquote type="cite">
            <pre wrap="">-Daniel

</pre>
            <blockquote type="cite">
              <pre wrap="">

thanks,

Takashi


</pre>
              <blockquote type="cite">
                <pre wrap="">
Alex

</pre>
                <blockquote type="cite">
                  <pre wrap="">
Thanks
JimQu

________________________________________
发件人: Lukas Wunner <a class="moz-txt-link-rfc2396E" href="mailto:lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org">&lt;lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org&gt;</a>
发送时间: 2018年7月9日 17:27
收件人: Qu, Jim
抄送: <a class="moz-txt-link-abbreviated" href="mailto:alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org">alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org</a>;
<a class="moz-txt-link-abbreviated" href="mailto:dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>; Deucher, Alexander;
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
主题: Re: [PATCH] vgaswitchroo: set audio client id according to
bound gpu client id

On Mon, Jul 09, 2018 at 08:52:33AM +0000, Qu, Jim wrote:
</pre>
                  <blockquote type="cite">
                    <pre wrap="">Now, I found the audio device will auto suspend even if the gpu
is active, and if I plug in a HDMI device it also do not resume back.

1. Did you encounter similar issue before?
2. audio will auto suspend as default at beginning of boot, is
it expect behaviour?
</pre>
                  </blockquote>
                  <pre wrap="">
Yes, that's expected.  Once you start streaming audio to
attached displays, user space opens the codec device and this
causes the HDA controller to runtime resume.  If the discrete
GPU is suspended at that moment, it will be powered on and kept powered on as long as user space is streaming audio.

Do you need to runtime resume the HDA controller even if user
space isn't streaming audio?  Why, and in which situation exactly?

You're saying above that the HDA controller isn't runtime
resumed on hotplug of a display.  Is that necessary to retrieve ELD or something?
I'm not sure if there's code in the HDA driver to acquire a
runtime PM ref on HPD, but maybe it's necessary.  Or maybe the
code is there but somehow no HPD interrupt is received by the HDA driver?

Thanks,

Lukas
_______________________________________________
dri-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/dri-devel">https://lists.freedesktop.org/mailman/listinfo/dri-devel</a>
</pre>
                </blockquote>
                <pre wrap="">_______________________________________________
Alsa-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org">Alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="http://mailman.alsa-project.org/mailman/listinfo/alsa-devel">http://mailman.alsa-project.org/mailman/listinfo/alsa-devel</a>
</pre>
              </blockquote>
              <pre wrap="">_______________________________________________
dri-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/dri-devel">https://lists.freedesktop.org/mailman/listinfo/dri-devel</a>
</pre>
            </blockquote>
            <pre wrap="">
--
Daniel Vetter
Software Engineer, Intel Corporation
<a class="moz-txt-link-freetext" href="http://blog.ffwll.ch">http://blog.ffwll.ch</a>

</pre>
          </blockquote>
        </blockquote>
        <pre wrap="">[2 pactl_with_runtimepm &lt;application/octet-stream (base64)&gt;]

</pre>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------A379C6F358FA36B8D457551F--

--===============0344648761==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0344648761==--
