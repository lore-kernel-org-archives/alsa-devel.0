From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Fix section mismatch in wm8995.c
Date: Tue, 11 Jan 2011 17:10:22 +0000
Message-ID: <20110111171013.GK6541@sirena.org.uk>
References: <s5hpqs39xvl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C6912103A40
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 18:10:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hpqs39xvl.wl%tiwai@suse.de>
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 11, 2011 at 06:02:54PM +0100, Takashi Iwai wrote:

> I noticed the section mismatch in wm8995.c, and fixed now on topic/asoc
> branch with the patch below.

Hrm, it'd be better to find some annotation for the pointer which lets
us have the reference.  We at a higher level only dereference the
pointer from the probe path, preventing the discard isn't a great
solution.
