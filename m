From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH v3] ASoC: Add support for cs42l73 codec
Date: Fri, 7 Oct 2011 02:13:32 +0000
Message-ID: <CAOZdJXV4+ZUZptZEjqwQugPmmav7wsXkw9ORrsVMPVzOTahc-g@mail.gmail.com>
References: <1317917945-32580-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE003.bigfish.com (va3ehsobe003.messaging.microsoft.com
	[216.32.180.13]) by alsa0.perex.cz (Postfix) with ESMTP id 1288224582
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 04:13:41 +0200 (CEST)
In-Reply-To: <1317917945-32580-1-git-send-email-brian.austin@cirrus.com>
Content-Language: en-US
Content-ID: <69B22C84B6540E4A917169D4728EF5F0@freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "heelrod@heelrod.ad.cirrus.com" <heelrod@heelrod.ad.cirrus.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "vinod.koul@linux.intel.com" <vinod.koul@linux.intel.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, Brian Austin <brian.austin@cirrus.com>, "ramesh.babu@intel.com" <ramesh.babu@intel.com>, "joe@nucleusys.com" <joe@nucleusys.com>, "lrg@ti.com" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 6, 2011 at 11:19 AM, Brian Austin <brian.austin@cirrus.com> wro=
te:

> +static const u8 cs42l73_reg[] =3D {
> +/*0*/ 0x00, 0x42, 0xA7, 0x30,
> +/*4*/ 0x00, 0x00, 0xF1, 0xDF,
> +/*8*/ 0x3F, 0x57, 0x53, 0x00,
> +/*C*/ 0x00, 0x15, 0x00, 0x15,
> +/*A*/ 0x00, 0x15, 0x00, 0x06,
> +/*E*/ 0x00, 0x00, 0x00, 0x00,
> +/*18*/ 0x00, 0x00, 0x00, 0x00,
> +/*1C*/ 0x00, 0x00, 0x00, 0x00,
> +/*20*/ 0x00, 0x00, 0x00, 0x00,
> +/*24*/ 0x00, 0x00, 0x00, 0x7F,
> +/*28*/ 0x00, 0x00, 0x3F, 0x00,
> +/*2C*/ 0x00, 0x3F, 0x00, 0x00,
> +/*30*/ 0x3F, 0x00, 0x00, 0x00,
> +/*34*/ 0x18, 0x3F, 0x3F, 0x3F,
> +/*38*/ 0x3F, 0x3F, 0x3F, 0x3F,
> +/*3C*/ 0x3F, 0x3F, 0x3F, 0x3F,
> +/*40*/ 0x3F, 0x3F, 0x3F, 0x3F,
> +/*44*/ 0x3F, 0x3F, 0x3F, 0x3F,
> +/*48*/ 0x3F, 0x3F, 0x3F, 0x3F,
> +/*4C*/ 0x3F, 0x3F, 0x3F, 0x3F,
> +/*50*/ 0x3F, 0x3F, 0x3F, 0x3F,
> +/*54*/ 0x3F, 0xAA, 0x3F, 0x3F,
> +/*58*/ 0x3F, 0x3F, 0x3F, 0x3F,
> +/*5C*/ 0x3F, 0x3F, 0x00, 0x00,
> +/*60*/ 0x00, 0x00
> +};

The comments should go on the right side, not the left.


> +static struct cs42l73_mclkx_div cs42l73_mclkx_coeffs[] =3D {
> + =A0 =A0 =A0 {5644800, =A01, 0}, =A0 =A0 =A0 /* 5644800 */
> + =A0 =A0 =A0 {6000000, =A01, 0}, =A0 =A0 =A0 /* 6000000 */
> + =A0 =A0 =A0 {6144000, =A01, 0}, =A0 =A0 =A0 /* 6144000 */
> + =A0 =A0 =A0 {11289600, 2, 2}, =A0 =A0 =A0 /* 5644800 */
> + =A0 =A0 =A0 {12288000, 2, 2}, =A0 =A0 =A0 /* 6144000 */
> + =A0 =A0 =A0 {12000000, 2, 2}, =A0 =A0 =A0 /* 6000000 */
> + =A0 =A0 =A0 {13000000, 2, 2}, =A0 =A0 =A0 /* 6500000 */
> + =A0 =A0 =A0 {19200000, 3, 3}, =A0 =A0 =A0 /* 6400000 */
> + =A0 =A0 =A0 {24000000, 4, 4}, =A0 =A0 =A0 /* 6000000 */
> + =A0 =A0 =A0 {26000000, 4, 4}, =A0 =A0 =A0 /* 6500000 */
> + =A0 =A0 =A0 {38400000, 6, 5} =A0 =A0 =A0 =A0/* 6400000 */

What do these comments mean?

In fact, I think there should be more comments in this file overall.
For example, almost none of the functions are commented.

> +/* I2C Registers */
> +/* I2C Address: 1001010[R/W] - 10010100 =3D 0x94(Write); 10010101 =3D 0x=
95(Read) */

This chip has separate I2C addresses for reading and writing?

-- =

Timur Tabi
Linux kernel developer at Freescale
