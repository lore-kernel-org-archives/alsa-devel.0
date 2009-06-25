From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: Reg: Implementation of GSM digital audio path
Date: Thu, 25 Jun 2009 13:35:08 +0300
Message-ID: <200906251335.08412.peter.ujfalusi@nokia.com>
References: <1cbe56070906250247j30e63925k3acbff5a5a3e3df8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id E0ED4103874
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Jun 2009 12:35:12 +0200 (CEST)
In-Reply-To: <1cbe56070906250247j30e63925k3acbff5a5a3e3df8@mail.gmail.com>
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
To: alsa-devel@alsa-project.org
Cc: ext shariff <shariffsinbox@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 25 June 2009 12:47:54 ext shariff wrote:
> Hi all,
>
>         Iam working on OMAP3 based custom board. On our board, GSM digital
> audio path is connected to McBSP3 and
> TWL4030 digital audio path is connected to McBSP2.
>
> I want to implement a module that transfers GSM audio data and store audio
> data into some buffer and redirect it to TWL4030 audio codec through
> McBSP2.
>
> I question is how can I implement this in ASoC?
>
> I studied ASoC framework, but I am unable to understand where to implement
> my stuff.

I think the following should do something like that:

arecord -Dplughw:0.0 | aplay -Dplughw:0.1
or
arecord -Dhw:0.0 | aplay -Dhw:0.1

I don't know what is the order of the PCMs with the twl4030 codec on your =

board, this is with the assumption:
plughw:0.0 - Voice PCM (McBSP3)
plughw:0.1 - Digital audio PCM (McBSP2)

You might want to try the --rate parameter for arecord to use 16KHz recordi=
ng =

from the Voice interface..

>
> Regards,
> Shariff
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- =

P=E9ter
