From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Adding sound to BeagleBone
Date: Mon, 13 Feb 2012 10:06:54 +0200
Message-ID: <4F38C49E.3060205@ti.com>
References: <4F37963A.7050906@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog115.obsmtp.com (na3sys009aog115.obsmtp.com
	[74.125.149.238])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C3AF103BA1
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2012 09:06:52 +0100 (CET)
Received: by mail-lpp01m010-f50.google.com with SMTP id m13so3866041lah.9
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2012 00:06:50 -0800 (PST)
In-Reply-To: <4F37963A.7050906@t-online.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Bolch <peter.bolch@t-online.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 02/12/2012 12:36 PM, Peter Bolch wrote:
> what - beside making the hardware -  has to be done in principle to add =

> an external audio codec to BeagleBone board (OMAPAM3358 based, with I2S  =

> but without a codec on board)?

I'm not really familiar with BeagleBone, and AM3359, but:
You will need a driver for McASP (0 is routed to expansion). It looks
like that the McASP IP is the same as in DaVinci. With luck you might be
able to reuse the code for AM3359.
Apart from this you will need a machine driver.

-- =

P=E9ter
