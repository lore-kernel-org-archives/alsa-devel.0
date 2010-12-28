From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: Why is SND_PCM_FORMAT_S32_LE not able to be set
 and passed to Linux Kernel Asoc?
Date: Tue, 28 Dec 2010 18:46:50 +0200
Message-ID: <4D1A147A.6010407@nokia.com>
References: <0520A3FE5EDCF24F88B3F1451CFC64AE02338750EF@EDPREX01.logicpd.com>	<AANLkTimE_qnG2Y7Z16qgQbc+N9H7SmNOGmXUUsvyhBgZ@mail.gmail.com>
	<0520A3FE5EDCF24F88B3F1451CFC64AE02338750F0@EDPREX01.logicpd.com>
	<4D19EE04.4060003@nokia.com>
	<0520A3FE5EDCF24F88B3F1451CFC64AE0233875422@EDPREX01.logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da02.nokia.com (smtp.nokia.com [147.243.128.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 13B542442F
	for <alsa-devel@alsa-project.org>; Tue, 28 Dec 2010 17:41:10 +0100 (CET)
In-Reply-To: <0520A3FE5EDCF24F88B3F1451CFC64AE0233875422@EDPREX01.logicpd.com>
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

On 12/28/2010 06:22 PM, ext Philip Chu wrote:
> I also added S32_LE support for twl4030 codec. But the thing is, the user=
 land ALSA API is still asking for S16_LE (observed from the pcm_native.c f=
rom kernel) even when I am using SND_PCM_FORMAT_S32_LE in my application co=
de as shown in my 1st post.

You should try this patch for the twl4030:
http://mailman.alsa-project.org/pipermail/alsa-devel/2010-December/034792.h=
tml

I used aplay/arecord for testing the 32/24 bit support, and it was fine
on the twl4030 codec.

-- =

P=E9ter
