From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Driver code with mpc5200 pointer problem.
Date: Mon, 4 May 2009 14:00:40 +0100
Message-ID: <20090504130039.GM6975@sirena.org.uk>
References: <alpine.LNX.2.00.0904281022210.25064@eeebox2.perex-int.cz>
	<s5hiqkp16w6.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0904281131440.25064@eeebox2.perex-int.cz>
	<s5h7i1514bn.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0904281206260.25064@eeebox2.perex-int.cz>
	<s5h3abt132e.wl%tiwai@suse.de> <s5hvdoh8gvp.wl%tiwai@suse.de>
	<9e4733910905040529s3376153fj3191295b06e7c7c9@mail.gmail.com>
	<s5hy6tddomr.wl%tiwai@suse.de>
	<9e4733910905040558i7f8d9450h8f10ce96f9cf8868@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B95F243CB
	for <alsa-devel@alsa-project.org>;
	Mon,  4 May 2009 15:00:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910905040558i7f8d9450h8f10ce96f9cf8868@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, May 04, 2009 at 08:58:04AM -0400, Jon Smirl wrote:
> On Mon, May 4, 2009 at 8:43 AM, Takashi Iwai <tiwai@suse.de> wrote:

> > Great. ?So can we remove BROKEN kconfig again?

> Sure. There are only two current users of the driver and we know what
> is going on.

Could you expand on what you mean by "we know what is going on"?  If the
driver is fixed then there shouldn't really be anything for anyone to
know, the driver should just work.

I wouldn't count on you being the only users - you may be the only
people visibly talking about the driver in public but that's not quite
the same thing as being the only users.
