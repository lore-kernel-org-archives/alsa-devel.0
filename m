From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: Fix double free and memory leak in
	many codec drivers
Date: Mon, 25 Aug 2008 13:11:49 +0100
Message-ID: <20080825121147.GA24258@sirena.org.uk>
References: <1219661360-3555-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hljyle2ft.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8BE3024443
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Aug 2008 14:11:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hljyle2ft.wl%tiwai@suse.de>
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
Cc: Jean Delvare <khali@linux-fr.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 25, 2008 at 01:53:10PM +0200, Takashi Iwai wrote:

> This looks like a 2.6.27 material, right?

Ideally, yes.

> I applied to for-linus branch now.  Thanks.

Thanks.
