From: Pau Rodriguez-Estivill <prodrigestivill@gmail.com>
Subject: Re: ALSA patch Nvidia 8 channel hdmi audio
Date: Wed, 1 Jul 2009 06:47:30 +0200
Message-ID: <b62dc2200906302147t87e6cb0j51e7c3ee881a9169@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001485f80f0af05936046d9d9e9d
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f226.google.com (mail-fx0-f226.google.com
	[209.85.220.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A2D72455E
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Jul 2009 06:47:32 +0200 (CEST)
Received: by fxm26 with SMTP id 26so579878fxm.32
	for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2009 21:47:30 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: pchen@nvidia.com, marek.vasut@gmail.com, wni@nvidia.com, alanwww1@gmail.com
List-Id: alsa-devel@alsa-project.org

--001485f80f0af05936046d9d9e9d
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I attach a patch to support 24bits and 32kHz, 44.1kHz, 48kHz, 96kHz,
192kHz, all rates that appears in the screenshot submitted by Alan
Alan.

I created also an asound.conf to correct the speakers positions.
Since current driver only support 2, 4, 6 and 8 channels I specified
it in the asound.conf but I'm not sure if this slave.channels should
be fixed.
The main problem is that by using asound.conf I didn't found any way
to route to surround51 (or surround50 or surround40, ...) depending of
the number of channels offered by the sink player.
And when I play directly to hdmi, the AMP reports automatically the
correct number of speakers involved.

Of course it would be nice to have this routes hardcoded in the driver...

--001485f80f0af05936046d9d9e9d
Content-Type: text/x-diff; charset=US-ASCII; name="nvhdmi-192khz.patch"
Content-Disposition: attachment; filename="nvhdmi-192khz.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fwljkity0

LS0tIGFsc2Eta2VybmVsL3BjaS9oZGEvcGF0Y2hfbnZoZG1pLmMub3JpZwkyMDA5LTA2LTI3IDEz
OjM4OjAxLjQ5MzQwNzI3OSArMDIwMAorKysgYWxzYS1rZXJuZWwvcGNpL2hkYS9wYXRjaF9udmhk
bWkuYwkyMDA5LTA3LTAxIDAyOjM0OjAwLjk2OTI2MDI0OCArMDIwMApAQCAtMjU4LDkgKzI1OCw5
IEBACiAJLmNoYW5uZWxzX21pbiA9IDIsCiAJLmNoYW5uZWxzX21heCA9IDgsCiAJLm5pZCA9IE52
X01hc3Rlcl9Db252ZXJ0X25pZCwKLQkucmF0ZXMgPSBTTkRSVl9QQ01fUkFURV80ODAwMCwKLQku
bWF4YnBzID0gMTYsCi0JLmZvcm1hdHMgPSBTTkRSVl9QQ01fRk1UQklUX1MxNl9MRSwKKwkucmF0
ZXMgPSBTTkRSVl9QQ01fUkFURV8zMjAwMCB8IFNORFJWX1BDTV9SQVRFXzQ0MTAwIHwgU05EUlZf
UENNX1JBVEVfNDgwMDAgfCBTTkRSVl9QQ01fUkFURV85NjAwMCB8IFNORFJWX1BDTV9SQVRFXzE5
MjAwMCwKKwkubWF4YnBzID0gMjQsCisJLmZvcm1hdHMgPSBTTkRSVl9QQ01fRk1UQklUX1MxNl9M
RSB8IFNORFJWX1BDTV9GTVRCSVRfUzMyX0xFLAogCS5vcHMgPSB7CiAJCS5vcGVuID0gbnZoZG1p
X2RpZ19wbGF5YmFja19wY21fb3BlbiwKIAkJLmNsb3NlID0gbnZoZG1pX2RpZ19wbGF5YmFja19w
Y21fY2xvc2VfOGNoLApAQCAtMjczLDcgKzI3Myw3IEBACiAJLmNoYW5uZWxzX21pbiA9IDIsCiAJ
LmNoYW5uZWxzX21heCA9IDIsCiAJLm5pZCA9IE52X01hc3Rlcl9Db252ZXJ0X25pZCwKLQkucmF0
ZXMgPSBTTkRSVl9QQ01fUkFURV80ODAwMCwKKwkucmF0ZXMgPSBTTkRSVl9QQ01fUkFURV8zMjAw
MCB8IFNORFJWX1BDTV9SQVRFXzQ0MTAwIHwgU05EUlZfUENNX1JBVEVfNDgwMDAsCiAJLm1heGJw
cyA9IDE2LAogCS5mb3JtYXRzID0gU05EUlZfUENNX0ZNVEJJVF9TMTZfTEUsCiAJLm9wcyA9IHsK
--001485f80f0af05936046d9d9e9d
Content-Type: application/octet-stream; name="asound.conf"
Content-Disposition: attachment; filename="asound.conf"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fwljkjk61

IyBMaW51eCBoYXMgY2hhbm5lbCBvcmRlcgojIEZMLCBGUiwgUkwsIFJSLCBDLCBMRkUsIFNMLCBT
UgojIEhETUkgaGFzIHRoaXMgb25lCiMgRkwsIEZSLCBMRkUsIEZDLCBSTCwgUlIsIFJMQywgUlJD
CgpwY20uIWZyb250IHsKICB0eXBlIHJvdXRlCiAgc2xhdmUucGNtIGhkbWkKICBzbGF2ZS5jaGFu
bmVscyAyCiAgdHRhYmxlIHsKICAgIDAuMD0gMQogICAgMS4xPSAxCiAgfQp9CnBjbS4hc3Vycm91
bmQyMSB7CiAgdHlwZSByb3V0ZQogIHNsYXZlLnBjbSBoZG1pCiAgc2xhdmUuY2hhbm5lbHMgNAog
IHR0YWJsZSB7CiAgICAwLjA9IDEKICAgIDEuMT0gMQogICAgMi4yPSAxCiAgfQp9CnBjbS4hc3Vy
cm91bmQzMCB7CiAgdHlwZSByb3V0ZQogIHNsYXZlLnBjbSBoZG1pCiAgc2xhdmUuY2hhbm5lbHMg
NAogIHR0YWJsZSB7CiAgICAwLjA9IDEKICAgIDEuMT0gMQogICAgMi4zPSAxCiAgfQp9CnBjbS4h
c3Vycm91bmQzMSB7CiAgdHlwZSByb3V0ZQogIHNsYXZlLnBjbSBoZG1pCiAgc2xhdmUuY2hhbm5l
bHMgNAogIHR0YWJsZSB7CiAgICAwLjA9IDEKICAgIDEuMT0gMQogICAgMi4zPSAxCiAgICAzLjI9
IDEKICB9Cn0KcGNtLiFzdXJyb3VuZDQwIHsKICB0eXBlIHJvdXRlCiAgc2xhdmUucGNtIGhkbWkK
ICBzbGF2ZS5jaGFubmVscyA2CiAgdHRhYmxlIHsKICAgIDAuMD0gMQogICAgMS4xPSAxCiAgICAy
LjQ9IDEKICAgIDMuNT0gMQogIH0KfQpwY20uIXN1cnJvdW5kNDEgewogIHR5cGUgcm91dGUKICBz
bGF2ZS5wY20gaGRtaQogIHNsYXZlLmNoYW5uZWxzIDYKICB0dGFibGUgewogICAgMC4wPSAxCiAg
ICAxLjE9IDEKICAgIDIuND0gMQogICAgMy41PSAxCiAgICA0LjI9IDEKICB9Cn0KcGNtLiFzdXJy
b3VuZDUwIHsKICB0eXBlIHJvdXRlCiAgc2xhdmUucGNtIGhkbWkKICBzbGF2ZS5jaGFubmVscyA2
CiAgdHRhYmxlIHsKICAgIDAuMD0gMQogICAgMS4xPSAxCiAgICAyLjQ9IDEKICAgIDMuNT0gMQog
ICAgNC4zPSAxCiAgfQp9CnBjbS4hc3Vycm91bmQ1MSB7CiAgdHlwZSByb3V0ZQogIHNsYXZlLnBj
bSBoZG1pCiAgc2xhdmUuY2hhbm5lbHMgNgogIHR0YWJsZSB7CiAgICAwLjA9IDEKICAgIDEuMT0g
MQogICAgMi40PSAxCiAgICAzLjU9IDEKICAgIDQuMz0gMQogICAgNS4yPSAxCiAgfQp9CnBjbS4h
c3Vycm91bmQ3MSB7CiAgdHlwZSByb3V0ZQogIHNsYXZlLnBjbSBoZG1pCiAgc2xhdmUuY2hhbm5l
bHMgOAogIHR0YWJsZSB7CiAgICAwLjA9IDEKICAgIDEuMT0gMQogICAgMi40PSAxCiAgICAzLjU9
IDEKICAgIDQuMz0gMQogICAgNS4yPSAxCiAgICA2LjY9IDEKICAgIDcuNz0gMQogIH0KfQo=
--001485f80f0af05936046d9d9e9d
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--001485f80f0af05936046d9d9e9d--
