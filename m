From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [PATCH] ASoC: Fix inconsistent meaning of default
	case while checking alc5623->id
Date: Fri, 03 Dec 2010 13:21:22 +0100
Message-ID: <874oavqc71.fsf@lechat.rtp-net.org>
References: <1291368357.20452.6.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lechat.rtp-net.org (lechat.rtp-net.org [88.191.19.38])
	by alsa0.perex.cz (Postfix) with ESMTP id 3FF77103800
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2010 13:19:55 +0100 (CET)
In-Reply-To: <1291368357.20452.6.camel@mola> (Axel Lin's message of "Fri, 03
	Dec 2010 17:25:57 +0800")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Axel Lin <axel.lin@gmail.com> writes:

> In alc5623_i2c_probe(),
> the default case for checking alc5623->id behaves the same as case 0x23.
> However, In alc5623_probe() the default case for checking alc5623->id
> becomes to be the same as case 0x21.
> This makes the meaning of default case inconsistent.
>
> Since we have checked codec id in alc5623_i2c_probe() by comparing
> vid2 with id->driver_data, it is not possible to run into the default case now.
>
> In case we may add more supported devices to alc5623_i2c_table in the future,
> this patch changes the default case return -EINVAL to let people know that
> they should not run into this case. They should also add a new case accordingly
> for the new id.

oh, yeah. makes sense. Thanks for noticing.


Acked-by: Arnaud Patard <arnaud.patard@rtp-net.org>
