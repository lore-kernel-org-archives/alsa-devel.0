From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Improve the debugfs hierarchy
Date: Fri, 2 Oct 2009 11:24:44 +0100
Message-ID: <20091002102444.GC14249@rakim.wolfsonmicro.main>
References: <1254464257-884-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4F850243D4
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Oct 2009 12:24:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1254464257-884-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 02, 2009 at 09:17:37AM +0300, Peter Ujfalusi wrote:
> Change the way the debugfs entries are created:
> If the codec->dev is valid, than use:
> debugfs/asoc/{codec->name}.{dev_name(codec->dev)}/
> 
> if the codec->dev is NULL:
> debugfs/asoc/{codec->name}/
> 
> as root for the debugfs entries.

Applied, thanks.
