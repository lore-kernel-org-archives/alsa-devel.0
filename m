From: Clemens Ladisch <clemens@alsa-project.org>
Subject: Re: Will ALSA ever call _prepare or _hw_params while
 it's	playing?
Date: Wed, 21 May 2008 17:53:38 +0200
Message-ID: <48344582.8020601@alsa-project.org>
References: <4834438A.4060702@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 41593243AA
	for <alsa-devel@alsa-project.org>;
	Wed, 21 May 2008 17:53:44 +0200 (CEST)
In-Reply-To: <4834438A.4060702@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Timur Tabi wrote:
> I have an ASoC driver with a _hw_params, _prepare, and _trigger functions.  I've
> recently discovered that I need to keep one of my devices disabled until
> playback starts.
>
> So I would like to know if ALSA will ever call _hw_params, _prepare, or _trigger
> if playback or capture is currently in process, or will ALSA first call the
> _trigger to stop/pause the driver.

While a stream is running (after trigger with START), ALSA will only
call the pointer or the trigger (STOP/PAUSE/SUSPEND) callbacks.

Different streams are not synchronized in any way.  (This also applies to
the playback/capture streams of one card.)


Regards,
Clemens
