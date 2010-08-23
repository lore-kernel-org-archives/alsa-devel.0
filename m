From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: [PATCH 1/1] mfd: add codec resource into 88pm860x
	driver
Date: Mon, 23 Aug 2010 18:24:50 +0800
Message-ID: <AANLkTimu5hFvdCgHkXniDqi4OF+fsFR=zj9Rje4Sx4Oi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e6daaffbfa18ad048e7b0ed9
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E266724485
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Aug 2010 12:24:53 +0200 (CEST)
Received: by wwb17 with SMTP id 17so23472wwb.20
	for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2010 03:24:53 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <sameo@linux.intel.com>, Samuel Ortiz <sameo@openedhand.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--0016e6daaffbfa18ad048e7b0ed9
Content-Type: text/plain; charset=ISO-8859-1

>From 28ed4af3929120b9b3853ffcb8055eb6a81d31d8 Mon Sep 17 00:00:00 2001
From: Haojian Zhuang <haojian.zhuang@marvell.com>
Date: Thu, 12 Aug 2010 11:59:33 +0800
Subject: [PATCH 1/1] mfd: add codec resource into 88pm860x driver

Add codec IRQ resources that are used in 88pm860x codec driver.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mfd/88pm860x-core.c |   44 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index 07933f3..4db10a1 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -158,6 +158,43 @@ static struct mfd_cell onkey_devs[] = {
 	},
 };

+static struct resource codec_resources[] = {
+	{
+		/* Headset microphone insertion or removal */
+		.name		= "micin",
+		.start		= PM8607_IRQ_MICIN,
+		.end		= PM8607_IRQ_MICIN,
+		.flags		= IORESOURCE_IRQ,
+	}, {
+		/* Hook-switch press or release */
+		.name		= "hook",
+		.start		= PM8607_IRQ_HOOK,
+		.end		= PM8607_IRQ_HOOK,
+		.flags		= IORESOURCE_IRQ,
+	}, {
+		/* Headset insertion or removal */
+		.name		= "headset",
+		.start		= PM8607_IRQ_HEADSET,
+		.end		= PM8607_IRQ_HEADSET,
+		.flags		= IORESOURCE_IRQ,
+	}, {
+		/* Audio short */
+		.name		= "audio-short",
+		.start		= PM8607_IRQ_AUDIO_SHORT,
+		.end		= PM8607_IRQ_AUDIO_SHORT,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct mfd_cell codec_devs[] = {
+	{
+		.name		= "88pm860x-codec",
+		.num_resources	= ARRAY_SIZE(codec_resources),
+		.resources	= &codec_resources[0],
+		.id		= -1,
+	},
+};
+
 static struct resource regulator_resources[] = {
 	PM8607_REG_RESOURCE(BUCK1, BUCK1),
 	PM8607_REG_RESOURCE(BUCK2, BUCK2),
@@ -687,6 +724,13 @@ static void __devinit device_8607_init(struct
pm860x_chip *chip,
 		goto out_dev;
 	}

+	ret = mfd_add_devices(chip->dev, 0, &codec_devs[0],
+			      ARRAY_SIZE(codec_devs),
+			      &codec_resources[0], 0);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to add codec subdev\n");
+		goto out_dev;
+	}
 	return;
 out_dev:
 	mfd_remove_devices(chip->dev);
-- 
1.5.6.5

--0016e6daaffbfa18ad048e7b0ed9
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-mfd-add-codec-resource-into-88pm860x-driver.patch"
Content-Disposition: attachment;
	filename="0001-mfd-add-codec-resource-into-88pm860x-driver.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gd76bllc0

RnJvbSAyOGVkNGFmMzkyOTEyMGI5YjM4NTNmZmNiODA1NWViNmE4MWQzMWQ4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFydmVs
bC5jb20+CkRhdGU6IFRodSwgMTIgQXVnIDIwMTAgMTE6NTk6MzMgKzA4MDAKU3ViamVjdDogW1BB
VENIIDEvMV0gbWZkOiBhZGQgY29kZWMgcmVzb3VyY2UgaW50byA4OHBtODYweCBkcml2ZXIKCkFk
ZCBjb2RlYyBJUlEgcmVzb3VyY2VzIHRoYXQgYXJlIHVzZWQgaW4gODhwbTg2MHggY29kZWMgZHJp
dmVyLgoKU2lnbmVkLW9mZi1ieTogSGFvamlhbiBaaHVhbmcgPGhhb2ppYW4uemh1YW5nQG1hcnZl
bGwuY29tPgotLS0KIGRyaXZlcnMvbWZkLzg4cG04NjB4LWNvcmUuYyB8ICAgNDQgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlcyBjaGFuZ2VkLCA0NCBp
bnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWZkLzg4
cG04NjB4LWNvcmUuYyBiL2RyaXZlcnMvbWZkLzg4cG04NjB4LWNvcmUuYwppbmRleCAwNzkzM2Yz
Li40ZGIxMGExIDEwMDY0NAotLS0gYS9kcml2ZXJzL21mZC84OHBtODYweC1jb3JlLmMKKysrIGIv
ZHJpdmVycy9tZmQvODhwbTg2MHgtY29yZS5jCkBAIC0xNTgsNiArMTU4LDQzIEBAIHN0YXRpYyBz
dHJ1Y3QgbWZkX2NlbGwgb25rZXlfZGV2c1tdID0gewogCX0sCiB9OwogCitzdGF0aWMgc3RydWN0
IHJlc291cmNlIGNvZGVjX3Jlc291cmNlc1tdID0geworCXsKKwkJLyogSGVhZHNldCBtaWNyb3Bo
b25lIGluc2VydGlvbiBvciByZW1vdmFsICovCisJCS5uYW1lCQk9ICJtaWNpbiIsCisJCS5zdGFy
dAkJPSBQTTg2MDdfSVJRX01JQ0lOLAorCQkuZW5kCQk9IFBNODYwN19JUlFfTUlDSU4sCisJCS5m
bGFncwkJPSBJT1JFU09VUkNFX0lSUSwKKwl9LCB7CisJCS8qIEhvb2stc3dpdGNoIHByZXNzIG9y
IHJlbGVhc2UgKi8KKwkJLm5hbWUJCT0gImhvb2siLAorCQkuc3RhcnQJCT0gUE04NjA3X0lSUV9I
T09LLAorCQkuZW5kCQk9IFBNODYwN19JUlFfSE9PSywKKwkJLmZsYWdzCQk9IElPUkVTT1VSQ0Vf
SVJRLAorCX0sIHsKKwkJLyogSGVhZHNldCBpbnNlcnRpb24gb3IgcmVtb3ZhbCAqLworCQkubmFt
ZQkJPSAiaGVhZHNldCIsCisJCS5zdGFydAkJPSBQTTg2MDdfSVJRX0hFQURTRVQsCisJCS5lbmQJ
CT0gUE04NjA3X0lSUV9IRUFEU0VULAorCQkuZmxhZ3MJCT0gSU9SRVNPVVJDRV9JUlEsCisJfSwg
eworCQkvKiBBdWRpbyBzaG9ydCAqLworCQkubmFtZQkJPSAiYXVkaW8tc2hvcnQiLAorCQkuc3Rh
cnQJCT0gUE04NjA3X0lSUV9BVURJT19TSE9SVCwKKwkJLmVuZAkJPSBQTTg2MDdfSVJRX0FVRElP
X1NIT1JULAorCQkuZmxhZ3MJCT0gSU9SRVNPVVJDRV9JUlEsCisJfSwKK307CisKK3N0YXRpYyBz
dHJ1Y3QgbWZkX2NlbGwgY29kZWNfZGV2c1tdID0geworCXsKKwkJLm5hbWUJCT0gIjg4cG04NjB4
LWNvZGVjIiwKKwkJLm51bV9yZXNvdXJjZXMJPSBBUlJBWV9TSVpFKGNvZGVjX3Jlc291cmNlcyks
CisJCS5yZXNvdXJjZXMJPSAmY29kZWNfcmVzb3VyY2VzWzBdLAorCQkuaWQJCT0gLTEsCisJfSwK
K307CisKIHN0YXRpYyBzdHJ1Y3QgcmVzb3VyY2UgcmVndWxhdG9yX3Jlc291cmNlc1tdID0gewog
CVBNODYwN19SRUdfUkVTT1VSQ0UoQlVDSzEsIEJVQ0sxKSwKIAlQTTg2MDdfUkVHX1JFU09VUkNF
KEJVQ0syLCBCVUNLMiksCkBAIC02ODcsNiArNzI0LDEzIEBAIHN0YXRpYyB2b2lkIF9fZGV2aW5p
dCBkZXZpY2VfODYwN19pbml0KHN0cnVjdCBwbTg2MHhfY2hpcCAqY2hpcCwKIAkJZ290byBvdXRf
ZGV2OwogCX0KIAorCXJldCA9IG1mZF9hZGRfZGV2aWNlcyhjaGlwLT5kZXYsIDAsICZjb2RlY19k
ZXZzWzBdLAorCQkJICAgICAgQVJSQVlfU0laRShjb2RlY19kZXZzKSwKKwkJCSAgICAgICZjb2Rl
Y19yZXNvdXJjZXNbMF0sIDApOworCWlmIChyZXQgPCAwKSB7CisJCWRldl9lcnIoY2hpcC0+ZGV2
LCAiRmFpbGVkIHRvIGFkZCBjb2RlYyBzdWJkZXZcbiIpOworCQlnb3RvIG91dF9kZXY7CisJfQog
CXJldHVybjsKIG91dF9kZXY6CiAJbWZkX3JlbW92ZV9kZXZpY2VzKGNoaXAtPmRldik7Ci0tIAox
LjUuNi41Cgo=
--0016e6daaffbfa18ad048e7b0ed9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0016e6daaffbfa18ad048e7b0ed9--
