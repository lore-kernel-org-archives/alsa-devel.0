From: jimqu <jimqu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 2/2] vgaswitchreoo: set audio client id in
 vgaswitchreoo enable function
Date: Sat, 14 Jul 2018 00:51:02 +0800
Message-ID: <8fc773cc-1a92-aff0-a349-5d9e44d4f0fd@amd.com>
References: <1531469162-6472-1-git-send-email-Jim.Qu@amd.com>
 <1531469162-6472-2-git-send-email-Jim.Qu@amd.com>
 <s5hmuuv8qvp.wl-tiwai@suse.de> <1add12ce-a28c-c964-0f52-9d1661839ca2@amd.com>
 <s5hbmbbm6q9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0332725013=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <s5hbmbbm6q9.wl-tiwai-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: Jim Qu <Jim.Qu-5C7GfCeVMHo@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--===============0332725013==
Content-Type: multipart/alternative;
 boundary="------------53C8DBEB6896EF6090A72878"

This is a multi-part message in MIME format.
--------------53C8DBEB6896EF6090A72878
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2018/7/14 0:38, Takashi Iwai 写道:
> On Fri, 13 Jul 2018 17:25:39 +0200,
> jimqu wrote:
>>
>>
>> 在 2018/7/13 16:46, Takashi Iwai 写道:
>>> On Fri, 13 Jul 2018 10:06:02 +0200,
>>> Jim Qu wrote:
>>>> On modern laptop, there are more and more platforms
>>>> have two GPUs, and each of them maybe have audio codec
>>>> for HDMP/DP output. For some dGPU which is no output,
>>>> audio codec usually is disabled.
>>>>
>>>> In currect HDA audio driver, it will set all codec as
>>>> VGA_SWITCHEROO_DIS, the audio which is binded to UMA
>>>> will be suspended if user use debugfs to contorl power
>>>>
>>>> In HDA driver side, it is difficult to know which GPU
>>>> the audio has binded to. So set the bound gpu pci dev
>>>> to vgaswitchroo, the correct audio id will be set in
>>>> vgaswitchreoo enable function.
>>>>
>>>> Signed-off-by: Jim Qu <Jim.Qu-5C7GfCeVMHo@public.gmane.org>
>>> The idea looks good to me.  Just a nitpick:
>>>
>>>> @@ -1319,15 +1319,16 @@ static const struct vga_switcheroo_client_ops azx_vs_ops = {
>>>>    static int register_vga_switcheroo(struct azx *chip)
>>>>    {
>>>>    	struct hda_intel *hda = container_of(chip, struct hda_intel, chip);
>>>> +	struct pci_dev * p;
>>>>    	int err;
>>>>      	if (!hda->use_vga_switcheroo)
>>>>    		return 0;
>>>> -	/* FIXME: currently only handling DIS controller
>>>> -	 * is there any machine with two switchable HDMI audio controllers?
>>>> -	 */
>>>> -	err = vga_switcheroo_register_audio_client(chip->pci, &azx_vs_ops,
>>>> -						   VGA_SWITCHEROO_DIS);
>>>> +
>>>> +	p  = get_bound_vga(chip->pci);
>>>> +	err = vga_switcheroo_register_audio_client(chip->pci, &azx_vs_ops, p);
>>>> +	if (p)
>>>> +		pci_dev_put(p);
>>> Passing a NULL vga_dev won't work, so the NULL check after calling
>>> vga_switcheroo_register_audio_client() is moot.  If any, it should be
>>> checked before that.
>>>
>>   The hda->use_vga_switcheroo is set to 1 in init_vga_switcheroo() if
>> bound vga pci dev is not NULL. Since the hda->use_vga_switcheroo is
>> checked at beginning of the function. so the p which pass into
>> vga_switcheroo_register_audio_client() is constant valid value.
> So the NULL-check in the patch is also useless, no? :)

Ha-ha, indeed, the NULL-check of p is unnecessary. will update in v2.

Thanks
JimQu
> Takashi


--------------53C8DBEB6896EF6090A72878
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
    <div class="moz-cite-prefix">在 2018/7/14 0:38, Takashi Iwai 写道:<br>
    </div>
    <blockquote type="cite" cite="mid:s5hbmbbm6q9.wl-tiwai-l3A5Bk7waGM@public.gmane.org">
      <pre wrap="">On Fri, 13 Jul 2018 17:25:39 +0200,
jimqu wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">


在 2018/7/13 16:46, Takashi Iwai 写道:
</pre>
        <blockquote type="cite">
          <pre wrap="">On Fri, 13 Jul 2018 10:06:02 +0200,
Jim Qu wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="">On modern laptop, there are more and more platforms
have two GPUs, and each of them maybe have audio codec
for HDMP/DP output. For some dGPU which is no output,
audio codec usually is disabled.

In currect HDA audio driver, it will set all codec as
VGA_SWITCHEROO_DIS, the audio which is binded to UMA
will be suspended if user use debugfs to contorl power

In HDA driver side, it is difficult to know which GPU
the audio has binded to. So set the bound gpu pci dev
to vgaswitchroo, the correct audio id will be set in
vgaswitchreoo enable function.

Signed-off-by: Jim Qu <a class="moz-txt-link-rfc2396E" href="mailto:Jim.Qu-5C7GfCeVMHo@public.gmane.org">&lt;Jim.Qu-5C7GfCeVMHo@public.gmane.org&gt;</a>
</pre>
          </blockquote>
          <pre wrap="">The idea looks good to me.  Just a nitpick:

</pre>
          <blockquote type="cite">
            <pre wrap="">@@ -1319,15 +1319,16 @@ static const struct vga_switcheroo_client_ops azx_vs_ops = {
  static int register_vga_switcheroo(struct azx *chip)
  {
  	struct hda_intel *hda = container_of(chip, struct hda_intel, chip);
+	struct pci_dev * p;
  	int err;
    	if (!hda-&gt;use_vga_switcheroo)
  		return 0;
-	/* FIXME: currently only handling DIS controller
-	 * is there any machine with two switchable HDMI audio controllers?
-	 */
-	err = vga_switcheroo_register_audio_client(chip-&gt;pci, &amp;azx_vs_ops,
-						   VGA_SWITCHEROO_DIS);
+
+	p  = get_bound_vga(chip-&gt;pci);
+	err = vga_switcheroo_register_audio_client(chip-&gt;pci, &amp;azx_vs_ops, p);
+	if (p)
+		pci_dev_put(p);
</pre>
          </blockquote>
          <pre wrap="">Passing a NULL vga_dev won't work, so the NULL check after calling
vga_switcheroo_register_audio_client() is moot.  If any, it should be
checked before that.

</pre>
        </blockquote>
        <pre wrap="">
 The hda-&gt;use_vga_switcheroo is set to 1 in init_vga_switcheroo() if
bound vga pci dev is not NULL. Since the hda-&gt;use_vga_switcheroo is
checked at beginning of the function. so the p which pass into
vga_switcheroo_register_audio_client() is constant valid value.
</pre>
      </blockquote>
      <pre wrap="">
So the NULL-check in the patch is also useless, no? :)
</pre>
    </blockquote>
    <br>
    Ha-ha, indeed, the NULL-check of p is unnecessary. will update in
    v2.<br>
    <br>
    Thanks<br>
    JimQu<br>
    <span style="color: rgb(255, 255, 255); font-family: Arial,
      &quot;PingFang SC&quot;, &quot;Hiragino Sans GB&quot;, STHeiti,
      &quot;Microsoft YaHei&quot;, &quot;WenQuanYi Micro Hei&quot;,
      sans-serif; font-size: 14px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: normal; letter-spacing: normal; orphans: 2;
      text-align: left; text-indent: 0px; text-transform: none;
      white-space: nowrap; widows: 2; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(67, 149,
      255); display: inline !important; float: none;"></span>
    <span style="color: rgb(255, 255, 255); font-family: Arial,
      &quot;PingFang SC&quot;, &quot;Hiragino Sans GB&quot;, STHeiti,
      &quot;Microsoft YaHei&quot;, &quot;WenQuanYi Micro Hei&quot;,
      sans-serif; font-size: 14px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: normal; letter-spacing: normal; orphans: 2;
      text-align: left; text-indent: 0px; text-transform: none;
      white-space: nowrap; widows: 2; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(67, 149,
      255); display: inline !important; float: none;"></span>
    <blockquote type="cite" cite="mid:s5hbmbbm6q9.wl-tiwai-l3A5Bk7waGM@public.gmane.org">
      <pre wrap="">
Takashi
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------53C8DBEB6896EF6090A72878--

--===============0332725013==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0332725013==--
