From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] SOC: UDA134x: Enable POWER_OFF_ON_STANDBY
	define.
Date: Tue, 3 May 2011 11:00:43 +0100
Message-ID: <20110503100042.GA1762@opensource.wolfsonmicro.com>
References: <1304415149-19725-1-git-send-email-marek.belisko@open-nandra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F18291037FB
	for <alsa-devel@alsa-project.org>;
	Tue,  3 May 2011 12:00:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1304415149-19725-1-git-send-email-marek.belisko@open-nandra.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Belisko <marek.belisko@open-nandra.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 03, 2011 at 11:32:29AM +0200, Marek Belisko wrote:
> Without this define we can't get any sound from codec so enable
> it by default. This define unlock bias settings which control
> power control for DAC and ADC (by default 0 0 which is off off).

If this is essential why is it optional in the first place?
