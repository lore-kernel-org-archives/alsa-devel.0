From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: CS4279 and hw_read_t/hw_write_t
Date: Mon, 21 Jul 2008 11:25:05 -0400
Message-ID: <9e4733910807210825r5d50adbem225cf83e31c21908@mail.gmail.com>
References: <9e4733910807210806v4caf49f1ke90cefda07b63579@mail.gmail.com>
	<4884A641.80304@freescale.com>
	<9e4733910807210816i624618fy8093dc2609e0922d@mail.gmail.com>
	<4884A8E0.3040907@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 830BB24356
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jul 2008 17:25:06 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 36so208335yxh.2
	for <alsa-devel@alsa-project.org>; Mon, 21 Jul 2008 08:25:05 -0700 (PDT)
In-Reply-To: <4884A8E0.3040907@freescale.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 7/21/08, Timur Tabi <timur@freescale.com> wrote:
> Jon Smirl wrote:
>
>  > You'd have to read the CS4270 datasheet in detail to see if can even
>  > be hooked up to an smbus controller. smbus is a subset of full i2c.
>
>
> There's no mention of SM Bus anywhere in the CS4270 datasheet.  Can I ass=
ume
>  that it won't work?

SMBus devices will work on an i2c controller. But i2c devices won't
always work on a smbus controller. i2c is a superset of smbus, it can
do things smbus can't.

SMbus (system management bus) is usually used for simple things like
fan and temperature monitors.

>From wikipedia on i2c:
"Pure I=B2C systems support arbitrary message structures. SMBus is
restricted to nine of those structures, such as "read word N" and
"write word N", involving a single slave."


>
>  I remember now trying to use a standard I2C-only function and it didn't =
work,
>  but that was a long time ago before I knew much about the hardware.  I'l=
l have
>  to try it again.
>
>
>  --
>
> Timur Tabi
>  Linux kernel developer at Freescale
>


-- =

Jon Smirl
jonsmirl@gmail.com
