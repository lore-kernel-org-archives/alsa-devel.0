From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Fix race condition in widgets
 power list creation
Date: Tue, 18 Jan 2011 10:39:54 +0000
Message-ID: <20110118103954.GA26498@opensource.wolfsonmicro.com>
References: <1295318127-17968-1-git-send-email-misael.lopez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CDBF3103813
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 12:03:25 +0100 (CET)
Received: from rakim.wolfsonmicro.main (lumison.wolfsonmicro.com
	[87.246.78.27])
	by opensource2.wolfsonmicro.com (Postfix) with ESMTPSA id 630423B438E
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 11:03:25 +0000 (GMT)
Resent-Message-ID: <20110118110324.GC26498@opensource.wolfsonmicro.com>
Resent-To: alsa-devel@alsa-project.org
Content-Disposition: inline
In-Reply-To: <1295318127-17968-1-git-send-email-misael.lopez@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Misael Lopez Cruz <misael.lopez@ti.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 17, 2011 at 08:35:27PM -0600, Misael Lopez Cruz wrote:
> Multiple calls to dapm_power_widgets() can create a race condition
> causing power list to be corrupted. Those scenarios can occur in
> multistream usecases, stream start/stop along with simultaneous
> update power calls (mixer, mux, dapm_sync, stream_event).

> A new 'dapm_mutex' is added to soc_card, which is held while power
> list is created.

This needs a bit more analysis - why are we getting multiple
simultaneous calls to dapm_power_widgets() and is that itself safe?  The
ASoC locking model has always been to have a big lock around the entire
card rather than to lock subcomponents, and for example this isn't going
to make sure we're consistent with register map accesses from other
parts of the code.
