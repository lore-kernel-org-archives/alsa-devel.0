From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v3 01/16] ALSA: Oxygen: Add the separate
 SPI waiting function
Date: Sat, 18 Jan 2014 11:26:49 +0100
Message-ID: <52DA56E9.2020703@ladisch.de>
References: <1389971315-3215-1-git-send-email-v1ron@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 2A9F3261A28
 for <alsa-devel@alsa-project.org>; Sat, 18 Jan 2014 11:27:02 +0100 (CET)
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 708C120DA8
 for <alsa-devel@alsa-project.org>; Sat, 18 Jan 2014 05:27:00 -0500 (EST)
In-Reply-To: <1389971315-3215-1-git-send-email-v1ron@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Roman Volkov <v1ron@mail.ru>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Roman Volkov wrote:
> This function performs waiting when the SPI bus completes
> a transaction. Timeout error checking introduced and
> the timeout increased to 400 from 40.

Why 400?  SPI does not allow the codec to delay reads.

> +	for (count =3D 100; count > 0; count--) {
> +		if ((oxygen_read8(chip, OXYGEN_SPI_CONTROL) &
> +						OXYGEN_SPI_BUSY) =3D=3D 0)
> +			return 0;
> +		udelay(4);
> +		--count;
> +	}

This loop waits for 200 =B5s.

The SPI transaction will not be finished for the first 30 =B5s or so, so
polling is not needed for that time.

With the wait coming after the transaction, it makes more sense to have
the busy check not before but after the udelay.


Regards,
Clemens
