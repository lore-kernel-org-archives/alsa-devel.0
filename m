From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 0/2] ASoC: New enum type for bitfield coded
	enums
Date: Mon, 5 Jan 2009 14:17:13 +0000
Message-ID: <20090105141712.GA29853@sirena.org.uk>
References: <1231142098-16886-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 91A6C1037FD
	for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2009 15:17:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1231142098-16886-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 05, 2009 at 09:54:56AM +0200, Peter Ujfalusi wrote:

> Technically it could be possible to add the new members (mask, *values) to the
> existing soc_enum structure, which could reduce the amount of new code needed to
> handle this new type. At least the snd_soc_info_value_enum_double,
> dapm_connect_value_mux, dapm_value_mux_update_power functions can be removed if
> I modify the soc_enum instead of introducing the new soc_value_enum.

Appled both, thanks.  It'd be good to merge the implementation of the
new type as you say above but that doesn't affect the external interface
so can easily be done as a later patch.
