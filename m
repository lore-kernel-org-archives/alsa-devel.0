From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Use codec mutex in dapm_set_pga()
Date: Thu, 1 Oct 2009 11:37:14 +0100
Message-ID: <20091001103714.GB14417@sirena.org.uk>
References: <1254377856-5588-1-git-send-email-ext-eero.nurkkala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 137DF103821
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 12:37:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1254377856-5588-1-git-send-email-ext-eero.nurkkala@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext-eero.nurkkala@nokia.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 01, 2009 at 09:17:36AM +0300, ext-eero.nurkkala@nokia.com wrote:
> From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

> codec->mutex seems required if widget->* values
> are altered. Moreover, snd_soc_dapm_put_volsw()
> may alter widget->saved_value. dapm_set_pga()
> uses widget->saved_value in a for loop which now
> has a distant chance of getting out of control.

Hrm.  This doesn't look right.  dapm_set_pga() is only called from
within the DAPM power updates so we should've taken the codec mutex much
further up the stack otherwise all the DAPM list walking and updating
will have issues.  Was this just from code inspection or are you running
into actual issues?
