From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: Re: [PATCH] Add AC'97 driver for AT91SAM9263ek atmel
 board.
Date: Thu, 02 Oct 2008 10:51:02 +0200
Message-ID: <48E48B76.1050809@atmel.com>
References: <48E3A42C.6090202@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atmel-es2.atmel.fr (mail.atmel.fr [81.80.104.162])
	by alsa0.perex.cz (Postfix) with ESMTP id E153024497
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Oct 2008 10:51:09 +0200 (CEST)
Received: from fwat.rfo.atmel.com (gateway [192.168.1.1])
	by atmel-es2.atmel.fr (8.11.6+Sun/8.11.6) with SMTP id m928oHI07729
	for <alsa-devel@alsa-project.org>; Thu, 2 Oct 2008 10:50:18 +0200 (MEST)
In-Reply-To: <48E3A42C.6090202@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Sedji Gaouaou a =E9crit :
> Add AC'97 driver for AT91SAM9263ek atmel board.
> The driver includes the playback and the capture.
> =

> Signed-off-by: Sedji Gaouaou <sedji.gaouaou@atmel.com>
> ---
>  sound/arm/Kconfig     |    9 +
>  sound/arm/Makefile    |    4 +
>  sound/arm/at91-ac97.c |  912 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  sound/arm/at91-ac97.h |  295 ++++++++++++++++

When I was writing this patch I was wondering if it should actually be =

in the sound/arm directory or in a sound/soc/atmel directory?

Regards,
Sedji
