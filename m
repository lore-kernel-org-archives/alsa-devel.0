From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 34/36] sound/soc/blackfin: Remove
 unnecessary casts of private_data
Date: Tue, 13 Jul 2010 11:45:48 +0100
Message-ID: <1279017948.3125.40.camel@odin>
References: <cover.1278967120.git.joe@perches.com>
	<1c7c609ba4910da572c7888069707548af187651.1278967121.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id E0FE32441B
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Jul 2010 12:45:56 +0200 (CEST)
Received: by wyf19 with SMTP id 19so4015593wyf.38
	for <alsa-devel@alsa-project.org>; Tue, 13 Jul 2010 03:45:56 -0700 (PDT)
In-Reply-To: <1c7c609ba4910da572c7888069707548af187651.1278967121.git.joe@perches.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joe Perches <joe@perches.com>
Cc: alsa-devel@alsa-project.org, Jiri Kosina <trivial@kernel.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-07-12 at 13:50 -0700, Joe Perches wrote:
> Signed-off-by: Joe Perches <joe@perches.com>

Fwiw, we are getting rid of the void * private_data in the ASoC
multi-component patch series and will use dev_get_drvdata() style
accessors.

Both ASoC patches

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
