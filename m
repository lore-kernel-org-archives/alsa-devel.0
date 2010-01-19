From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] Davinci: DM365: Enable DaVinci
	Voice	Codec support for DM365 EVM
Date: Tue, 19 Jan 2010 22:10:15 +0000
Message-ID: <20100119221015.GA29306@sirena.org.uk>
References: <1262902641-14821-1-git-send-email-miguel.aguilar@ridgerun.com>
	<20100108113121.GB10128@sirena.org.uk>
	<4B476D3B.3050200@ridgerun.com>
	<20100108193720.GA3088@sirena.org.uk>
	<4B4B3F97.8060508@ridgerun.com>
	<20100111153458.GA2661@rakim.wolfsonmicro.main>
	<4B4B4987.1080507@ridgerun.com>
	<20100111162101.GA26771@rakim.wolfsonmicro.main>
	<4B561A54.6070201@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3DAFE243B4
	for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2010 23:10:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B561A54.6070201@ridgerun.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com, "Nori, Sekhar" <nsekhar@ti.com>, diego.dompe@ridgerun.com, alsa-devel@alsa-project.org, "Narnakaje, Snehaprabha" <nsnehaprabha@ti.com>, todd.fischer@ridgerun.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 19, 2010 at 02:47:16PM -0600, Miguel Aguilar wrote:

> But I can set only one at a time in the dm365_evm_snd_devdata:

...

> So in case what is the proper way to do this?

For now use an ifdef in the machine driver.  There's some work due to
begin fairly shortly (I've CCed in my co-maintainer Liam who's actually
going to be doing the work) to allow multiple CODECs to work
simultaneously, if you put the ifdef in the machine driver now then it
should be straightforward to update the machine driver to make use of
this new feature when it's ready.
