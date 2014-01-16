From: "Pavel Botev" <pbotev@mm-sol.com>
Subject: different sample rate in alsa.conf file, ALSA DMIX mode
Date: Thu, 16 Jan 2014 15:08:01 +0200
Message-ID: <4a0ff6d86530b88f7468085e81bf695b.squirrel@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from extserv.mm-sol.com (ns.mm-sol.com [37.157.136.199])
 by alsa0.perex.cz (Postfix) with ESMTP id 327AE26167D
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2014 14:08:05 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi ALSA support team,

Can we set more sample rate for DMIX mode in the alsa.conf file than the
default one (defaults.pcm.dmix.rate 48000)? Can we use one alsa.conf file,
with many sample rates (8KHz, 11.025KHz, 16KHz, 22.05KHz, 32KHz, 44.1KHz,
48KHz, 64KHz, 88.2KHz and 96KHz), not with just one default sample rate?

The problem is that when we use one sample rate in alsa.conf and other in
the ALSA application, we have resampling executed which is very CPU
intensive. Thus we search a way to use alsa.conf file with many sample
rates, thus avoiding resampling.

If not possible, can we change the algorithm of resampling, thus have low
CPU usage when resampling is activated?

Thanks for your time.

Best regards,
Pavel
