From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Question to sophisticated alsa developer
Date: Wed, 5 Aug 2009 10:26:53 -0400
Message-ID: <9e4733910908050726u60ae4ed5q60cc229dead57c87@mail.gmail.com>
References: <4A796779.6030204@corscience.de>
	<9e4733910908050546w3c268db9h7ccd4fa37ecd0099@mail.gmail.com>
	<4A7990DF.2060606@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f185.google.com (mail-qy0-f185.google.com
	[209.85.221.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 27C7E1038A5
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Aug 2009 16:26:55 +0200 (CEST)
Received: by qyk15 with SMTP id 15so100988qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 05 Aug 2009 07:26:54 -0700 (PDT)
In-Reply-To: <4A7990DF.2060606@corscience.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Andreas_Bie=DFmann?= <biessmann@corscience.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 5, 2009 at 10:02 AM, Andreas
Bie=DFmann<biessmann@corscience.de> wrote:
> Hi Jon,
>
> Jon Smirl schrieb:
>> When the last sample plays it generates an interrupt. ALSA sends a
>> STOP back after this interrupt. But the audio hardware continues
>> playing between this interrupt and receiving the STOP. Since the last
>> valid sample generated the interrupt, the hardware is playing garbage
>> (stale data) while waiting on the STOP. Probably =A0500us worth of stale
>> data.,
>
> This sounds correct an I will investigate this. But I wonder why the
> stale data does not appear when I use aplay without dmix layer. Have you
> some explanation for this?

You might have a different problem. I heard the problem with both dmix
and aplay.

Batch mode ALSA drivers can't tell the current position of the DMA
pointer while DMA is active. They only know the DMA position when the
DMA hardware generates an interrupt.

I don't know if AVR32 needs to be batch mode or not. Also the AVR32
driver may have been written as a batch driver even when it didn't
need to be.

>
> regards
>
> Andreas Bie=DFmann
>



-- =

Jon Smirl
jonsmirl@gmail.com
