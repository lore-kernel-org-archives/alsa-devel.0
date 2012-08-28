From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: hda: Make core jack usage
 unconditional
Date: Mon, 27 Aug 2012 20:23:14 -0700
Message-ID: <20120828032313.GA22374@opensource.wolfsonmicro.com>
References: <1346093603-27675-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <503C027B.1020904@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7AB32265F48
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2012 05:23:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <503C027B.1020904@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 27, 2012 at 04:27:55PM -0700, David Henningsson wrote:
> 2012-08-27 11:53, Mark Brown skrev:
> >Currently the HDA drivers have a Kconfig variable SND_HDA_INPUT_JACK
> >which disables jack reporting via the ALSA core jack API. This is bad
> >since (modulo the current problems with the HDA-specific reporting
> >API) it means that all reporting mechanisms will get disabled, not just
> >input.

> Can you explain what other "reporting mechanisms" you are referring to?

The ctljack stuff when I wrote it - this is the first part of a patch
set intended to merge the in kernel APIs for this stuff but there's a
bunch of problems with the rest of the series so I never got round to
sending it.  I figured it did no harm in itself and makes things a
little more consistent to userspace.
