From: Prasant J <pj0585@gmail.com>
Subject: ALSA-SoC: Audio Peripheral without codec
Date: Tue, 12 Jun 2012 11:25:07 +0530
Message-ID: <CAA2DH4s9w83TOY7U8MeE_fQeKBjPuz=w-iprbcOrnN=K1EQ_dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 760A424344
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Jun 2012 07:55:08 +0200 (CEST)
Received: by qcse14 with SMTP id e14so2630736qcs.38
	for <alsa-devel@alsa-project.org>; Mon, 11 Jun 2012 22:55:07 -0700 (PDT)
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

I'm working on linux-3.2.14 (TI-Beaglebone).
After reading the kernel docs regarding the ALSA-SoC, what I found out
is that ALSA-SoC framework also includes the Codec drivers.

In my application, my processor want to communicate to another
processor (TDM), but there is no Codec.
How do I configure, ALSA-SoC, so that it ignores the Codec? Is there a
dummy codec code already present for such a use case?

Any suggestions?

Regards, Prasant
