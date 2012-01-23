From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Sound WM8958 DSP2: Use correct format
 string in dev_err() call
Date: Mon, 23 Jan 2012 21:11:07 +0000
Message-ID: <20120123211107.GD26409@opensource.wolfsonmicro.com>
References: <alpine.LNX.2.00.1201232113400.8772@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CEC452441A
	for <alsa-devel@alsa-project.org>; Mon, 23 Jan 2012 22:11:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1201232113400.8772@swampdragon.chaosbits.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jesper Juhl <jj@chaosbits.net>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Ian Lartey <ian@opensource.wolfsonmicro.com>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 23, 2012 at 09:15:48PM +0100, Jesper Juhl wrote:
> To print a value of type size_t one should use %zd, not %d.

Applied, thanks, but please do at least try to use a subject line in the
style for the subsystem.
