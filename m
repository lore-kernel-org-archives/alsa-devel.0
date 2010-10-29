From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC_ii/iv 2/3] ASoC: Move widgets from DAPM
 context to snd_soc_card
Date: Fri, 29 Oct 2010 13:57:39 -0700
Message-ID: <20101029205738.GH3921@opensource.wolfsonmicro.com>
References: <1288353742-22005-1-git-send-email-jhnikula@gmail.com>
	<1288353742-22005-2-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D633D10386B
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Oct 2010 22:57:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1288353742-22005-2-git-send-email-jhnikula@gmail.com>
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

On Fri, Oct 29, 2010 at 03:02:21PM +0300, Jarkko Nikula wrote:
> Decoupling widgets from DAPM context is required when extending the ASoC
> core to cross-device paths. Even the list of widgets are now kept in
> struct snd_soc_card, the widget listing in sysfs and debugs remain sorted
> per device.

This also looks good.
