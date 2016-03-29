From: Jose Abreu <Jose.Abreu@synopsys.com>
Subject: Re: [PATCH 2/3 v2] ASoC: dwc: Add I2S HDMI audio support
Date: Tue, 29 Mar 2016 19:03:01 +0100
Message-ID: <56FAC355.1040705@synopsys.com>
References: <cover.1459174494.git.joabreu@synopsys.com>
 <538be366488bf0d7633d702f2d0bab16707b7a47.1459174494.git.joabreu@synopsys.com>
 <20160329173158.GB2350@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0641152503=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20160329173158.GB2350@sirena.org.uk>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Mark Brown <broonie@kernel.org>, Jose Abreu <Jose.Abreu@synopsys.com>
Cc: tixy@linaro.org, mark.rutland@arm.com, alsa-devel@alsa-project.org, Alexey.Brodkin@synopsys.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, yitian.bu@tangramtek.com, wsa+renesas@sang-engineering.com, laurent.pinchart+renesas@ideasonboard.com, tiwai@suse.com, nariman@opensource.wolfsonmicro.com, linux-snps-arc@lists.infradead.org, devicetree@vger.kernel.org, Maruthi.Bayyavarapu@amd.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, Vineet.Gupta1@synopsys.com, buyitian@gmail.com, robh+dt@kernel.org, perex@perex.cz, lgirdwood@gmail.com, CARLOS.PALMINHA@synopsys.com, galak@codeaurora.org, alexander.deucher@amd.com
List-Id: alsa-devel@alsa-project.org

--===============0641152503==
Content-Type: multipart/alternative;
	boundary="------------030807040907080501060103"

--------------030807040907080501060103
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Mark,

On 29-03-2016 18:31, Mark Brown wrote:
> On Mon, Mar 28, 2016 at 03:36:10PM +0100, Jose Abreu wrote:
>> HDMI audio support was added to the AXS board using an
>> I2S cpu driver and a custom platform driver.
>>
>> The platform driver supports two channels @ 16 bits with
>> rates 32k, 44.1k and 48k. ALSA Simple audio card is used to
>> glue the cpu, platform and codec driver (adv7511).
>>  sound/soc/dwc/Kconfig          |   1 +
>>  sound/soc/dwc/designware_i2s.c | 385 +++++++++++++++++++++++++++++++++++++++--
> Your changelog appears to describe the writing of a machine driver but
> this is a large patch adding code to an I2S controller driver.  This
> means I can't review your patch since I can't tell what it is supposed
> to do.  If you've added functionality to this driver you need to send
> one or more patches each of which adds a single feature to the driver
> together with a changelog which describes what that feature is.
>
> Glancing at the patch I'm not 100% sure that the features you're adding
> are part of the Synopsis device but I'm not entirely sure.
>

The major part of this patch is the adding of an ALSA platform driver so that
audio comes out of the box in AXS boards but we also added functionalities to
the i2s driver and performed one bug fix related with the mask/unmask of
interrupts. I will split the patches but they will depend on each other.

>>  2 files changed, 373 insertions(+), 13 deletions(-)
>>
>> diff --git a/sound/soc/dwc/Kconfig b/sound/soc/dwc/Kconfig
>> index d50e085..bc3fae7 100644
>> --- a/sound/soc/dwc/Kconfig
>> +++ b/sound/soc/dwc/Kconfig
>> @@ -2,6 +2,7 @@ config SND_DESIGNWARE_I2S
>>  	tristate "Synopsys I2S Device Driver"
>>  	depends on CLKDEV_LOOKUP
>>  	select SND_SOC_GENERIC_DMAENGINE_PCM
>> +	select SND_SIMPLE_CARD
> No, this doesn't make sense - the fact that someone has used a Synopsis
> I2S controller doesn't mean that they have a system which uses
> simple-card.  If the user wants to use simple-card they need to enable
> it separately, this is the same pattern we follow for all CPU controller
> drivers.
>

I will remove this.

>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

Best regards,
Jose Miguel Abreu

--------------030807040907080501060103
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Hi Mark,<br>
    <br>
    <div class="moz-cite-prefix">On 29-03-2016 18:31, Mark Brown wrote:<br>
    </div>
    <blockquote cite="mid:20160329173158.GB2350@sirena.org.uk"
      type="cite">
      <pre wrap="">On Mon, Mar 28, 2016 at 03:36:10PM +0100, Jose Abreu wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">HDMI audio support was added to the AXS board using an
I2S cpu driver and a custom platform driver.

The platform driver supports two channels @ 16 bits with
rates 32k, 44.1k and 48k. ALSA Simple audio card is used to
glue the cpu, platform and codec driver (adv7511).
</pre>
      </blockquote>
      <pre wrap="">
</pre>
      <blockquote type="cite">
        <pre wrap=""> sound/soc/dwc/Kconfig          |   1 +
 sound/soc/dwc/designware_i2s.c | 385 +++++++++++++++++++++++++++++++++++++++--
</pre>
      </blockquote>
      <pre wrap="">
Your changelog appears to describe the writing of a machine driver but
this is a large patch adding code to an I2S controller driver.  This
means I can't review your patch since I can't tell what it is supposed
to do.  If you've added functionality to this driver you need to send
one or more patches each of which adds a single feature to the driver
together with a changelog which describes what that feature is.

Glancing at the patch I'm not 100% sure that the features you're adding
are part of the Synopsis device but I'm not entirely sure.

</pre>
    </blockquote>
    <br>
    The major part of this patch is the adding of an ALSA platform
    driver so that audio comes out of the box in AXS boards but we also
    added functionalities to the i2s driver and performed one bug fix
    related with the mask/unmask of interrupts. I will split the patches
    but they will depend on each other.<br>
    <br>
    <blockquote cite="mid:20160329173158.GB2350@sirena.org.uk"
      type="cite">
      <blockquote type="cite">
        <pre wrap=""> 2 files changed, 373 insertions(+), 13 deletions(-)

diff --git a/sound/soc/dwc/Kconfig b/sound/soc/dwc/Kconfig
index d50e085..bc3fae7 100644
--- a/sound/soc/dwc/Kconfig
+++ b/sound/soc/dwc/Kconfig
@@ -2,6 +2,7 @@ config SND_DESIGNWARE_I2S
 	tristate "Synopsys I2S Device Driver"
 	depends on CLKDEV_LOOKUP
 	select SND_SOC_GENERIC_DMAENGINE_PCM
+	select SND_SIMPLE_CARD
</pre>
      </blockquote>
      <pre wrap="">
No, this doesn't make sense - the fact that someone has used a Synopsis
I2S controller doesn't mean that they have a system which uses
simple-card.  If the user wants to use simple-card they need to enable
it separately, this is the same pattern we follow for all CPU controller
drivers.
</pre>
      <br>
    </blockquote>
    <br>
    I will remove this.<br>
    <br>
    <blockquote cite="mid:20160329173158.GB2350@sirena.org.uk"
      type="cite">
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
dri-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:dri-devel@lists.freedesktop.org">dri-devel@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/dri-devel">https://lists.freedesktop.org/mailman/listinfo/dri-devel</a>
</pre>
    </blockquote>
    <br>
    Best regards,<br>
    Jose Miguel Abreu<br>
  </body>
</html>

--------------030807040907080501060103--

--===============0641152503==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0641152503==--
