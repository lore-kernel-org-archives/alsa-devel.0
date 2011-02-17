From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: Channel swapping issue on TI OMAP3/TWL4030
Date: Thu, 17 Feb 2011 13:44:14 +0200
Message-ID: <4D5D0A0E.5030505@nokia.com>
References: <8CD98E75F0E83E2-63C-14642@web-mmc-m05.sysops.aol.com>	<CF32F28EDF8D20468EEDCBE4975DA0274A46DB@008-AM1MPN1-027.mgdnok.nokia.com><8CD9A87EF4FB765-1218-647@web-mmc-m03.sysops.aol.com>	<4D5A2466.2060705@nokia.com><8CD9B43DFD8A17C-DE8-B3DD@web-mmc-d01.sysops.aol.com>	<4D5B7AB5.201@nokia.com>
	<8CD9C6B934040FF-13C8-4BFB@web-mmc-d06.sysops.aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id C12A724133
	for <alsa-devel@alsa-project.org>; Thu, 17 Feb 2011 12:44:17 +0100 (CET)
In-Reply-To: <8CD9C6B934040FF-13C8-4BFB@web-mmc-d06.sysops.aol.com>
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

On 02/17/11 05:40, ext ylin@mail.com wrote:
> We tried element and frame mode, playback doesn't sound correct with =

> these mode, but the capture is OK.

Hrm, this does not sound right... Historically the element mode was the
first and only mode of using McBSP. The threshold mode has been added later.
Could you explain what do you mean, when you said that the playback was
not correct?
I have never experienced problems with the element mode.
In what mode you are using the TWL4030 codec? Is it master?
If it is master, can you compare your machine driver with for example
the Beagle board's machine driver?
Or can you share the relevant configuration (from your machine driver)
with us?

> None of our test shows the playback problem.  I think the playback path =

> is fine, but will keep testing.
> =

> Also, we have verified the audio data from I2S interface looks fine =

> using a scope even when the channels are switched.  We can eliminate =

> twl4030 codec from the problem,

That's good.

> and focus on McBSP and DMA.  We don't =

> have chance to check McBSP overflow/underflow as you suggested yet.

If we don't figure out what is the problem, you might need to do this...

-- =

P=E9ter
