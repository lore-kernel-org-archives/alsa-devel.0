From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ALSA: Build jack detection
Date: Mon, 28 Jul 2008 15:24:05 +0100
Message-ID: <20080728142405.GB18572@sirena.org.uk>
References: <20080727111107.GA6667@sirena.org.uk>
	<1217157145-7647-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217157145-7647-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217157145-7647-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hy73mqhud.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 251F4103883
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Jul 2008 16:24:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hy73mqhud.wl%tiwai@suse.de>
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

On Mon, Jul 28, 2008 at 03:05:46PM +0200, Takashi Iwai wrote:

> Would be nice to put this as a comment in sound/core/Kconfig.

Yeah, the need for that is one of the reasons why I originally made the
requirement for INPUT unconditional - there's no good, idiomatic way to
document any funny stuff like this.  I suspect that once there's one
user future users will just cargo cult them anyway.
