From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: CORRECTION (get rid of controls
	with?snd_ctl_remove )
Date: Tue, 2 Sep 2008 10:46:17 +0100
Message-ID: <20080902094615.GA25176@sirena.org.uk>
References: <200808291454.42441.harryrat@postnuklear.de>
	<200809011309.22478.harryrat@postnuklear.de>
	<1220269870.6499.107.camel@odin>
	<200809021002.13540.harryrat@postnuklear.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A68901037F8
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Sep 2008 11:46:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200809021002.13540.harryrat@postnuklear.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Harald Radke <harryrat@postnuklear.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 02, 2008 at 10:02:13AM +0200, Harald Radke wrote:

> Hm, a great thing would be to have something like "codec_instanciate()" where 
> u could select a codec device and an array with control names and values for 
> items to be deactivated and get the "modified" codec...but I guess that would 
> be ways to high level for the sound driver structure (;

For the greatest flexibility you really want the activation and
deactivation to be doable via user space - many devices (especially
complex ones like smartphones) can run with several different audio
setups and need to change between them on the fly at run time.  Trying
to encode all the possible scenarios in the kernel makes for a
relatively large amount of work when there are a lot of options.

Liam has been working on an API to facilitate that sort of scenario
setup:

	http://opensource.wolfsonmicro.com/node/14
