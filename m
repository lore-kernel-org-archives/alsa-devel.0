From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: Enabling HDMI HBR mode on Intel HDA
Date: Fri, 30 Jul 2010 18:35:19 +0300
Message-ID: <201007301835.19639.anssi.hannula@iki.fi>
References: <201007301548.41516.anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirokuusama.dnainternet.net (sirokuusama.dnainternet.net
	[83.102.40.133]) by alsa0.perex.cz (Postfix) with ESMTP id 0EEB624347
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jul 2010 17:35:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by sirokuusama.dnainternet.net (Postfix) with ESMTP id 6B05A2C81F
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jul 2010 18:35:21 +0300 (EEST)
Received: from sirokuusama.dnainternet.net ([83.102.40.133])
	by localhost (sirokuusama.dnainternet.net [127.0.0.1]) (amavisd-new,
	port 10041)
	with ESMTP id XCcAuE1d5lYv for <alsa-devel@alsa-project.org>;
	Fri, 30 Jul 2010 18:35:21 +0300 (EEST)
Received: from oliivipuu.dnainternet.net (oliivipuu.dnainternet.net
	[83.102.40.215])
	by sirokuusama.dnainternet.net (Postfix) with ESMTP id 35CB52C81E
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jul 2010 18:35:21 +0300 (EEST)
Received: from mail.onse.fi (unknown [109.204.162.131])
	by oliivipuu.dnainternet.net (Postfix) with ESMTP id 276112BAA3
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jul 2010 18:35:20 +0300 (EEST)
Received: from sigma.onse.fi (sigma [10.0.0.8])
	by mail.onse.fi (Postfix) with ESMTP id CDD3110DE4BF
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jul 2010 18:35:19 +0300 (EEST)
In-Reply-To: <201007301548.41516.anssi.hannula@iki.fi>
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
List-Id: alsa-devel@alsa-project.org

Anssi Hannula kirjoitti perjantai, 30. hein=E4kuuta 2010 15:48:41:
> We have been trying to get truehd/mlp/mat passthrough to work, with no lu=
ck
> so far. As HDMI standard requires a separate transmission mode (i.e. HBR
> Audio Stream Packets instead of Audio Sample Packets) for high-bitrate
> (over 6.144Mbps) compressed formats, a driver change is needed, AFAIU.
> =

> Attached is a hack we have been using with hda_intel driver (the patch is
> for generic code; we have been using nvidia 8x codec if that matters).
> =

> Could anyone familiar with Intel HDA confirm whether the hack looks
> correct, or if something more is required? (0x05 is the hardcoded pin
> nid).

Naturally I figured it out just few hours after sending the message... I ha=
d =

to set bit 15 (stream-type) in format to 1.

I'll now look into properly integrating this support to alsa.

-- =

Anssi Hannula
