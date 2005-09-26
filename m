From: Matthias Andree <matthias.andree@gmx.de>
Subject: alsa-lib "convert" basic OPs (lack rounding and dithering)
Date: Mon, 26 Sep 2005 15:47:33 +0200
Message-ID: <m3zmq0kkju.fsf@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.dt.e-technik.uni-dortmund.de (krusty.dt.e-technik.Uni-Dortmund.DE [129.217.163.1])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8594117E
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2005 15:47:43 +0200 (MEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.dt.e-technik.uni-dortmund.de (Postfix) with ESMTP id 2520B444B0
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2005 15:47:38 +0200 (CEST)
Received: from mail.dt.e-technik.uni-dortmund.de ([127.0.0.1])
 by localhost (krusty [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 09094-02 for <alsa-devel@alsa-project.org>;
 Mon, 26 Sep 2005 15:47:36 +0200 (CEST)
Received: from m2a2.dyndns.org (p5091342C.dip0.t-ipconnect.de [80.145.52.44])
	by mail.dt.e-technik.uni-dortmund.de (Postfix) with ESMTP id 93A72443FB
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2005 15:47:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by merlin.emma.line.org (Postfix) with ESMTP id 50BAC170B24
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2005 15:47:34 +0200 (CEST)
Received: from m2a2.dyndns.org ([127.0.0.1])
 by localhost (m2a2.dyndns.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 18160-05 for <alsa-devel@alsa-project.org>;
 Mon, 26 Sep 2005 15:47:33 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I don't have much time (maintaining other open source software, real
life work and all that you are familiar with), but I recently found out
Alsa has not managed to deal with proper quantization over the past four
years.

My complaint at that time was that Alsa-lib wasn't even rounding, just
truncating (>> 8 or & 0xff), let alone dithering.

Rounding is simple to implement (just add 1/2 LSB before truncating) and
increases the SNR by roughly 6 dB - which already makes a difference for
8bit output from 16bit input.

Rounding doesn't fix the other problem however: quantization noise
correlation to the signal and non-linearity of the truncation.

Dithering, that is, adding a specially shaped low "noise" signal,
decorrelates the quantization noise, making it much more unobtrusive,
and also makes the whole process linear. No more chirping and sharp
clicking interspersed with blackouts of near-silent signals.

This is also filed as alsa - lib bug 001454, the bug report has two book
recommendations, for a quick introduction into dithering.

I don't offer to take this project for reasons given in the first
paragraph, but I will try to answer questions in this regard.

HTH,

-- 
Matthias Andree


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
