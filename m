From: Graeme Gregory <gg@opensource.wolfsonmicro.com>
Subject: Re: [ASoC]one Small Suggestion
Date: Fri, 08 Jun 2007 09:47:54 +0100
Message-ID: <1181292474.9717.6.camel@gg-desktop.wolfsonmicro.main>
References: <8d6898730706070558r6c5c08aft8e00563b7a8ba607@mail.gmail.com>
	<8d6898730706080047x37a2ddb4m9766246017e43029@mail.gmail.com>
	<1181289387.9717.3.camel@gg-desktop.wolfsonmicro.main>
	<8d6898730706080126x27575de7k645e2bf280201037@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id B3BD124688
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Jun 2007 10:51:34 +0200 (CEST)
In-Reply-To: <8d6898730706080126x27575de7k645e2bf280201037@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nobin Mathew <nobin.mathew@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2007-06-08 at 13:56 +0530, Nobin Mathew wrote:
> Like we have in /proc/asound/card0/codec97#0/ac97#0-0+regs
> 
I think you miss the point, the codec regs are already exposed
on sysfs.

When Liams new asoc is finished, this will also handle multiple
codecs being exposed.

The path I posted is from a running asoc driver.

Graeme
