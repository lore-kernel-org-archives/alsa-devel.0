From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Swapped channels issue on pxa-ssp based platforms
Date: Mon, 07 Nov 2011 21:19:07 +0100
Message-ID: <4EB83D3B.2050906@ladisch.de>
References: <4EB817FC.4000905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id B8B2C2450D
	for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2011 21:19:20 +0100 (CET)
In-Reply-To: <4EB817FC.4000905@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sven Neumann <s.neumann@raumfeld.com>, Liam Girdwood <lrg@ti.com>, Haojian Zhuang <haojian.zhuang@marvell.com>
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> we're hunting a weird bug on PXA3xx/ssp based audio devices which causes
> the playback channels to be swapped when the capture stream is started
> at the same time. Content for the left channel appears on the right and
> vice versa, in approximately 50% of all test runs

IIRC there was some other CPU where it was tried to program a generic
serial output to handle I=B2S data.  The same symptoms appeared because
it was not possible to synchronize the start of the L/R signal to the
start of the DMA.

Apparently, the starting of the capture stream affects the L/R
synchronization of the playback stream.

Does starting playback first work?

> I guess this is some sort of a race condition in the stream startup,
> and suspected sound/soc/pxa/pxa-ssp.c to lack some locking, so I added
> a spinlock around all register read-modify-write cycles. But that doesn't
> seem to be the reason.

I'd guess this is a race in the programming of the L/R clock signals;
try putting a lock/mutex about all the stream initialization code, and
maybe adding some delay.


Regards,
Clemens
