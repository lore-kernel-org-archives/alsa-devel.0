From: anish kumar <yesanishhere@gmail.com>
Subject: Re: [PATCH v3] ASoC: max98090: add shutdown callback
	for max98090
Date: Fri, 10 Apr 2015 17:50:55 -0700
Message-ID: <CABCoZhB-1nZA5-9YNfuxtNSJpa1bA-YcB4L5ZzEKBNzhZjdKfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=089e013c614c072b4205136846c1
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f46.google.com (mail-la0-f46.google.com
 [209.85.215.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 7705D26069E
 for <alsa-devel@alsa-project.org>; Sat, 11 Apr 2015 02:50:56 +0200 (CEST)
Received: by lagv1 with SMTP id v1so24038875lag.3
 for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2015 17:50:56 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: xjq@rock-chips.com, zhengxing@rock-chips.com, wxt@rock-chips.com
Cc: Maxwell McKinnon <Maxwell.McKinnon@maximintegrated.com>, Linux-ALSA <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, Nitin Mittal <nitin.mittal@maximintegrated.com>
List-Id: alsa-devel@alsa-project.org

--089e013c614c072b4205136846c1
Content-Type: text/plain; charset=UTF-8

On Fri, Apr 10, 2015 at 5:45 PM, anish singh
<anish198519851985@gmail.com> wrote:
>
> ---------- Forwarded message ----------
> From: Caesar Wang <wxt@rock-chips.com>
> Date: Wed, Apr 8, 2015 at 4:05 AM
> Subject: [PATCH v3] ASoC: max98090: add shutdown callback for max98090
> To: Sonny Rao <sonnyrao@chromium.org>, Cheng-Yi Chiang
> <cychiang@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Mark Brown
> <broonie@kernel.org>, zhengxing <zhengxing@rock-chips.com>, "jay.xu"
> <xjq@rock-chips.com>
> Cc: devicetree@vger.kernel.org, dianders@chromium.org,
> dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
> linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
> Caesar Wang <wxt@rock-chips.com>, Jaroslav Kysela <perex@perex.cz>,
> alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Dylan Reid
> <dgreid@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter
> Clausen <lars@metafoo.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>,
> Tushar Behera <tushar.b@samsung.com>
>
>
> To fix pop noise when shutdown,the pop noise during shutdown
> is the pmic cutoff power of codec without any notice.
>
> Signed-off-by: jay.xu <xjq@rock-chips.com>
> Signed-off-by: zhengxing <zhengxing@rock-chips.com>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>
> ---
>
> Changes in v3:
> - modify the shutdown function before remove(..)
> - fix the `Serien-cc`
>
> Changes in v2:
> - remove the dev_info(..)
> - fix the comment style
> - add the max98090_i2c_shutdown() in remove() fuction
>
>  sound/soc/codecs/max98090.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
> index b112b1c..3e33ef2 100644
> --- a/sound/soc/codecs/max98090.c
> +++ b/sound/soc/codecs/max98090.c
> @@ -2605,8 +2605,24 @@ err_enable:
>         return ret;
>  }
>

Please check attached patch and see if it solves your problem.
We tested it here with zcd on.

+static void max98090_i2c_shutdown(struct i2c_client *i2c)
+{
+       struct max98090_priv *max98090 = dev_get_drvdata(&i2c->dev);
+
+       dev_info(&i2c->dev, "shut down device\n");
+
+       /* enable zero crossing */
+       regmap_write(max98090->regmap,
+               M98090_REG_LEVEL_CONTROL, M98090_ZDENN_MASK-1);
+
+       /* turn down volume levels for all the outputs */
+       regmap_write(max98090->regmap,
+               M98090_REG_RCV_LOUTL_VOLUME, 0x00);
+       regmap_write(max98090->regmap,
+               M98090_REG_LOUTR_VOLUME, 0x00);
+       regmap_write(max98090->regmap,
+               M98090_REG_LEFT_SPK_VOLUME, 0x00);
+       regmap_write(max98090->regmap,
+               M98090_REG_RIGHT_SPK_VOLUME, 0x00);
+       regmap_write(max98090->regmap,
+               M98090_REG_LEFT_HP_VOLUME, 0x00);
+       regmap_write(max98090->regmap,
+               M98090_REG_RIGHT_HP_VOLUME, 0x00);
+       regmap_write(max98090->regmap,
+               M98090_REG_DEVICE_SHUTDOWN, 0x00);
+       msleep(40);
+}
+

if it doesn't solve your problem then please dump
your registers and send it to us to look further. I assume
dapm is turning off the widgets before shutting down
the codec.

> +static void max98090_i2c_shutdown(struct i2c_client *i2c)
> +{
> +       struct max98090_priv *max98090 = dev_get_drvdata(&i2c->dev);
> +
> +       /*
> +        * Enable volume smoothing, disable zero cross.  This will cause
> +        * a quick 40ms ramp to mute on shutdown.
> +        */
> +       regmap_write(max98090->regmap,
> +               M98090_REG_LEVEL_CONTROL, M98090_VSENN_MASK);
> +       regmap_write(max98090->regmap,
> +               M98090_REG_DEVICE_SHUTDOWN, 0x00);
> +       msleep(40);
> +}
> +
>  static int max98090_i2c_remove(struct i2c_client *client)
>  {
> +       max98090_i2c_shutdown(client);
>         snd_soc_unregister_codec(&client->dev);
>         return 0;
>  }
> @@ -2696,6 +2712,7 @@ static struct i2c_driver max98090_i2c_driver = {
>                 .acpi_match_table = ACPI_PTR(max98090_acpi_match),
>         },
>         .probe  = max98090_i2c_probe,
> +       .shutdown = max98090_i2c_shutdown,
>         .remove = max98090_i2c_remove,
>         .id_table = max98090_i2c_id,
>  };
> --
> 1.9.1
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--089e013c614c072b4205136846c1
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-To-fix-pop-noise-when-shutdown-the-pop-noise-during-.patch"
Content-Disposition: attachment;
	filename="0001-To-fix-pop-noise-when-shutdown-the-pop-noise-during-.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i8cb0mvx0

RnJvbSAzZTU3NjQ2NjkxZDRjYjYwZTJiNjI5NWE5YmRhNjRmZjhkMDYwNWM1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmlzaCBLdW1hciA8eWVzYW5pc2hoZXJlQGdtYWlsLmNvbT4K
RGF0ZTogRnJpLCAxMCBBcHIgMjAxNSAxNzo0MTozNiAtMDcwMApTdWJqZWN0OiBbUEFUQ0hdIFRv
IGZpeCBwb3Agbm9pc2Ugd2hlbiBzaHV0ZG93bix0aGUgcG9wIG5vaXNlIGR1cmluZyBzaHV0ZG93
bgogaXMgdGhlIHBtaWMgY3V0b2ZmIHBvd2VyIG9mIGNvZGVjIHdpdGhvdXQgYW55IG5vdGljZS4K
ClNpZ25lZC1vZmYtYnk6IEFuaXNoIEt1bWFyIDxhbmlzaC5rdW1hckBtYXhpbWludGVncmF0ZWQu
Y29tPgotLS0KIHNvdW5kL3NvYy9jb2RlY3MvbWF4OTgwOTAuYyB8IDI4ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspCgpkaWZmIC0t
Z2l0IGEvc291bmQvc29jL2NvZGVjcy9tYXg5ODA5MC5jIGIvc291bmQvc29jL2NvZGVjcy9tYXg5
ODA5MC5jCmluZGV4IGZjMTc2MDQuLjY1ZTI4ZjQgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9jb2Rl
Y3MvbWF4OTgwOTAuYworKysgYi9zb3VuZC9zb2MvY29kZWNzL21heDk4MDkwLmMKQEAgLTIzNDks
NiArMjM0OSwzNCBAQCBzdGF0aWMgaW50IG1heDk4MDkwX2kyY19yZW1vdmUoc3RydWN0IGkyY19j
bGllbnQgKmNsaWVudCkKIAlyZXR1cm4gMDsKIH0KIAorc3RhdGljIHZvaWQgbWF4OTgwOTBfaTJj
X3NodXRkb3duKHN0cnVjdCBpMmNfY2xpZW50ICppMmMpCit7CisJc3RydWN0IG1heDk4MDkwX3By
aXYgKm1heDk4MDkwID0gZGV2X2dldF9kcnZkYXRhKCZpMmMtPmRldik7CisKKwlkZXZfaW5mbygm
aTJjLT5kZXYsICJzaHV0IGRvd24gZGV2aWNlXG4iKTsKKworCS8qIGVuYWJsZSB6ZXJvIGNyb3Nz
aW5nICovCisJcmVnbWFwX3dyaXRlKG1heDk4MDkwLT5yZWdtYXAsCisJCU05ODA5MF9SRUdfTEVW
RUxfQ09OVFJPTCwgTTk4MDkwX1pERU5OX01BU0stMSk7CisKKwkvKiB0dXJuIGRvd24gdm9sdW1l
IGxldmVscyBmb3IgYWxsIHRoZSBvdXRwdXRzICovCisJcmVnbWFwX3dyaXRlKG1heDk4MDkwLT5y
ZWdtYXAsCisJCU05ODA5MF9SRUdfUkNWX0xPVVRMX1ZPTFVNRSwgMHgwMCk7CisJcmVnbWFwX3dy
aXRlKG1heDk4MDkwLT5yZWdtYXAsCisJCU05ODA5MF9SRUdfTE9VVFJfVk9MVU1FLCAweDAwKTsK
KwlyZWdtYXBfd3JpdGUobWF4OTgwOTAtPnJlZ21hcCwKKwkJTTk4MDkwX1JFR19MRUZUX1NQS19W
T0xVTUUsIDB4MDApOworCXJlZ21hcF93cml0ZShtYXg5ODA5MC0+cmVnbWFwLAorCQlNOTgwOTBf
UkVHX1JJR0hUX1NQS19WT0xVTUUsIDB4MDApOworCXJlZ21hcF93cml0ZShtYXg5ODA5MC0+cmVn
bWFwLAorCQlNOTgwOTBfUkVHX0xFRlRfSFBfVk9MVU1FLCAweDAwKTsKKwlyZWdtYXBfd3JpdGUo
bWF4OTgwOTAtPnJlZ21hcCwKKwkJTTk4MDkwX1JFR19SSUdIVF9IUF9WT0xVTUUsIDB4MDApOwor
CXJlZ21hcF93cml0ZShtYXg5ODA5MC0+cmVnbWFwLAorCQlNOTgwOTBfUkVHX0RFVklDRV9TSFVU
RE9XTiwgMHgwMCk7CisJbXNsZWVwKDQwKTsKK30KKwogc3RhdGljIGludCBtYXg5ODA5MF9ydW50
aW1lX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpCiB7CiAJc3RydWN0IG1heDk4MDkwX3ByaXYg
Km1heDk4MDkwID0gZGV2X2dldF9kcnZkYXRhKGRldik7Ci0tIAoxLjkuMwoK
--089e013c614c072b4205136846c1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--089e013c614c072b4205136846c1--
