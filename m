From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH 02/12] ASoC: da9055: Fix module autoload
 for OF platform driver
Date: Thu, 3 Sep 2015 13:21:51 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337AB56E137@SW-EX-MBX01.diasemi.com>
References: <20150903105554.GA16761@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com
 [193.109.254.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 990A4260699
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2015 15:22:21 +0200 (CEST)
In-Reply-To: <20150903105554.GA16761@goodgumbo.baconseed.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Luis de Bethencourt <luis@debethencourt.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Support Opensource <Support.Opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On September 03, 2015 11:56, Luis de Bethencourt wrote:

> This platform driver has a OF device ID table but the OF module
> alias information is not created so module autoloading won't work.
> 
> Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>
> ---

Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
