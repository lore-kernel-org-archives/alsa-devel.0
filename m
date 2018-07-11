From: jimqu <jimqu-5C7GfCeVMHo@public.gmane.org>
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiBbYWxzYS1kZXZlbF0g562U5aSNOiBb?=
 =?UTF-8?Q?PATCH]_vgaswitchroo:_set_audio_client_id_according_to_bound_gpu_c?=
 =?UTF-8?Q?lient_id?=
Date: Wed, 11 Jul 2018 16:41:38 +0800
Message-ID: <1936c752-f858-2caf-35e7-98bea431fb7c@amd.com>
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
 <s5hr2kbr03k.wl-tiwai@suse.de> <a37f08e7-734e-977c-597f-46d5c3ec34bc@amd.com>
 <s5hin5nctby.wl-tiwai@suse.de> <733011b9-1880-76a8-d00f-076591e93c53@amd.com>
 <s5hbmbfcp5v.wl-tiwai@suse.de> <s5hfu0qp7cv.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1048296387=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <s5hfu0qp7cv.wl-tiwai-l3A5Bk7waGM@public.gmane.org>
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
--===============1048296387==
Content-Type: multipart/alternative;
 boundary="------------C943BFC6C6D5996CBF144267"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------C943BFC6C6D5996CBF144267
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2018年07月11日 15:19, Takashi Iwai wrote:
> On Tue, 10 Jul 2018 13:21:00 +0200,
> Takashi Iwai wrote:
>>> revert the fix of amdgpu suspend issue, audio issue also can be observed.
>> Did you check the behavior with the single AMD GPU hardware?
>> If confirmed, we can forget about vga_switcheroo.
> ... and taking a look back at the recent changes, I guess it can be
> the forced runtime PM enablement, not directly with vga_switcheroo
> action itself.

Yeah, the function vga_switcheroo_set_dynamic_switch() has discarded, so 
there is no way GFX driver to control audio power. However, keep in 
mind, current audio is bound to iGPU, that mean the issue should be 
nothing about
vgaswtichreoo. since current audio pci bus is different from dGPU, that 
means the pci_bus_set_current_state() in 
vga_switcheroo_runtime_suspend() and pci_wakeup_bus() in 
vga_switcheroo_runtime_resume() could not touch the audio pci power 
state from dGPU instance.

This is a feedback got from our OEM developer, it is the overview of 
audio detect process.

> First, the kernel  audio driver will be triggered to read ELD, if the
 >> ELD is valid, it will report a jack event (on or available) to sound
 >> core driver; the pulseaudio subscribe all jack events, if it is told
 >> that the hdmi jack is plugged in (on), the pulseaudio will set this
 >> port to available, then the pa-card or pa-sink has available port, it
 >> can be selected (manually, some daemons or policy in
 >> /usr/share/pulseaudio/alsa-mixer/) as default output card/default sink.

If the description is correct. I think there are maybe two problems.

1. audio will auto power off after setup device link duo to usage_count=0.
2. duo to audio is power down, it could not get the HDMI jack insert event.

How do you think?

> Jim, could you tell me which PCI devices are handled as vga_switcheroo
> audio client?  The kernel should show all messages "xxx: Handle
> vga_switcheroo audio client".

[    4.311095] snd_hda_intel 0000:06:00.1: enabling device (0000 -> 0002)
[    4.314286] snd_hda_intel 0000:06:00.1: Handle vga_switcheroo audio 
client
[    4.314822] snd_hda_intel 0000:06:00.6: enabling device (0000 -> 0002)

01:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. 
[AMD/ATI] Device [1002:699f] (rev c3)
06:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. 
[AMD/ATI] Device [1002:15dd] (rev d1)
06:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] 
Device [1002:15de]

Thanks
JimQu
> At best, give the full dmesg output and the lspci -nv output.
>
>
> thanks,
>
> Takashi


--------------C943BFC6C6D5996CBF144267
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
    <div class="moz-cite-prefix">On 2018年07月11日 15:19, Takashi Iwai
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:s5hfu0qp7cv.wl-tiwai-l3A5Bk7waGM@public.gmane.org">
      <pre wrap="">On Tue, 10 Jul 2018 13:21:00 +0200,
Takashi Iwai wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">
</pre>
        <blockquote type="cite">
          <pre wrap="">revert the fix of amdgpu suspend issue, audio issue also can be observed.
</pre>
        </blockquote>
        <pre wrap="">
Did you check the behavior with the single AMD GPU hardware?
If confirmed, we can forget about vga_switcheroo.
</pre>
      </blockquote>
      <pre wrap="">
... and taking a look back at the recent changes, I guess it can be
the forced runtime PM enablement, not directly with vga_switcheroo
action itself.
</pre>
    </blockquote>
    <br>
    Yeah, the function vga_switcheroo_set_dynamic_switch() has
    discarded, so there is no way GFX driver to control audio power. 
    However, keep in mind, current audio is bound to iGPU, that mean the
    issue should be nothing about <br>
    vgaswtichreoo. since current audio pci bus is different from dGPU,
    that means the pci_bus_set_current_state() in
    vga_switcheroo_runtime_suspend() and pci_wakeup_bus() in
    vga_switcheroo_runtime_resume() could not touch the audio pci power
    state from dGPU instance.<br>
    <br>
    This is a feedback got from our OEM developer, it is the overview of
    audio detect process.<br>
    <br>
    <font size="2"><span style="font-size:11pt;">&gt; First, the kernel
        audio driver will be triggered to read ELD, if the <br>
        &gt;&gt; ELD is valid, it will report a jack event (on or
        available) to sound <br>
        &gt;&gt; core driver; the pulseaudio subscribe all jack events,
        if it is told <br>
        &gt;&gt; that the hdmi jack is plugged in (on), the pulseaudio
        will set this <br>
        &gt;&gt; port to available, then the pa-card or pa-sink has
        available port, it <br>
        &gt;&gt; can be selected (manually, some daemons or policy in <br>
        &gt;&gt; /usr/share/pulseaudio/alsa-mixer/) as default output
        card/default sink.<br>
        <br>
        If the description is correct. I think there are maybe two
        problems.<br>
        <br>
        1. audio will auto power off after setup device link duo to
        usage_count=0.<br>
        2. duo to audio is power down, it could not get the HDMI jack
        insert event.<br>
        <br>
        How do you think?<br>
      </span></font><br>
    <blockquote type="cite" cite="mid:s5hfu0qp7cv.wl-tiwai-l3A5Bk7waGM@public.gmane.org">
      <pre wrap="">
Jim, could you tell me which PCI devices are handled as vga_switcheroo
audio client?  The kernel should show all messages "xxx: Handle
vga_switcheroo audio client". 
</pre>
    </blockquote>
    <br>
    [    4.311095] snd_hda_intel 0000:06:00.1: enabling device (0000
    -&gt; 0002)<br>
    [    4.314286] snd_hda_intel 0000:06:00.1: Handle vga_switcheroo
    audio client<br>
    [    4.314822] snd_hda_intel 0000:06:00.6: enabling device (0000
    -&gt; 0002)<br>
    <br>
    01:00.0 VGA compatible controller [0300]: Advanced Micro Devices,
    Inc. [AMD/ATI] Device [1002:699f] (rev c3)<br>
    06:00.0 VGA compatible controller [0300]: Advanced Micro Devices,
    Inc. [AMD/ATI] Device [1002:15dd] (rev d1)<br>
    06:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI]
    Device [1002:15de]<br>
    <br>
    Thanks<br>
    JimQu<br>
    <blockquote type="cite" cite="mid:s5hfu0qp7cv.wl-tiwai-l3A5Bk7waGM@public.gmane.org">
      <pre wrap="">
At best, give the full dmesg output and the lspci -nv output.


thanks,

Takashi
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------C943BFC6C6D5996CBF144267--

--===============1048296387==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1048296387==--
