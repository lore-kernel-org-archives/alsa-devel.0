From: Matteo Fortini <matteo.fortini@gmail.com>
Subject: SOC: using a codec (ADAU1761) just as an analog mixer
Date: Wed, 12 Oct 2011 19:07:28 +0200
Message-ID: <CAC_9p+--aAUjR3vofdY_LZ0TsUr02TicNjfG-epNDtzh+=WHdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 94F40103824
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Oct 2011 19:07:50 +0200 (CEST)
Received: by eyz10 with SMTP id 10so935082eyz.38
	for <alsa-devel@alsa-project.org>; Wed, 12 Oct 2011 10:07:49 -0700 (PDT)
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

I'm using an ADAU1761 codec in a project, but we'd like, for now, to
use it just as a mixer, i.e. without passing through the ADC/DAC and
DSP stages.

Which is the best way of accomplishing that?

In the past I tried to add virtual DAPM routes in order to get the
relevant power systems powered up, and bypassing the standby modes,
since the device wouldn't let me use the mixer controls through I2C if
I don't clock it.

Another question: how do I tell ALSA to power up a stage (in this
case, the ALC/differential input stage)?

TIA,
Matteo
