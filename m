From: "Alexandre BOUIN" <a.bouin@kerlink.fr>
Subject: ASoC AT91 : read dma buffer
Date: Fri, 22 Feb 2008 16:05:15 +0100
Message-ID: <37869.6074164056$1203692870@news.gmane.org>
References: <43e8c7320802220151p177d2c73y2c9724a4cb4743ef@mail.gmail.com>	<47BEC97A.3030507@ladisch.de>	<43e8c7320802220545m6ccf8c7fr13a9390563d7df7@mail.gmail.com>	<47BED4C2.4020501@ladisch.de>	<43e8c7320802220619x4dfc049cv1f38a6fb8b1cb7a8@mail.gmail.com>	<47BEDF9E.3000907@ladisch.de>
	<43e8c7320802220651r25ac78d7pecca63f3e1d48249@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from scanner-relay-corvus2.pulsation.fr
	(scanner-relay-corvus2.pulsation.fr [80.74.64.70])
	by alsa0.perex.cz (Postfix) with SMTP id E4464103806
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 16:05:16 +0100 (CET)
In-Reply-To: <43e8c7320802220651r25ac78d7pecca63f3e1d48249@mail.gmail.com>
Content-Language: fr
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

Hi list,

I'm working with ASoC layer for arm AT91.
I'd like to trace sound datas right before they are transmitted to dma.

Buffer pointer seems to be prtd->period_ptr.
Is there any way to read datas from this pointer ?

Thanks in advance.

Regards,
Alex.
