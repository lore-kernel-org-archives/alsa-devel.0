From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: snd-fm801: autodetect SF64-PCR (tuner-only) card
Date: Fri, 27 Nov 2009 07:59:26 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0911270756140.4095@eeebox2.perex-int.cz>
References: <200911262159.44083.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 53189103843
	for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2009 07:59:21 +0100 (CET)
In-Reply-To: <200911262159.44083.linux@rainbow-software.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 26 Nov 2009, Ondrej Zary wrote:

> When primary AC97 is not found, don't fail with tons of AC97 errors.
> Assume that the card is SF64-PCR (tuner-only).
> This makes the SF64-PCR radio card work "out of the box".

I would leave the possibility to force FM tuner only detection without 
touching AC97 bus. The auto detection is a good idea. Could you recode 
your patch?

> Also fixes a bug that can cause an oops here:
> 	if (tea575x_tuner > 0 && (tea575x_tuner & 0x000f) < 4) {
> when tea575x_tuner == 16, it passes this check and causes problems
> a couple lines below:
> 	chip->tea.ops = &snd_fm801_tea_ops[(tea575x_tuner & 0x000f) - 1];

Thanks for catching this bug.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
