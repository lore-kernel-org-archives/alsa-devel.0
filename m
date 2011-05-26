From: Tanu Kaskinen <tanuk@iki.fi>
Subject: Negative volume steps?
Date: Thu, 26 May 2011 14:06:43 +0300
Message-ID: <1306408004.4306.53.camel@jarl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw2.cc.tut.fi (mail-gw2.cc.tut.fi [130.230.160.16])
	by alsa0.perex.cz (Postfix) with ESMTP id 86C9A103AE5
	for <alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 13:06:50 +0200 (CEST)
Received: from [91.153.205.9] (a91-153-205-9.elisa-laajakaista.fi
	[91.153.205.9]) (using SSLv3 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.cc.tut.fi (Postfix) with ESMTP id DDDCDA409E
	for <alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 14:06:46 +0300 (EEST)
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

Hi,

If a driver claims that the lowest volume step (integer step, not dB) of
a volume element is -126 and the highest step is 0, is the driver
broken?

I'm asking, because apparently there are such drivers, but Pulseaudio
currently assumes that the volume steps are never negative.

-- 
Tanu
