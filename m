From: arif setiawan <n.arif.setiawan@gmail.com>
Subject: ALSA -LADSPA buffer
Date: Mon, 3 Aug 2009 16:48:10 +0700
Message-ID: <c697747b0908030248y3e8d74ado3747f16986ee6a83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f176.google.com (mail-yx0-f176.google.com
	[209.85.210.176])
	by alsa0.perex.cz (Postfix) with ESMTP id CCD96246AB
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Aug 2009 11:48:11 +0200 (CEST)
Received: by yxe6 with SMTP id 6so1861389yxe.16
	for <alsa-devel@alsa-project.org>; Mon, 03 Aug 2009 02:48:10 -0700 (PDT)
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

Hi all,

I have some questions about ALSA - LADSPA data exchange in ALSA plugin. As I
understand it, LADSPA only use 32 bit floating point, while ALSA can use
many types of buffer, S8, S16_LE and so on. My question is how this buffer
converted?

As I work with OMAP processor I want to use DSP for signal processing. We
want the LADSPA plugin connect to the DSP and get plugin advantage. But DSP
only work on fixed point arithmatic, so we need to convert the 32 bit float
in LADSPA to an integer type buffer. I think I can achieve it by following
ALSA-LADSPA buffer conversion. How I can do this?

Thank you for your help.

Best regards,

Arif
