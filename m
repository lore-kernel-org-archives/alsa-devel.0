From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: DAPM widgets beyond 2.6.38
Date: Fri, 25 Mar 2011 10:47:14 +0000
Message-ID: <20110325104714.GA22502@sirena.org.uk>
References: <B2150E1E4418E1438554A300EA5040E40DAC058842@ITSVLEX06.it.maxim-ic.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C9E3B1037EC
	for <alsa-devel@alsa-project.org>; Fri, 25 Mar 2011 11:47:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <B2150E1E4418E1438554A300EA5040E40DAC058842@ITSVLEX06.it.maxim-ic.internal>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 24, 2011 at 07:47:40PM -0700, Peter Hsiang wrote:

As ever always CC maintainers on mails if you want them to see them
reliably.

> 1) In 2.6.38, after these 2 operations: 
>   snd_soc_dapm_new_controls(dapm, dapm_widgets, ARRAY_SIZE(dapm_widgets));
>   snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
> Is it *always* necessary to call snd_soc_dapm_new_widgets(dapm)?  
> I have seen one case where it was not called.

It's not actually required for CODEC drivers, the core will run it when
probe finishes.

> 2) In 2.6.39, to do the same, is there any function to call other than the table entries?

Not for the DAPM init.
