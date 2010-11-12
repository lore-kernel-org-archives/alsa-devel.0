From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2 0/3] ASoC: Extend DAPM to handle
	cross-device paths
Date: Fri, 12 Nov 2010 13:51:44 +0000
Message-ID: <20101112135144.GC17283@rakim.wolfsonmicro.main>
References: <1289553806-28625-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A34722413A
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 14:51:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1289553806-28625-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 12, 2010 at 11:23:23AM +0200, Jarkko Nikula wrote:

> One fix is in beginning of dapm_power_widgets that d->dev_power is zeroed only

Fix relative to the previous version, this is?

> for those codecs that have widgets in order to avoid unnecessary widgetless
> codec bias shutdowns.

Hrm, I think we should probably consider just requring all devices to
have at least stub DAPM support.  It's probably simpler than having to
special case them, we should be able to add a utility function which
adds default stubs to minimise the code impact.
