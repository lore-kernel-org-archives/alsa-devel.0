From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: No device for DAI omap-eac-dai error
Date: Sun, 20 Dec 2009 12:59:26 +0000
Message-ID: <20091220125925.GB2881@sirena.org.uk>
References: <e7c6a05e0912180618h771b9b7fl9d197d500bc534c1@mail.gmail.com>
	<e7c6a05e0912190851q273555beg2f1ed415a8c9399f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 445091037F7
	for <alsa-devel@alsa-project.org>; Sun, 20 Dec 2009 13:59:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <e7c6a05e0912190851q273555beg2f1ed415a8c9399f@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Belisko Marek <marek.belisko@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Dec 19, 2009 at 05:51:59PM +0100, Belisko Marek wrote:

> I'm writing new omap dai (for EAC codec base omap's).
> My code is based on existing omap-mcbsp.c code basically.

> After loadingof module I got error which appear in init function when
> call snd_soc_register_dai().

> I browse for code but can't figure out where dai->dev should be set to
> don't get error message and init dai properly.

> Thanks for any suggestions

There ought to be a platform device associated with the McBSP port which
provides the struct device to use, but currently OMAP doesn't do that.
