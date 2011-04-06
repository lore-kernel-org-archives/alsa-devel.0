From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Dynamic control commands that match the
	downloadable DSP firmware
Date: Thu, 7 Apr 2011 08:18:57 +0900
Message-ID: <20110406231855.GD5297@opensource.wolfsonmicro.com>
References: <B2150E1E4418E1438554A300EA5040E40DAC774969@ITSVLEX06.it.maxim-ic.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E1F9D103876
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Apr 2011 01:18:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <B2150E1E4418E1438554A300EA5040E40DAC774969@ITSVLEX06.it.maxim-ic.internal>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Hsiang <Peter.Hsiang@maxim-ic.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 06, 2011 at 03:51:49PM -0700, Peter Hsiang wrote:
> Hi Mark and Everyone,

As previously mentioned fix your mail client to word wrap within
paragraphs.  Not doing this makes your mails very hard to read and reply
to.  I've reflowed your text.

> Rather than hard coding the control commands in the driver directly,
> wouldn't it be cool if, in addition to the firmware being loaded from
> file, the control commands information can be loaded from file as
> well.  Then the driver would dynamically create and install the
> control commands the same way we already do for the EQ.

Yes, this is one of the topics that's on the agenda for the ASoC
conference next month.  There's some tricks here as for many DSPs there
are sequencing requirements for updating the controls, especially things
like coefficient banks, or constraints on which firmware features can be
active simultaneously both of which make a purely data driven approach
more complex than it could be.

With more complex systems it's not just controls but also DAPM that can
need updating, and of course we also need to manage changing firmwares
at runtime and convincing firmware vendors to supply data that ALSA can
comprehend.
