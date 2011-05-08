From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] SOC: UDA134x: Remove POWER_OFF_ON_STANDBY
	define.
Date: Sun, 8 May 2011 15:34:46 +0100
Message-ID: <20110508143446.GD15968@opensource.wolfsonmicro.com>
References: <1304426792-23540-1-git-send-email-marek.belisko@open-nandra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A135F1037FB
	for <alsa-devel@alsa-project.org>;
	Sun,  8 May 2011 16:34:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1304426792-23540-1-git-send-email-marek.belisko@open-nandra.com>
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

On Tue, May 03, 2011 at 02:46:32PM +0200, Marek Belisko wrote:
> Define POWER_OFF_ON_STANDBY cause trobles when trying to get some
> sound from codec because code for bias setup was not compiled
> (define wasn't defined). This define was removed in commit:
> cc3202f5 but again introduced by commit: f0fba2ad1 which then
> completely break codec functionality so remove it again.

Applied, thanks.
