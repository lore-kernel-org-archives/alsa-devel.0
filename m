From: dustin@seznam.cz
Subject: Patch - Revo7.1 PCM Playback Switch
Date: Fri, 18 May 2007 22:53:50 +0200 (CEST)
Message-ID: <9723.25254-1219-662959343-1179521630@seznam.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="MessagePart:1503661524.0-1219-786373941-1179521630"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mxh.seznam.cz (mxhn.seznam.cz [212.80.76.26])
	by alsa0.perex.cz (Postfix) with SMTP id 8ABBF2439A
	for <alsa-devel@alsa-project.org>;
	Fri, 18 May 2007 22:53:53 +0200 (CEST)
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
Cc: =?us-ascii?Q?Takashi=20Iwai?= <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--MessagePart:1503661524.0-1219-786373941-1179521630
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="us-ascii"

Hello Takashi,

I have attached a patch to support mute for front channels of M-Audio Revolution 7.1 (the DAC AK4381 features a mute bit).

Signed-off-by: Pavel Hofman <dustin at seznam.cz>

Please could I ask you for your opinion on the following issue (so far no response):

I am working together with Ctirad on supporting more capture channels in E-MU1212. So far we have managed to increase the number of channels from the default of 8 to 16 (A_FXWC2 = 0xffffffff, added new snd_emu10k1_audigy_dsp_convert_32_to_2x16 calls in emufx.c). There is still a number of issues to solve but the 16 channel capture already works fine.

I would like to get your opinion on the form of adding this support to the module. The options are either hard-coding the 16 capture channels into the code, assuming that users would prefer as many channels as possible and do the routing in jack, or introducing a module parameter emu1010-capture-channels (range e.g. 1 to 16 - untested yet) and leaving the default number at the existing 8.

Furthermore, the PCMs other than efx seem to be of no use for the EMU-1x1x models, probably fairly confusing for new users. Would you find it OK, if they were removed for this specific card (if (emu->card_capabilities->emu1010)), keeping only the playback and capture PCM id 2?

Thanks a lot for your suggestions. Based on them, I will prepare the patch (with comments on what we found out about the card - it is a pitty that the driver has almost no big-picture comments on the supported cards' specifics, making new developers spend a number of long nights going through the nontrivial code and guessing).

Best regards,

Pavel.
--MessagePart:1503661524.0-1219-786373941-1179521630
Content-Transfer-Encoding: base64
Content-Type: application/gzip;
	name="=?us-ascii?Q?revo=2Ediff=2Egz?=";
	charset="us-ascii"
Content-Disposition: attachment;
	filename="=?us-ascii?Q?revo=2Ediff=2Egz?="

H4sICN4PTkYAA3Jldm8uZGlmZgCdVm1v2kgQ/gy/YpKTIggGbCe8NAlVETi96EobAZc7KaqsxV6H
FbBGa5uQa/Lfb2ZtiBOSUvUL652dZ95f8EUQQFVBozVp2QH/YJrNNgjbq4fxlKs6m52u1+sq831W
84rVahVY/Z3XwniawIA9gNUC88PZqXl22gLbNFtQMfEoVioVmLwLvlQiBbfBtgncsPPgT5+getq2
jDZU0gMJUcxi4YGQMaSy3OhexN7UveNxKYpV4sUQSd8tQkHz+L6CDnT/cj87Y7fb7w9LMy+UsQrn
1Y9LJVYs5u6KzRNePs8g0VQE8TNm9OfV5XgvSMgVVznU1dcbZ/gzWLWQyEjcSe6DN2UKkI5ospzN
FtovcojNDHwWS0M7QrBipVA/hnsO4STiasUBwwol6+JCm12GiYghlPMHOK4j62/ogKOcOO1eAKXU
vTLeCqmQAxJGr8nWQ+1ZDYPB77iq6dut+R15SwTJSy3DQQfMc53fRrthNKFCh918leBJIua+6zPP
zZREuQwXAbUvxJor15uClgeFIFRorL/Wd6CPCyyT6keZLEhOdA5l+IFxoRgukphDJhgIOOSrcJ7E
IpTQqllQxVyenrStNJI6DCQqflhy6HRg9LXvZgz0XCgcHYHWRfYKGYS3G+O+17ISlWzBM/2FBV9E
GPyjmeT3BpgGROI/HgYlupcx7sRD3zURMA8Vkr7hjdsbf3GdL87Avbrs9hx3cPWvM8wxe2EiqQqt
HI15Ho+iXQndXs8Zjdyh0+3/M7waOzkIGYqA/d7k7UQmjck3JRFzPFhuOyxIy3Esk10OpL3ljpkS
MZOK34ko5gosQ9e/CaXR4O+xUz7Dzw7IUC2wAsMlV4yya2gcAFj4qKsgzXBmQb5RoZPmFru6921w
/W3kUHXVbYNUYdLMMjxSy6ftnhrElcq6zIvnLvaULhuPKd/YUlGRtck9m23yTSVG6AuUm+pVPE6U
BCRqjidqwH2VA6mggxfpg8dHOHgvoZu6hFf5P+x3e3CDPbHgh+dF/82lIb154vMXc326WRlvvf3i
wtgHxXVhNc7M5s66OKFpgr+tdJZs98Fm4ulpMmVS8jl5vJ+joEfnsa72dG5Q3GClwwI6Ulg+8Dxq
aXLRvMlkRJS5VEa+cXKiUjIJeTqnqYYP3X4P5myCaGBST28tijS9mYalJ+rC41bLsusKx9h2be8+
/FoCfo7D6J/YZ42d6FvtJga+QodlvxrmJKVhufhXAMtPvNjVwivCHz4PhOTUTFh1pTUFyVh7U6xL
2NRjSsRrLrpExvn/RIHLtOFMj+J9mSVzWpYbKFwAt7SlfuBKzpQfXvcGcD1nDxPmzTYNYIBNTamn
97ZB3mRMOV7aaBvZ1tEKnxNKHRYly2Wo4ohmkZB32TTKj9kdVSP9plU9GZu6+Q33o0QpXBl+FoH/
ARLFqXYYCgAA

--MessagePart:1503661524.0-1219-786373941-1179521630
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--MessagePart:1503661524.0-1219-786373941-1179521630--
