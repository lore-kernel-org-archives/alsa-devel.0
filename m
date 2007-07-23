From: dustin@seznam.cz
Subject: Re: SNDRV_PCM_FMTBIT_S24_LE vs.
	SNDRV_PCM_FMTBIT_S24_3LE
Date: Mon, 23 Jul 2007 21:22:05 +0200 (CEST)
Message-ID: <11505.27621-24387-105789712-1185218525@seznam.cz>
References: <46A4F700.5030603@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mxl.seznam.cz (mxhn.seznam.cz [212.80.76.26])
	by alsa0.perex.cz (Postfix) with SMTP id 9F471103899
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Jul 2007 21:22:06 +0200 (CEST)
In-Reply-To: <46A4F700.5030603@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?us-ascii?Q?Timur=20Tabi?= <timur@freescale.com>
Cc: =?us-ascii?Q?ALSA=20devel?= <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


>  ------------ P=F9vodn=ED zpr=E1va ------------
>
>  ----------------------------------------
>  What is the difference between SNDRV_PCM_FMTBIT_S24_LE and
>  SNDRV_PCM_FMTBIT_S24_3LE?

The asound.h says S24_LE is stored in lower three bytes of four, whereas S2=
4_3LE is stored in three bytes total.


Pavel.

>  =

>  -- =

>  Timur Tabi
>  Linux Kernel Developer @ Freescale
>  _______________________________________________
>  Alsa-devel mailing list
>  Alsa-devel@alsa-project.org
>  http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>  =

>  =

>  =
