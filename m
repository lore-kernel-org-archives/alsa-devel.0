From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ALSA: ASoc: Add regulator support to
	CS4270 codec driver
Date: Sat, 5 Dec 2009 11:03:49 -0600
Message-ID: <ed82fe3e0912050903t7391ec51s8823b2059b6b5df1@mail.gmail.com>
References: <20091130165104.GK14091@buzzloop.caiaq.de>
	<1259600171-30357-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152])
	by alsa0.perex.cz (Postfix) with ESMTP id E7A3624344
	for <alsa-devel@alsa-project.org>; Sat,  5 Dec 2009 18:03:50 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id e12so217272fga.2
	for <alsa-devel@alsa-project.org>; Sat, 05 Dec 2009 09:03:49 -0800 (PST)
In-Reply-To: <1259600171-30357-1-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 30, 2009 at 10:56 AM, Daniel Mack <daniel@caiaq.de> wrote:
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Timur Tabi <timur@freescale.com>
> Cc: Liam Girdwood <lrg@slimlogic.co.uk>
> ---

Ack

> +static const char *supply_names[] =3D {
> + =A0 =A0 =A0 "va", "vd", "vlc"
> +};

Minor nit -- this array would take up less space if it were an array
of strings instead of an array of pointers to strings.

static const char supply_names[4][] =3D {
       "va", "vd", "vlc"
};

-- =

Timur Tabi
Linux kernel developer at Freescale
