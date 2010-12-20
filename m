From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Add optional pointer to machine
 audio routes to snd_soc_card
Date: Mon, 20 Dec 2010 09:24:28 +0000
Message-ID: <1292837068.3304.2.camel@odin>
References: <1292607580-27040-1-git-send-email-jhnikula@gmail.com>
	<20101217223709.GA28118@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 76D5C244A7
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 10:24:32 +0100 (CET)
Received: by wyi11 with SMTP id 11so2575086wyi.38
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 01:24:31 -0800 (PST)
In-Reply-To: <20101217223709.GA28118@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Peter@alsa-project.org, Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-12-17 at 22:37 +0000, Mark Brown wrote:
> On Fri, Dec 17, 2010 at 07:39:40PM +0200, Jarkko Nikula wrote:
> > This is targeted mostly to cross-device setups where single audio map
> > defining routes around and between the codecs looks cleaner than defining
> > and registering maps to each codec separately from machine init callbacks.
> > 
> > This could be also used to reduce simple machine init callbacks where only
> > snd_soc_dapm_add_routes and snd_soc_dapm_sync are called. However, this does
> > work only if the widgets names are unique in the system.
> > 
> > Idea of common audio map came from Peter Ujfalusi <peter.ujfalusi@nokia.com>.
> 
> Good idea.  We should probably just do this for CODECs as well, they're
> often doing similar boiler plate type stuff.

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
