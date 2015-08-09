From: Yakir Yang <ykk@rock-chips.com>
Subject: Re: [PATCH v5 4/6] drm: bridge/dw_hdmi-i2s-audio: add audio driver
Date: Sun, 9 Aug 2015 14:17:03 +0800
Message-ID: <55C6F05F.1030003@rock-chips.com>
References: <1434730417-10629-1-git-send-email-ykk@rock-chips.com>
 <1434731295-11060-1-git-send-email-ykk@rock-chips.com>
 <20150808153540.GL7557@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0052308134=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20150808153540.GL7557@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, Andy Yan <andy.yan@rock-chips.com>, Jaroslav Kysela <perex@perex.cz>, Paul Bolle <pebolle@tiscali.nl>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--===============0052308134==
Content-Type: multipart/alternative;
 boundary="------------080403040900080003010308"

This is a multi-part message in MIME format.
--------------080403040900080003010308
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Russell,

=E5=9C=A8 2015/8/8 23:35, Russell King - ARM Linux =E5=86=99=E9=81=93:
> On Sat, Jun 20, 2015 at 12:28:15AM +0800, Yakir Yang wrote:
>> Add ALSA based HDMI I2S audio driver for dw_hdmi. Sound card
>> driver could connect to this codec through the codec dai name
>> "dw-hdmi-i2s-audio".
> I'm applying this patch to my tree with some changes.  I haven't seen
> anyone ack it, nor review it any further.  I'm hoping someone can ack
> this patch with the following changes below - I'll be posting it as
> part of my dw-hdmi devel updates later today.
Aha, wow !!!
I'm so happy now :-D, many thanks for your improved and applay.

- Yakir

>> +	ret =3D request_irq(dw->data.irq, snd_dw_hdmi_irq, IRQF_SHARED,
>> +			  "dw-dw-audio", dw);
> 			  DRIVER_NAME, dw);
>
>> +MODULE_AUTHOR("Yakir Yang <ykk@rock-chips.com>");
>> +MODULE_DESCRIPTION("DW dw Audio ASoC Interface");
> Fixing this to be "Synopsis DesignWare HDMI I2S ASoC interface".
>
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_ALIAS(PLATFORM_MODULE_PREFIX DRIVER_NAME);
> Replacing PLATFORM_MODULE_PREFIX with the "platform:" string.
>
>> +	if (hdmi_readb(hdmi, HDMI_CONFIG1_ID) & HDMI_CONFIG1_AHB) {
>>   		pdevinfo.name =3D "dw-hdmi-ahb-audio";
> Fixing this to be "dw-hdmi-i2s-audio".
>


--------------080403040900080003010308
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3DUTF-8" http-equiv=3D"Content-Ty=
pe">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    Hi Russell,<br>
    <br>
    <div class=3D"moz-cite-prefix">=E5=9C=A8 2015/8/8 23:35, Russell King=
 - ARM
      Linux =E5=86=99=E9=81=93:<br>
    </div>
    <blockquote cite=3D"mid:20150808153540.GL7557@n2100.arm.linux.org.uk"
      type=3D"cite">
      <pre wrap=3D"">On Sat, Jun 20, 2015 at 12:28:15AM +0800, Yakir Yang=
 wrote:
</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"">Add ALSA based HDMI I2S audio driver for dw_hdmi. =
Sound card
driver could connect to this codec through the codec dai name
"dw-hdmi-i2s-audio".
</pre>
      </blockquote>
      <pre wrap=3D"">
I'm applying this patch to my tree with some changes.  I haven't seen
anyone ack it, nor review it any further.  I'm hoping someone can ack
this patch with the following changes below - I'll be posting it as
part of my dw-hdmi devel updates later today.
</pre>
    </blockquote>
    Aha, wow !!!=C2=A0 <br>
    I'm so happy now :-D<span style=3D"color: rgb(51, 51, 51);
      font-family: arial, =E5=AE=8B=E4=BD=93, sans-serif; font-size: 14px=
; font-style:
      normal; font-variant: normal; font-weight: normal; letter-spacing:
      normal; line-height: 24px; orphans: auto; text-align: start;
      text-indent: 28px; text-transform: none; white-space: normal;
      widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px;
      display: inline !important; float: none; background-color:
      rgb(255, 255, 255);"></span> , many thanks for your improved and
    applay.<br>
    <br>
    - Yakir<br>
    <br>
    <blockquote cite=3D"mid:20150808153540.GL7557@n2100.arm.linux.org.uk"
      type=3D"cite">
      <pre wrap=3D"">
</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"">+	ret =3D request_irq(dw-&gt;data.irq, snd_dw_hdmi=
_irq, IRQF_SHARED,
+			  "dw-dw-audio", dw);
</pre>
      </blockquote>
      <pre wrap=3D"">
			  DRIVER_NAME, dw);

</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"">+MODULE_AUTHOR("Yakir Yang <a class=3D"moz-txt-lin=
k-rfc2396E" href=3D"mailto:ykk@rock-chips.com">&lt;ykk@rock-chips.com&gt;=
</a>");
+MODULE_DESCRIPTION("DW dw Audio ASoC Interface");
</pre>
      </blockquote>
      <pre wrap=3D"">
Fixing this to be "Synopsis DesignWare HDMI I2S ASoC interface".

</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"">+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS(PLATFORM_MODULE_PREFIX DRIVER_NAME);
</pre>
      </blockquote>
      <pre wrap=3D"">
Replacing PLATFORM_MODULE_PREFIX with the "platform:" string.

</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"">+	if (hdmi_readb(hdmi, HDMI_CONFIG1_ID) &amp; HDMI=
_CONFIG1_AHB) {
 		pdevinfo.name =3D "dw-hdmi-ahb-audio";
</pre>
      </blockquote>
      <pre wrap=3D"">
Fixing this to be "dw-hdmi-i2s-audio".

</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------080403040900080003010308--


--===============0052308134==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK

--===============0052308134==--
