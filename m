From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add optional pointer to
	machine	audio routes to snd_soc_card
Date: Fri, 17 Dec 2010 22:37:09 +0000
Message-ID: <20101217223709.GA28118@sirena.org.uk>
References: <1292607580-27040-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B0A11037FC
	for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2010 23:37:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1292607580-27040-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 17, 2010 at 07:39:40PM +0200, Jarkko Nikula wrote:
> This is targeted mostly to cross-device setups where single audio map
> defining routes around and between the codecs looks cleaner than defining
> and registering maps to each codec separately from machine init callbacks.
> 
> This could be also used to reduce simple machine init callbacks where only
> snd_soc_dapm_add_routes and snd_soc_dapm_sync are called. However, this does
> work only if the widgets names are unique in the system.
> 
> Idea of common audio map came from Peter Ujfalusi <peter.ujfalusi@nokia.com>.

Good idea.  We should probably just do this for CODECs as well, they're
often doing similar boiler plate type stuff.
