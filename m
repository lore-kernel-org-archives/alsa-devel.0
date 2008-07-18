From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: ASOC, master clock direction
Date: Fri, 18 Jul 2008 12:54:03 -0400
Message-ID: <9e4733910807180954s47157b84m90eed202d4ab3dc2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BA5D2453B
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jul 2008 18:54:07 +0200 (CEST)
Received: by ti-out-0910.google.com with SMTP id j3so339217tid.8
	for <alsa-devel@alsa-project.org>; Fri, 18 Jul 2008 09:54:05 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

The MPC5200 has three clock configurations

1) Clock out, normal master mode
2) Clock in, normal slave mode
3) Something Freescale calls cellphone slave but it is more like clock
distribution.

In cellslave mode one i2s port is in normal slave mode. The clock from
this port is used to drive up to three other i2s ports in master mode.

I have two choices for set_sysclk:
#define SND_SOC_CLOCK_IN        0
#define SND_SOC_CLOCK_OUT       1

When the clock frequency changes I need to notify the i2s drivers for
the dependent channels. Do we need a third choice,
SND_SOC_CLOCK_SLAVE? Alternatively I can use another clock id value.

-- 
Jon Smirl
jonsmirl@gmail.com
