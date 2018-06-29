From: "Qu, Jim" <Jim.Qu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] vgaswitchroo: set audio client id according to bound gpu
 client id
Date: Fri, 29 Jun 2018 10:40:50 +0000
Message-ID: <DM3PR12MB08732DAAAA57739DCE431D66994E0@DM3PR12MB0873.namprd12.prod.outlook.com>
References: <1530166933-21655-1-git-send-email-Jim.Qu@amd.com>
 <CADnq5_NcNfMD9UDN17c-513rD--kQY7nzw6OTgimV0pVqLjbOg@mail.gmail.com>
 <DM3PR12MB08737CF35AF6D0CE1A1BDC64994E0@DM3PR12MB0873.namprd12.prod.outlook.com>
 <20180629080634.GA7357@wunner.de>
 <DM3PR12MB08737DC9FB94BB6F3AEF5634994E0@DM3PR12MB0873.namprd12.prod.outlook.com>,
 <20180629092138.GA11849@wunner.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0646933711=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180629092138.GA11849-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
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
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

--===============0646933711==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM3PR12MB08732DAAAA57739DCE431D66994E0DM3PR12MB0873namp_"

--_000_DM3PR12MB08732DAAAA57739DCE431D66994E0DM3PR12MB0873namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

indeed?I used 4.13 on the platform. let me have a try with the patch you me=
ntioned

thinks
jimqu

?? Outlook for Android<https://aka.ms/ghei36>

________________________________
From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Sent: Friday, June 29, 2018 5:21:38 PM
To: Qu, Jim
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org; dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, =
Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] vgaswitchroo: set audio client id according to bound g=
pu client id

On Fri, Jun 29, 2018 at 08:55:40AM +0000, Qu, Jim wrote:
> When our dGPU does suspend by runtime pm. amdgpu driver for dgpu will
> also call vgaswtichroo to power off its audio. vgaswitchroo driver will
> find audio codec by vgaswitchroo dgpu client id(VGA_SWITCHEROO_DIS).

That is no longer the case since v4.17.  The HDA controller now runtime
suspends autonomously, see commit 07f4f97d7b4b ("vga_switcheroo: Use
device link for HDA controller").

Your patch appears to be geared towards an older kernel version.
Please retest on the laptop in question with a v4.17+ kernel.


> I think the issue should be observed on both Intel+AMD or AMD+AMD
> platform which has the same HW configuration.
>
> 1.if dGPU has no audio codec. the issue should be always observed.
> 2.if both iGPU and dGPU has audio codecs, the issue should be random,
> it depends on the first audio found by vgaswitchroo driver is on iGPU
> or dGPU.

On discrete AMD and Nvidia GPUs, the HDA controller is function 1 and
the GPU is function 0 in the same PCI slot.

On Intel chipsets, the HDA controller and the GPU have completely
different PCI device numbers, e.g. the GPU might be 0000:00:02.0 and
the HDA controller might be 0000:00:1b.0.

get_bound_vga() checks that the HDA controller is function 1 and there's
a GPU in function 0 of the same slot.

Thus get_bound_vga() always returns NULL for an Intel HDA controller and
the controller is never registered with vga_switcheroo (which is fine).

Thanks,

Lukas

--_000_DM3PR12MB08732DAAAA57739DCE431D66994E0DM3PR12MB0873namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
indeed&#65292;I used 4.13 on the platform. let me have a try with the patch=
 you mentioned<br>
<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
thinks<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
jimqu<br>
<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
&#33719;&#21462; <a href=3D"https://aka.ms/ghei36">Outlook for Android</a><=
/div>
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Lukas Wunner &lt;lu=
kas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, June 29, 2018 5:21:38 PM<br>
<b>To:</b> Qu, Jim<br>
<b>Cc:</b> alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org; dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; De=
ucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] vgaswitchroo: set audio client id according to =
bound gpu client id</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">On Fri, Jun 29, 2018 at 08:55:40AM &#43;0000, Qu, =
Jim wrote:<br>
&gt; When our dGPU does suspend by runtime pm. amdgpu driver for dgpu will<=
br>
&gt; also call vgaswtichroo to power off its audio. vgaswitchroo driver wil=
l<br>
&gt; find audio codec by vgaswitchroo dgpu client id(VGA_SWITCHEROO_DIS).<b=
r>
<br>
That is no longer the case since v4.17.&nbsp; The HDA controller now runtim=
e<br>
suspends autonomously, see commit 07f4f97d7b4b (&quot;vga_switcheroo: Use<b=
r>
device link for HDA controller&quot;).<br>
<br>
Your patch appears to be geared towards an older kernel version.<br>
Please retest on the laptop in question with a v4.17&#43; kernel.<br>
<br>
<br>
&gt; I think the issue should be observed on both Intel&#43;AMD or AMD&#43;=
AMD<br>
&gt; platform which has the same HW configuration.<br>
&gt; <br>
&gt; 1.if dGPU has no audio codec. the issue should be always observed.<br>
&gt; 2.if both iGPU and dGPU has audio codecs, the issue should be random,<=
br>
&gt; it depends on the first audio found by vgaswitchroo driver is on iGPU<=
br>
&gt; or dGPU.<br>
<br>
On discrete AMD and Nvidia GPUs, the HDA controller is function 1 and<br>
the GPU is function 0 in the same PCI slot.<br>
<br>
On Intel chipsets, the HDA controller and the GPU have completely<br>
different PCI device numbers, e.g. the GPU might be 0000:00:02.0 and<br>
the HDA controller might be 0000:00:1b.0.<br>
<br>
get_bound_vga() checks that the HDA controller is function 1 and there's<br=
>
a GPU in function 0 of the same slot.<br>
<br>
Thus get_bound_vga() always returns NULL for an Intel HDA controller and<br=
>
the controller is never registered with vga_switcheroo (which is fine).<br>
<br>
Thanks,<br>
<br>
Lukas<br>
</div>
</span></font>
</body>
</html>

--_000_DM3PR12MB08732DAAAA57739DCE431D66994E0DM3PR12MB0873namp_--

--===============0646933711==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0646933711==--
