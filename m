From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC: Fix double addition of prefixes due
 to widget prefixing
Date: Wed, 9 Mar 2011 13:47:48 +0200
Message-ID: <20110309134748.014ab0fd.jhnikula@gmail.com>
References: <1299670452-13290-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 19E5F103819
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2011 12:46:03 +0100 (CET)
Received: by ewy28 with SMTP id 28so108301ewy.38
	for <alsa-devel@alsa-project.org>; Wed, 09 Mar 2011 03:46:02 -0800 (PST)
In-Reply-To: <1299670452-13290-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed,  9 Mar 2011 11:34:12 +0000
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> We're not only prefixing all controls, we're also prefixing the widget
> names in the runtime data. This causes us to add the prefix twice - once
> when using the widget name to generate the control name and once when
> adding the control.
> 
> Really we shouldn't be prefixing the widget names at all, the matching
> code should be handing this as we always know which DAPM context a
> widget came from and always display the widget name in terms of a DAPM
> context.  However, we're quite close to the merge window and that's
> relatively invasive.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-dapm.c |   29 ++++++++++++++++++++++++++---
>  1 files changed, 26 insertions(+), 3 deletions(-)
> 
No problem anymore on N900.

Acked-by: Jarkko Nikula <jhnikula@gmail.com>
