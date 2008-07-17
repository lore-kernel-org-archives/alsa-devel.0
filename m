From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: Refector DAPM event handler
Date: Thu, 17 Jul 2008 13:53:22 +0100
Message-ID: <20080717125320.GD15333@sirena.org.uk>
References: <1216292376-2583-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5habgghe74.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1859E24335
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Jul 2008 14:53:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5habgghe74.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 17, 2008 at 02:45:19PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > The DAPM event callback code has many layers of indentation. Refector

> Refactor?

Rewrite it into something functionally equivalent but has fewer layers
of indentation.
