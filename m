From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: Why is SND_PCM_FORMAT_S32_LE not able to be set
 and passed to Linux Kernel Asoc?
Date: Tue, 28 Dec 2010 16:02:44 +0200
Message-ID: <4D19EE04.4060003@nokia.com>
References: <0520A3FE5EDCF24F88B3F1451CFC64AE02338750EF@EDPREX01.logicpd.com>	<AANLkTimE_qnG2Y7Z16qgQbc+N9H7SmNOGmXUUsvyhBgZ@mail.gmail.com>
	<0520A3FE5EDCF24F88B3F1451CFC64AE02338750F0@EDPREX01.logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da02.nokia.com (smtp.nokia.com [147.243.128.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 708461037FB
	for <alsa-devel@alsa-project.org>; Tue, 28 Dec 2010 14:57:05 +0100 (CET)
In-Reply-To: <0520A3FE5EDCF24F88B3F1451CFC64AE02338750F0@EDPREX01.logicpd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Philip Chu <Philip.Chu@logicpd.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jassi Brar <jassisinghbrar@gmail.com>
List-Id: alsa-devel@alsa-project.org

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
