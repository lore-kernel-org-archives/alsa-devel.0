From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: Update on TLV320AIC3204 Driver
Date: Tue, 15 Jun 2010 16:42:32 +0300
Message-ID: <201006151642.32385.peter.ujfalusi@nokia.com>
References: <20100611055512.GG23431@www.longlandclan.yi.org>
	<20100615002734.GB7759@www.longlandclan.yi.org>
	<20100615051110.GG7759@www.longlandclan.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 693111038B8
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Jun 2010 15:42:57 +0200 (CEST)
In-Reply-To: <20100615051110.GG7759@www.longlandclan.yi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Eric B??nard <eric@eukrea.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, ext Stuart Longland <redhatter@gentoo.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Tuesday 15 June 2010 08:11:10 ext Stuart Longland wrote:
> Okay, I've had a close inspection of how the SOC_DOUBLE_R_SX_TLV widgets
> are implemented.  I couldn't find where in the git trees the control had
> been added, I wound up applying this patch myself in my tree... it
> apparently got applied in the official trees, but I cannot find it.

I'm not really sure what the SOC_DOUBLE_R_SX_TLV is for... =

But would a simple SOC_DOUBLE_R_TLV enough for the aic3204 codec?
I have not looked at the datasheet (if it is available), but I'll try to fi=
nd =

it.
Well looking at the _2r_sx functions in soc-core.c does not really clears t=
he =

intention, but at least I can see several things in the snd_soc_put_volsw_2=
r_sx =

function, which can cause problems:
- in error case it returns 0,
- instead of updating the bits, it rewrites the register, which I think wil=
l =

erase bits, which it should not touch.
- it has the ret variable, but it is not really used, and when it got assig=
ned, =

than it gets 1 in the success case. But luckily the return at the end of th=
e =

function is not using the ret, but 0.
- I'm not really sure if the 0xff masking is needed at all in the _sx funct=
ions, =

since the values are masked with the mask anyways.

So I do not really follow what these suppose to do... Can someone give an =

example of HW register, and the SX combination with the tlv struct? =

 =

-- =

P=E9ter
