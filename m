From: Dan Sharon <dansharon-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>
Subject: Re: ALSA issue on DA850/OMAP-L138/AM18x
Date: Tue, 18 Jan 2011 14:02:21 -0500
Message-ID: <AANLkTi=X3KRngiNz5iQzojh_-h4W-iRDsbq8Hvy6Lm1x@mail.gmail.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59302484734E0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1064110728=="
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59302484734E0-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: "Rajashekhara, Sudhakar" <sudhakar.raj-l0cyMroinI0@public.gmane.org>
Cc: "khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org" <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

--===============1064110728==
Content-Type: multipart/alternative; boundary=000e0cd6ac8851bc6c049a238af7

--000e0cd6ac8851bc6c049a238af7
Content-Type: text/plain; charset=ISO-8859-1

These patches apply cleanly to 'v2.6.37'
3c0eee3fe6a3a1c745379547c7e7c904aa64f6d5
of git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-davinci.git.

The kernel was built with the 'da8xx_omapl_defconfig' from the omap-l1tree,
and 'make menuconfig' to enable ASoC (the defconfig already has
CONFIG_REGULATOR=y, CONFIG_REGULATOR_DUMMY=y, and
CONFIG_REGULATOR_TPS6507X=y).

Testing was done on a da850evm by tftp'ing the kernel into ram, and using
the
SPI-flash-based rootfs from the PSP that shipped with the board.

Using 'arecord -r 48000 -c 2 -f S32_BE -t raw -v -d 1 > /tmp/arecord.cap'
produced
a file of 384000 bytes (48000 x 2 x 4 bytes/sample).
'arecord -r 48000 -c 2 -f S32_BE -t raw -v > /dev/null' ran flawlessly for
several hours.

I was not able to reproduce Sudhakar's problems with 'arecord -f dat | aplay
-f dat'.

Tested-by: Dan Sharon <dansharon-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org <bengardiner-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>
>

Regards,
Dan Sharon


On Mon, Jan 17, 2011 at 11:43 PM, Rajashekhara, Sudhakar <
sudhakar.raj-l0cyMroinI0@public.gmane.org> wrote:

> Resending with proper $SUBJECT...
>
> Hi,
>
> I was testing Audio with 2.6.37 on DA850 from Kevin Hilman Linux tree
> at [1] and found that audio is broken. Below patch fixes the issue.
>
> ---
> From: Rajashekhara, Sudhakar <sudhakar.raj-l0cyMroinI0@public.gmane.org>
>
> davinci: fixes for audio on da850/omap-l138/am18x
>
> On DA850/OMAP-L138/AM18x, AIC3x codec is at 0x18 slave address.
> But in sound/soc/davinci/davinci-evm.c file, "struct snd_soc_dai_link"
> has the wrong AIC3x codec slave address. This patch fixes this issue.
>
> Also, this patch registers the platform device for davinci-pcm-audio.
>
> Signed-off-by: Rajashekhara, Sudhakar <sudhakar.raj-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/mach-davinci/devices-da8xx.c |   12 ++++++++++++
>  sound/soc/davinci/davinci-evm.c       |    2 +-
>  2 files changed, 13 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/devices-da8xx.c
> b/arch/arm/mach-davinci/devices-da8xx.c
> index 9eec630..17c0dbc 100644
> --- a/arch/arm/mach-davinci/devices-da8xx.c
> +++ b/arch/arm/mach-davinci/devices-da8xx.c
> @@ -473,6 +473,11 @@ static struct resource da850_mcasp_resources[] = {
>        },
>  };
>
> +struct platform_device davinci_pcm_device = {
> +       .name   = "davinci-pcm-audio",
> +       .id     = -1,
> +};
> +
>  static struct platform_device da850_mcasp_device = {
>        .name           = "davinci-mcasp",
>        .id             = 0,
> @@ -480,8 +485,15 @@ static struct platform_device da850_mcasp_device = {
>        .resource       = da850_mcasp_resources,
>  };
>
> +static void davinci_init_pcm(void)
> +{
> +       platform_device_register(&davinci_pcm_device);
> +}
> +
>  void __init da8xx_register_mcasp(int id, struct snd_platform_data *pdata)
>  {
> +       davinci_init_pcm();
> +
>        /* DA830/OMAP-L137 has 3 instances of McASP */
>        if (cpu_is_davinci_da830() && id == 1) {
>                da830_mcasp1_device.dev.platform_data = pdata;
> diff --git a/sound/soc/davinci/davinci-evm.c
> b/sound/soc/davinci/davinci-evm.c
> index bc9e6b0..07db881 100644
> --- a/sound/soc/davinci/davinci-evm.c
> +++ b/sound/soc/davinci/davinci-evm.c
> @@ -224,7 +224,7 @@ static struct snd_soc_dai_link da8xx_evm_dai = {
>        .stream_name = "AIC3X",
>        .cpu_dai_name= "davinci-mcasp.0",
>        .codec_dai_name = "tlv320aic3x-hifi",
> -       .codec_name = "tlv320aic3x-codec.0-001a",
> +       .codec_name = "tlv320aic3x-codec.1-0018",
>        .platform_name = "davinci-pcm-audio",
>        .init = evm_aic3x_init,
>        .ops = &evm_ops,
> ---
>
> Also, I found that either CONFIG_REGULATOR should not be defined or if
> CONFIG_REGULATOR is defined then CONFIG_REGULATOR_DUMMY should also be
> defined. Without this menuconfig fix, Soundcard does not get detected.
>
> With the above fixes, arecord and aplay does not work for the first time.
> Couple of times I get the below error:
>
> root@da850-omapl138-evm:~# arecord -f dat | aplay -f dat
> arecord: main:608: audio open error: Invalid argument
> aplay: playback:2297: read error
> root@da850-omapl138-evm:~# arecord -f dat | aplay -f dat
> aplay: main:608: audio open error: Invalid argument
> Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
>
> Third time arecord and aplay work normally.
>
> Has anyone seen such issues on DA850 or any other platform?
>
> I am currently debugging this issue. I'll submit the above patch to
> community
> once the issue of fixed.
>
> [1]
> http://git.kernel.org/?p=linux/kernel/git/khilman/linux-davinci.git;a=summary
>
> Regards,
> Sudhakar
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
>

--000e0cd6ac8851bc6c049a238af7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<span></span>These patches apply cleanly to &#39;v2.6.37&#39; <br>3c0eee3fe=
6a3a1c745379547c7e7c904aa64f6d5<br><div id=3D":1ma"><div>
of git://<a href=3D"http://git.kernel.org/pub/scm/linux/kernel/git/khilman/=
linux-davinci.git" target=3D"_blank">git.kernel.org/pub/scm/linux/kernel/gi=
t/khilman/linux-davinci.git</a>.<br><br>The kernel was built with the &#39;=
da8xx_omapl_defconfig&#39; from the omap-l1tree,<br>


and &#39;make menuconfig&#39; to enable ASoC (the defconfig already has<br>=
CONFIG_REGULATOR=3Dy, CONFIG_REGULATOR_DUMMY=3Dy, and<br>CONFIG_REGULATOR_T=
PS6507X=3Dy).<br>
<br>
T<span>esting was done</span> on a da850evm by tftp&#39;ing the kernel into=
 ram, and using the <br>SPI-flash-based rootfs from the PSP that shipped wi=
th the board.<br><br>Using &#39;arecord -r 48000 -c 2 -f S32_BE -t raw -v -=
d 1 &gt; /tmp/arecord.cap&#39; produced<br>

a file of 384000 bytes (48000 x 2 x 4 bytes/sample).=A0 <br>&#39;arecord -r=
 48000 -c 2 -f S32_BE -t raw -v &gt; /dev/null&#39; ran flawlessly for seve=
ral hours.<br><br>I was not able to reproduce Sudhakar&#39;s problems with =
&#39;arecord -f dat | aplay -f dat&#39;.<br>


<br><span>Tested</span>-<span>by</span>: <span>Dan Sharon </span>&lt;<a hre=
f=3D"mailto:bengardiner-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org" target=3D"_blank">dansharon@nanomet=
rics.ca</a>&gt;<br>

<br>Regards,<br><font color=3D"#888888">
<span>Dan Sharon</span></font></div></div><br><br><div class=3D"gmail_quote=
">On Mon, Jan 17, 2011 at 11:43 PM, Rajashekhara, Sudhakar <span dir=3D"ltr=
">&lt;<a href=3D"mailto:sudhakar.raj-l0cyMroinI0@public.gmane.org">sudhakar.raj-l0cyMroinI0@public.gmane.org</a>&gt;</s=
pan> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">Resending with pr=
oper $SUBJECT...<br>
<br>
Hi,<br>
<br>
I was testing Audio with 2.6.37 on DA850 from Kevin Hilman Linux tree<br>
at [1] and found that audio is broken. Below patch fixes the issue.<br>
<br>
---<br>
From: Rajashekhara, Sudhakar &lt;<a href=3D"mailto:sudhakar.raj-l0cyMroinI0@public.gmane.org">sud=
hakar.raj-l0cyMroinI0@public.gmane.org</a>&gt;<br>
<br>
davinci: fixes for audio on da850/omap-l138/am18x<br>
<br>
On DA850/OMAP-L138/AM18x, AIC3x codec is at 0x18 slave address.<br>
But in sound/soc/davinci/davinci-evm.c file, &quot;struct snd_soc_dai_link&=
quot;<br>
has the wrong AIC3x codec slave address. This patch fixes this issue.<br>
<br>
Also, this patch registers the platform device for davinci-pcm-audio.<br>
<br>
Signed-off-by: Rajashekhara, Sudhakar &lt;<a href=3D"mailto:sudhakar.raj@ti=
.com">sudhakar.raj-l0cyMroinI0@public.gmane.org</a>&gt;<br>
---<br>
=A0arch/arm/mach-davinci/devices-da8xx.c | =A0 12 ++++++++++++<br>
=A0sound/soc/davinci/davinci-evm.c =A0 =A0 =A0 | =A0 =A02 +-<br>
=A02 files changed, 13 insertions(+), 1 deletions(-)<br>
<br>
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/=
devices-da8xx.c<br>
index 9eec630..17c0dbc 100644<br>
--- a/arch/arm/mach-davinci/devices-da8xx.c<br>
+++ b/arch/arm/mach-davinci/devices-da8xx.c<br>
@@ -473,6 +473,11 @@ static struct resource da850_mcasp_resources[] =3D {<b=
r>
 =A0 =A0 =A0 =A0},<br>
=A0};<br>
<br>
+struct platform_device davinci_pcm_device =3D {<br>
+ =A0 =A0 =A0 .name =A0 =3D &quot;davinci-pcm-audio&quot;,<br>
+ =A0 =A0 =A0 .id =A0 =A0 =3D -1,<br>
+};<br>
+<br>
=A0static struct platform_device da850_mcasp_device =3D {<br>
 =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D &quot;davinci-mcasp&quot;,<br=
>
 =A0 =A0 =A0 =A0.id =A0 =A0 =A0 =A0 =A0 =A0 =3D 0,<br>
@@ -480,8 +485,15 @@ static struct platform_device da850_mcasp_device =3D {=
<br>
 =A0 =A0 =A0 =A0.resource =A0 =A0 =A0 =3D da850_mcasp_resources,<br>
=A0};<br>
<br>
+static void davinci_init_pcm(void)<br>
+{<br>
+ =A0 =A0 =A0 platform_device_register(&amp;davinci_pcm_device);<br>
+}<br>
+<br>
=A0void __init da8xx_register_mcasp(int id, struct snd_platform_data *pdata=
)<br>
=A0{<br>
+ =A0 =A0 =A0 davinci_init_pcm();<br>
+<br>
 =A0 =A0 =A0 =A0/* DA830/OMAP-L137 has 3 instances of McASP */<br>
 =A0 =A0 =A0 =A0if (cpu_is_davinci_da830() &amp;&amp; id =3D=3D 1) {<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0da830_mcasp1_device.dev.platform_data =3D p=
data;<br>
diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-ev=
m.c<br>
index bc9e6b0..07db881 100644<br>
--- a/sound/soc/davinci/davinci-evm.c<br>
+++ b/sound/soc/davinci/davinci-evm.c<br>
@@ -224,7 +224,7 @@ static struct snd_soc_dai_link da8xx_evm_dai =3D {<br>
 =A0 =A0 =A0 =A0.stream_name =3D &quot;AIC3X&quot;,<br>
 =A0 =A0 =A0 =A0.cpu_dai_name=3D &quot;davinci-mcasp.0&quot;,<br>
 =A0 =A0 =A0 =A0.codec_dai_name =3D &quot;tlv320aic3x-hifi&quot;,<br>
- =A0 =A0 =A0 .codec_name =3D &quot;tlv320aic3x-codec.0-001a&quot;,<br>
+ =A0 =A0 =A0 .codec_name =3D &quot;tlv320aic3x-codec.1-0018&quot;,<br>
 =A0 =A0 =A0 =A0.platform_name =3D &quot;davinci-pcm-audio&quot;,<br>
 =A0 =A0 =A0 =A0.init =3D evm_aic3x_init,<br>
 =A0 =A0 =A0 =A0.ops =3D &amp;evm_ops,<br>
---<br>
<br>
Also, I found that either CONFIG_REGULATOR should not be defined or if<br>
CONFIG_REGULATOR is defined then CONFIG_REGULATOR_DUMMY should also be<br>
defined. Without this menuconfig fix, Soundcard does not get detected.<br>
<br>
With the above fixes, arecord and aplay does not work for the first time.<b=
r>
Couple of times I get the below error:<br>
<br>
root@da850-omapl138-evm:~# arecord -f dat | aplay -f dat<br>
arecord: main:608: audio open error: Invalid argument<br>
aplay: playback:2297: read error<br>
root@da850-omapl138-evm:~# arecord -f dat | aplay -f dat<br>
aplay: main:608: audio open error: Invalid argument<br>
Recording WAVE &#39;stdin&#39; : Signed 16 bit Little Endian, Rate 48000 Hz=
, Stereo<br>
<br>
Third time arecord and aplay work normally.<br>
<br>
Has anyone seen such issues on DA850 or any other platform?<br>
<br>
I am currently debugging this issue. I&#39;ll submit the above patch to com=
munity<br>
once the issue of fixed.<br>
<br>
[1] <a href=3D"http://git.kernel.org/?p=3Dlinux/kernel/git/khilman/linux-da=
vinci.git;a=3Dsummary" target=3D"_blank">http://git.kernel.org/?p=3Dlinux/k=
ernel/git/khilman/linux-davinci.git;a=3Dsummary</a><br>
<br>
Regards,<br>
Sudhakar<br>
_______________________________________________<br>
Davinci-linux-open-source mailing list<br>
<a href=3D"mailto:Davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org">Davinci-l=
inux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org</a><br>
<a href=3D"http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-=
source" target=3D"_blank">http://linux.davincidsp.com/mailman/listinfo/davi=
nci-linux-open-source</a><br>
_______________________________________________<br>
Davinci-linux-open-source mailing list<br>
<a href=3D"mailto:Davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org">Davinci-l=
inux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org</a><br>
<a href=3D"http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-=
source" target=3D"_blank">http://linux.davincidsp.com/mailman/listinfo/davi=
nci-linux-open-source</a><br>
</blockquote></div><br>

--000e0cd6ac8851bc6c049a238af7--

--===============1064110728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1064110728==--
