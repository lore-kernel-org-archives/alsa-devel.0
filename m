From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC: let snd_soc_update_bits() return an
 error code
Date: Mon, 10 Jan 2011 13:35:45 -0600
Message-ID: <AANLkTinCYdOv9Kk5TH-p9ep_dY17wxUnG6qx0V6_C0BJ@mail.gmail.com>
References: <1294687713-16433-1-git-send-email-timur@freescale.com>
	<1294687713-16433-2-git-send-email-timur@freescale.com>
	<20110110192901.GA11684@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 558C9245D6
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 20:45:56 +0100 (CET)
Received: by fxm5 with SMTP id 5so18538542fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 11:45:56 -0800 (PST)
In-Reply-To: <20110110192901.GA11684@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: dp@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 10, 2011 at 1:29 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Jan 10, 2011 at 01:28:33PM -0600, Timur Tabi wrote:
>
>> + =A0 =A0 ret =3D old =3D snd_soc_read(codec, reg);
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>
> Please don't use multiple assignments in a single statement, it does
> nothing for legibility.

Bummer.  I really like that trick.  It's just so much more elegant than:

	ret =3D snd_soc_read(codec, reg);
	if (ret < 0)
		return ret;

	old =3D ret;

-- =

Timur Tabi
Linux kernel developer at Freescale
