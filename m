From: =?ISO-8859-1?Q?Andreas_Bie=DFmann?= <biessmann@corscience.de>
Subject: Re: Question to sophisticated alsa developer
Date: Wed, 05 Aug 2009 16:02:07 +0200
Message-ID: <4A7990DF.2060606@corscience.de>
References: <4A796779.6030204@corscience.de>
	<9e4733910908050546w3c268db9h7ccd4fa37ecd0099@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 43A2D1037FD
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Aug 2009 16:02:12 +0200 (CEST)
In-Reply-To: <9e4733910908050546w3c268db9h7ccd4fa37ecd0099@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Jon,

Jon Smirl schrieb:
> When the last sample plays it generates an interrupt. ALSA sends a
> STOP back after this interrupt. But the audio hardware continues
> playing between this interrupt and receiving the STOP. Since the last
> valid sample generated the interrupt, the hardware is playing garbage
> (stale data) while waiting on the STOP. Probably  500us worth of stale
> data.,

This sounds correct an I will investigate this. But I wonder why the
stale data does not appear when I use aplay without dmix layer. Have you
some explanation for this?

regards

Andreas Bie=DFmann
