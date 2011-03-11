From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: question on snd_power_change_state()
Date: Fri, 11 Mar 2011 13:53:13 +0000
Message-ID: <20110311135313.GA29920@sirena.org.uk>
References: <201103111312.17360.oneukum@suse.de>
	<201103111320.46750.oneukum@suse.de> <s5hmxl1kf92.wl%tiwai@suse.de>
	<201103111342.44722.oneukum@suse.de> <s5hk4g5kdg7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 715C2103826
	for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2011 14:53:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hk4g5kdg7.wl%tiwai@suse.de>
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
Cc: Oliver Neukum <oneukum@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 11, 2011 at 02:13:12PM +0100, Takashi Iwai wrote:
> Oliver Neukum wrote:

> > A helper for restoring all mixer settings that a device has lost due to a loss
> > of power.

> No.  It's driver-specific.

If you're working within ASoC the register cache code has support for
syncing back to hardware.
