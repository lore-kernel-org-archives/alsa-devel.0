From: jimqu <jimqu@amd.com>
Subject: Re: [alsa-devel] [V2 2/2] vgaswitchreoo: set audio client id in
 vgaswitchreoo enable function
Date: Mon, 16 Jul 2018 23:09:57 +0800
Message-ID: <9afe9d15-df81-b123-f713-f0bf921cded8@amd.com>
References: <1531721195-4982-1-git-send-email-Jim.Qu@amd.com>
 <1531721195-4982-2-git-send-email-Jim.Qu@amd.com>
 <5212bc55-1aeb-cb7e-2527-45cc4b483861@canonical.com>
 <20180716141610.GA19679@wunner.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0091299377=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180716141610.GA19679@wunner.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Lukas Wunner <lukas@wunner.de>, Hui Wang <hui.wang@canonical.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--===============0091299377==
Content-Type: multipart/alternative;
 boundary="------------D69288B88EA0274B82AF9C4A"

This is a multi-part message in MIME format.
--------------D69288B88EA0274B82AF9C4A
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2018/7/16 22:16, Lukas Wunner 写道:
> On Mon, Jul 16, 2018 at 03:52:45PM +0800, Hui Wang wrote:
>> On 2018???07???16??? 14:06, Jim Qu wrote:
>>> On modern laptop, there are more and more platforms
>>> have two GPUs, and each of them maybe have audio codec
>>> for HDMP/DP output. For some dGPU which is no output,
>>> audio codec usually is disabled.
>>>
>>> In currect HDA audio driver, it will set all codec as
>>> VGA_SWITCHEROO_DIS, the audio which is binded to UMA
>>> will be suspended if user use debugfs to control power
>>>
>>> In HDA driver side, it is difficult to know which GPU
>>> the audio has bound to. So set the bound gpu pci dev
>>> to vgaswitchreoo, the correct audio id will be set in
>>> vgaswitchreoo enable function.
>>>
>>> Signed-off-by: Jim Qu <Jim.Qu@amd.com>
>> Is it possible to send this patch to <stable@vger.kernel.org> as well, then
>> we will know that it is safe to backport this patch to the linux kernels
>> with different version.
> For which hardware do you want it in stable kernels?
>
> This patch pertains to manual power control, which is only used on the
> MacBook Pro by default.  And there are no MacBook Pros with AMD APUs.
> On all other hardware, users have to specify "amdgpu.runpm=0" on the
> command line to see any benefit from this patch.  Also, manual power
> control will likely be removed once we get runtime PM working with
> muxed systems (such as the MacBook Pro).

The patch idea will deal with the issues 1) manual power control after 
v4.17. 2) driver control before v4.17.  As we know current a lot of 
mainstream OS, such like ubuntu 16.04.4 (kernel is v4.15), ubuntu 
18.04(kernel is v4.15), RHEL7.x (kernel is 3.1x).
BTW, I believe you will see more and more products with AMD next 
generation of APUs in the near future.

Thanks
JimQu

> Lukas


--------------D69288B88EA0274B82AF9C4A
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">在 2018/7/16 22:16, Lukas Wunner 写道:<br>
    </div>
    <blockquote type="cite" cite="mid:20180716141610.GA19679@wunner.de">
      <pre wrap="">On Mon, Jul 16, 2018 at 03:52:45PM +0800, Hui Wang wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">On 2018???07???16??? 14:06, Jim Qu wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="">On modern laptop, there are more and more platforms
have two GPUs, and each of them maybe have audio codec
for HDMP/DP output. For some dGPU which is no output,
audio codec usually is disabled.

In currect HDA audio driver, it will set all codec as
VGA_SWITCHEROO_DIS, the audio which is binded to UMA
will be suspended if user use debugfs to control power

In HDA driver side, it is difficult to know which GPU
the audio has bound to. So set the bound gpu pci dev
to vgaswitchreoo, the correct audio id will be set in
vgaswitchreoo enable function.

Signed-off-by: Jim Qu <a class="moz-txt-link-rfc2396E" href="mailto:Jim.Qu@amd.com">&lt;Jim.Qu@amd.com&gt;</a>
</pre>
        </blockquote>
        <pre wrap="">
Is it possible to send this patch to <a class="moz-txt-link-rfc2396E" href="mailto:stable@vger.kernel.org">&lt;stable@vger.kernel.org&gt;</a> as well, then
we will know that it is safe to backport this patch to the linux kernels
with different version.
</pre>
      </blockquote>
      <pre wrap="">
For which hardware do you want it in stable kernels?

This patch pertains to manual power control, which is only used on the
MacBook Pro by default.  And there are no MacBook Pros with AMD APUs.
On all other hardware, users have to specify "amdgpu.runpm=0" on the
command line to see any benefit from this patch.  Also, manual power
control will likely be removed once we get runtime PM working with
muxed systems (such as the MacBook Pro).
</pre>
    </blockquote>
    <br>
    The patch idea will deal with the issues 1) manual power control
    after v4.17. 2) driver control before v4.17.  As we know current a
    lot of mainstream OS, such like ubuntu 16.04.4 (kernel is v4.15),
    ubuntu 18.04(kernel is v4.15), RHEL7.x (kernel is 3.1x).<br>
    BTW, I believe you will see more and more products with AMD next
    generation of APUs in the near future.<br>
    <br>
    Thanks<br>
    JimQu<span id="w_88" class="" style="color: rgb(51, 51, 51);
      font-family: Arial, &quot;PingFang SC&quot;, &quot;Hiragino Sans
      GB&quot;, STHeiti, &quot;Microsoft YaHei&quot;, &quot;WenQuanYi
      Micro Hei&quot;, sans-serif; font-size: 14px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: normal; letter-spacing: normal; orphans: 2;
      text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: 2; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(249, 249,
      249);"><span class="Apple-converted-space"></span></span><span
      id="w_89" class="" style="color: rgb(51, 51, 51); font-family:
      Arial, &quot;PingFang SC&quot;, &quot;Hiragino Sans GB&quot;,
      STHeiti, &quot;Microsoft YaHei&quot;, &quot;WenQuanYi Micro
      Hei&quot;, sans-serif; font-size: 14px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: normal; letter-spacing: normal; orphans: 2;
      text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: 2; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(249, 249,
      249);"><span class="Apple-converted-space"></span></span><span
      id="w_90" class="" style="color: rgb(51, 51, 51); font-family:
      Arial, &quot;PingFang SC&quot;, &quot;Hiragino Sans GB&quot;,
      STHeiti, &quot;Microsoft YaHei&quot;, &quot;WenQuanYi Micro
      Hei&quot;, sans-serif; font-size: 14px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: normal; letter-spacing: normal; orphans: 2;
      text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: 2; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(249, 249,
      249);"><span class="Apple-converted-space"></span></span><span
      id="w_91" class="" style="color: rgb(51, 51, 51); font-family:
      Arial, &quot;PingFang SC&quot;, &quot;Hiragino Sans GB&quot;,
      STHeiti, &quot;Microsoft YaHei&quot;, &quot;WenQuanYi Micro
      Hei&quot;, sans-serif; font-size: 14px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: normal; letter-spacing: normal; orphans: 2;
      text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: 2; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(249, 249,
      249);"><span class="Apple-converted-space"></span></span><span
      id="w_92" class="" style="color: rgb(51, 51, 51); font-family:
      Arial, &quot;PingFang SC&quot;, &quot;Hiragino Sans GB&quot;,
      STHeiti, &quot;Microsoft YaHei&quot;, &quot;WenQuanYi Micro
      Hei&quot;, sans-serif; font-size: 14px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: normal; letter-spacing: normal; orphans: 2;
      text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: 2; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(249, 249,
      249);"><span class="Apple-converted-space"></span></span><span
      id="w_93" style="color: rgb(51, 51, 51); font-family: Arial,
      &quot;PingFang SC&quot;, &quot;Hiragino Sans GB&quot;, STHeiti,
      &quot;Microsoft YaHei&quot;, &quot;WenQuanYi Micro Hei&quot;,
      sans-serif; font-size: 14px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: normal; letter-spacing: normal; orphans: 2;
      text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: 2; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(249, 249,
      249);"><span class="Apple-converted-space"></span></span><span
      id="w_94" class="" style="color: rgb(51, 51, 51); font-family:
      Arial, &quot;PingFang SC&quot;, &quot;Hiragino Sans GB&quot;,
      STHeiti, &quot;Microsoft YaHei&quot;, &quot;WenQuanYi Micro
      Hei&quot;, sans-serif; font-size: 14px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: normal; letter-spacing: normal; orphans: 2;
      text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: 2; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(249, 249,
      249);"><span class="Apple-converted-space"></span></span><span
      id="w_95" class="" style="color: rgb(51, 51, 51); font-family:
      Arial, &quot;PingFang SC&quot;, &quot;Hiragino Sans GB&quot;,
      STHeiti, &quot;Microsoft YaHei&quot;, &quot;WenQuanYi Micro
      Hei&quot;, sans-serif; font-size: 14px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: normal; letter-spacing: normal; orphans: 2;
      text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: 2; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(249, 249,
      249);"><span class="Apple-converted-space"></span></span><span
      id="w_96" class="" style="color: rgb(51, 51, 51); font-family:
      Arial, &quot;PingFang SC&quot;, &quot;Hiragino Sans GB&quot;,
      STHeiti, &quot;Microsoft YaHei&quot;, &quot;WenQuanYi Micro
      Hei&quot;, sans-serif; font-size: 14px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: normal; letter-spacing: normal; orphans: 2;
      text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: 2; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(249, 249,
      249);"><span class="Apple-converted-space"></span></span><span
      id="w_97" class="" style="color: rgb(51, 51, 51); font-family:
      Arial, &quot;PingFang SC&quot;, &quot;Hiragino Sans GB&quot;,
      STHeiti, &quot;Microsoft YaHei&quot;, &quot;WenQuanYi Micro
      Hei&quot;, sans-serif; font-size: 14px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: normal; letter-spacing: normal; orphans: 2;
      text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: 2; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(249, 249,
      249);"><span class="Apple-converted-space"></span></span><span
      id="w_98" class="" style="color: rgb(51, 51, 51); font-family:
      Arial, &quot;PingFang SC&quot;, &quot;Hiragino Sans GB&quot;,
      STHeiti, &quot;Microsoft YaHei&quot;, &quot;WenQuanYi Micro
      Hei&quot;, sans-serif; font-size: 14px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: normal; letter-spacing: normal; orphans: 2;
      text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: 2; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(249, 249,
      249);"><span class="Apple-converted-space"></span></span><span
      id="w_99" class="high-light-bg" style="background: rgb(67, 149,
      255); color: rgb(255, 255, 255); font-family: Arial,
      &quot;PingFang SC&quot;, &quot;Hiragino Sans GB&quot;, STHeiti,
      &quot;Microsoft YaHei&quot;, &quot;WenQuanYi Micro Hei&quot;,
      sans-serif; font-size: 14px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: normal; letter-spacing: normal; orphans: 2;
      text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: 2; word-spacing: 0px;
      -webkit-text-stroke-width: 0px;"></span><br>
    <br>
    <blockquote type="cite" cite="mid:20180716141610.GA19679@wunner.de">
      <pre wrap="">
Lukas
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------D69288B88EA0274B82AF9C4A--

--===============0091299377==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0091299377==--
