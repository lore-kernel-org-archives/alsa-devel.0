From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: Channel swapping issue on TI OMAP3/TWL4030
Date: Tue, 15 Feb 2011 08:59:50 +0200
Message-ID: <4D5A2466.2060705@nokia.com>
References: <8CD98E75F0E83E2-63C-14642@web-mmc-m05.sysops.aol.com>	<CF32F28EDF8D20468EEDCBE4975DA0274A46DB@008-AM1MPN1-027.mgdnok.nokia.com>
	<8CD9A87EF4FB765-1218-647@web-mmc-m03.sysops.aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da02.nokia.com (smtp.nokia.com [147.243.128.26])
	by alsa0.perex.cz (Postfix) with ESMTP id AD202103844
	for <alsa-devel@alsa-project.org>; Tue, 15 Feb 2011 07:59:56 +0100 (CET)
In-Reply-To: <8CD9A87EF4FB765-1218-647@web-mmc-m03.sysops.aol.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ext ylin@mail.com" <ylin@mail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/14/11 19:58, ext ylin@mail.com wrote:
> =

>> I have not experienced with channel swapping during capture..
>> It would help, if I know:
>> what is your kernel version
>> Source of the recording (digimic, HS, main mic, etc)
> =

> We are using 2.6.32.  The source of the recording is using Analog Mic.  =

> The Left Main mic is always on, and Right Sub mic can be either on or =

> off when this occurs.  We are not using AUX or digimic.
> =

>> To clarify:
>> you experience sudden channel switch during active recording, when
>> the recording was running for few hours?
>> Or is it that you start/stop the recording, and sometimes the channels
>> are swapped?
> =

> It is sudden channel switch during active recording.  There is no XRUN =

> or any noticeable error when this happens.
> =

> This is a VoIP app, we have duplex audio when this happens.  Both =

> capture and playback are setup to run at 48kHz, 2 channel, S16_LE, with =

> period size 10 mSec.

I forgot to ask:
what mode you are using the McBSP?
Is it in element, or threshold mode?
You can check/change the McBSP mode in:
/sys/devices/platform/omap-mcbsp.2/dma_op_mode

> For playing, the left and right are the same data, we could not tell if =

> the channel switch happens to playback as well.

I see. Is there a way for you to run your application to capture only,
and from a separate app (aplay?) play a sample, which has audio only on
one channel?

-- =

P=E9ter
