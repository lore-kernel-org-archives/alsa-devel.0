From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: WM8731 using I2S on omap3 McBSP2 issues
Date: Tue, 29 Sep 2009 11:43:17 +0300
Message-ID: <200909291143.17972.peter.ujfalusi@nokia.com>
References: <E1MsNYs-00066Y-NL@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 41FD910382D
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Sep 2009 10:43:45 +0200 (CEST)
In-Reply-To: <E1MsNYs-00066Y-NL@amazonia.comcast.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Rick Bronson <rick@efn.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tuesday 29 September 2009 00:15:10 ext Rick Bronson wrote:
> Peter,
> =

>   I'm getting a XUNDFLSTAT (indicates a real underflow condition) and
> XEMPTYEOF (Transmit buffer empty at end of frame) in
> MCBSPLP_IRQSTATUS_REG.  Does this tell you anything?

Hmm, this actually means that the DMA is not filling the McBSP buffer.
Since there is no data written in the McBSP buffer, it is shifting out 0 wh=
ich =

is what you have observed on the DX line (goes low for the duration of apla=
y).

I have used McBSP as master on 2.6.28 kernel and I can not recall any big =

changes regarding to OMAP McBSP/DMA in between 28 and 29, so I'm a bit puzz=
led =

on this...

> =

>   Rick
> =


-- =

P=E9ter
