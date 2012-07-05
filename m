From: Daniel Mack <zonque@gmail.com>
Subject: Re: DT support for Davinci ASoC platform
Date: Thu, 05 Jul 2012 12:58:06 +0200
Message-ID: <4FF5733E.6000604@gmail.com>
References: <1BAFE6F6C881BF42822005164F1491C33EA35352@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 021771044EE
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jul 2012 12:58:19 +0200 (CEST)
Received: by werb12 with SMTP id b12so2789564wer.38
	for <alsa-devel@alsa-project.org>; Thu, 05 Jul 2012 03:58:19 -0700 (PDT)
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EA35352@DBDE01.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Rajashekhara,
	Sudhakar" <sudhakar.raj@ti.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Nori, Sekhar" <nsekhar@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>, "Girdwood, Liam" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hi Gururaja,

On 04.07.2012 14:48, Hebbar, Gururaja wrote:
> All,
> 
> Are there any plans or work going on for providing Device Tree Support for Davinci
> ASoC?
> 
> I am planning to add DT support for TI AM335x (McASP) and I don't want to do duplicate
> task.

That's good to know. But isn't there a dependency on the EDMA engine? Is
that part ported yet?


Daniel
