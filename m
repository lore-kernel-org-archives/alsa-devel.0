From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: Channel swapping issue on TI OMAP3/TWL4030
Date: Wed, 16 Feb 2011 09:20:21 +0200
Message-ID: <4D5B7AB5.201@nokia.com>
References: <8CD98E75F0E83E2-63C-14642@web-mmc-m05.sysops.aol.com>	<CF32F28EDF8D20468EEDCBE4975DA0274A46DB@008-AM1MPN1-027.mgdnok.nokia.com><8CD9A87EF4FB765-1218-647@web-mmc-m03.sysops.aol.com>	<4D5A2466.2060705@nokia.com>
	<8CD9B43DFD8A17C-DE8-B3DD@web-mmc-d01.sysops.aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 1BE8B24414
	for <alsa-devel@alsa-project.org>; Wed, 16 Feb 2011 08:20:23 +0100 (CET)
In-Reply-To: <8CD9B43DFD8A17C-DE8-B3DD@web-mmc-d01.sysops.aol.com>
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

On 02/15/11 18:23, ext ylin@mail.com wrote:
> =

>> I forgot to ask:
>> what mode you are using the McBSP?
>> Is it in element, or threshold mode?
>> You can check/change the McBSP mode in:
>> /sys/devices/platform/omap-mcbsp.2/dma_op_mode
> =

> It is in threshold mode, with max threshold 1023.  I will try other =

> modes.

This sounds safe, give the fact that the McBSP2 FIFO is 1280 word long.
The McBSP FIFO configuration has been corrected in newer kernels.

One thing that I would try is to synchronize the McBSP2 FIFO
configuration with the period size you use:
48KHz/stereo/16bit 10ms =3D 480 samples,
so configure the McBSP2 FIFO to 960 (for both tx, and rx threshold).
Might not help, but it worth a try...

>>> For playing, the left and right are the same data, we could not =

> tell if
>>> the channel switch happens to playback as well.
>>
>> I see. Is there a way for you to run your application to capture only,
>> and from a separate app (aplay?) play a sample, which has audio only =

> on
>> one channel?
> =

> I can fill zero to one of the play channel in our app to test it.

Great.
Let's see, if the swap also happens in the playback path as well.

-- =

P=E9ter
