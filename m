From: Philip Chu <Philip.Chu@logicpd.com>
Subject: Re: Why is SND_PCM_FORMAT_S32_LE not able to be set
 and passed to Linux Kernel Asoc?
Date: Tue, 28 Dec 2010 10:22:57 -0600
Message-ID: <0520A3FE5EDCF24F88B3F1451CFC64AE0233875422@EDPREX01.logicpd.com>
References: <0520A3FE5EDCF24F88B3F1451CFC64AE02338750EF@EDPREX01.logicpd.com>
	<AANLkTimE_qnG2Y7Z16qgQbc+N9H7SmNOGmXUUsvyhBgZ@mail.gmail.com>
	<0520A3FE5EDCF24F88B3F1451CFC64AE02338750F0@EDPREX01.logicpd.com>
	<4D19EE04.4060003@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from barracuda.logicpd.com (unknown [174.46.170.145])
	by alsa0.perex.cz (Postfix) with ESMTP id D19B6243BD
	for <alsa-devel@alsa-project.org>; Tue, 28 Dec 2010 17:23:00 +0100 (CET)
In-Reply-To: <4D19EE04.4060003@nokia.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jassi Brar <jassisinghbrar@gmail.com>
List-Id: alsa-devel@alsa-project.org

I also added S32_LE support for twl4030 codec. But the thing is, the user l=
and ALSA API is still asking for S16_LE (observed from the pcm_native.c fro=
m kernel) even when I am using SND_PCM_FORMAT_S32_LE in my application code=
 as shown in my 1st post.

Philip

-----Original Message-----
From: Peter Ujfalusi [mailto:peter.ujfalusi@nokia.com] =

Sent: Tuesday, December 28, 2010 9:03 AM
To: Philip Chu
Cc: Jassi Brar; alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Why is SND_PCM_FORMAT_S32_LE not able to be set a=
nd passed to Linux Kernel Asoc?

On 12/28/2010 09:35 AM, ext Philip Chu wrote:
> Thanks for your reply.
> =

> Yes I am using plughw - "plughw:0,0" and OMAP3530 Torpedo board. And I am=
 attaching my own sound card driver on McBSP 3.

The OMAP McBSP DAI has support for S32_LE format.
I have added S32_LE/24 support for the twl4030 codec, and it
is working fine.
I think your codec driver does not support the S32_LE format.

-- =

P=E9ter
