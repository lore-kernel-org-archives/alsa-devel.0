From: "Sebastian H." <vand2@gmx.de>
Subject: Re: QasTools 0.17.0 released
Date: Wed, 04 Jul 2012 11:27:56 +0200
Message-ID: <4FF40C9C.804@gmx.de>
References: <CAN8cciaAx6unmfDheYsze7thfkKzyjXN6jhdUfQmBm4Ltvf92g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by alsa0.perex.cz (Postfix) with SMTP id 1B9DE24532
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2012 11:28:07 +0200 (CEST)
In-Reply-To: <CAN8cciaAx6unmfDheYsze7thfkKzyjXN6jhdUfQmBm4Ltvf92g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

Hello

> qasmixer only show a mono Master and Capture volume controls/switch of
> "pulse" when user selected 4.0 / 5.1/ 7.1 analog output and stereo
> input in sound setting of ubuntu 12.04 , amixer and alsamixer show the
> volume control with correct channels

I've tried pulseaudio on my debian box and got similar results.
Though the channels are there, they're just hidden inside
the joined master slider.
Try right clicking (do people still have mice these days?) the master
slider and select "Split channels".
The issue now is that the sliders are unnamed.
Only the tooltip gives an idea of what is what.

Sebastian
