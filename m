From: Timur Tabi <timur@freescale.com>
Subject: Re: [RFC 02/16] ASoC: multi-component - cs4720,
	cs42l51 	and da7210 CODECs
Date: Fri, 25 Jun 2010 13:29:00 -0500
Message-ID: <AANLkTinmu4myhe1dGuG_fEdQUpYKQ4bbN1xDCSWzmNWC@mail.gmail.com>
References: <1277488383-31287-1-git-send-email-lrg@slimlogic.co.uk>
	<1277488383-31287-3-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D3E2103820
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jun 2010 20:29:31 +0200 (CEST)
Received: by vws11 with SMTP id 11so945018vws.38
	for <alsa-devel@alsa-project.org>; Fri, 25 Jun 2010 11:29:30 -0700 (PDT)
In-Reply-To: <1277488383-31287-3-git-send-email-lrg@slimlogic.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 25, 2010 at 12:52 PM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:

> =A0/* Private data for the CS4270 */
> =A0struct cs4270_private {
> - =A0 =A0 =A0 struct snd_soc_codec codec;
> + =A0 =A0 =A0 enum snd_soc_control_type control_type;
> + =A0 =A0 =A0 void *control_data;

Because of this change, there is a comment later in the file that is
no longer valid:

	/* Allocate enough space for the snd_soc_codec structure
	   and our private data together. */
	cs4270 =3D kzalloc(sizeof(struct cs4270_private), GFP_KERNEL);
	if (!cs4270) {
		dev_err(&i2c_client->dev, "could not allocate codec\n");
		return -ENOMEM;
	}

Other than that ...

CS4270 portions:
Acked-by: Timur Tabi <timur@freescale.com>

-- =

Timur Tabi
Linux kernel developer at Freescale
