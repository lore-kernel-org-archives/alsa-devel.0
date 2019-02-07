From: Russell Parker <russell.parker7@gmail.com>
Subject: Re: [PATCH] UCM: bytcr/PlatformEnableSeq.conf update
	some comments
Date: Wed, 6 Feb 2019 18:42:46 -0800
Message-ID: <20190207024246.GA31500@celes>
References: <20190203113741.15203-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by alsa0.perex.cz (Postfix) with ESMTP id F3282267437
 for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2019 03:49:07 +0100 (CET)
Received: by mail-pg1-f194.google.com with SMTP id w7so3837302pgp.13
 for <alsa-devel@alsa-project.org>; Wed, 06 Feb 2019 18:49:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20190203113741.15203-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/03, Hans de Goede wrote:
> Commit f91cc3c7d6b7 ("Update chtrt5645 ucm variants to use
> bytcr/PlatformEnableSeq.conf component") updated the
> following 2 comments:
> 
>  # codec0_out settings (used if SSP2 is connected to aif1)
>  # modem_out settings (used if SSP0 is connected to aif2)
> 
> Specifically it added the " to aif1" resp. " to aif2" part of the comments.
> 
> This is not correct, AIF1 / AIF2 are something which is present on
> Realtek codecs only, and either one can be used indepedent of
> SSP0 or SSP2 being used (the comments in the chtrt5645 UCM profile
> before this change were wrong / outdated).
> 
> Besides there not being any relationship between SSP0 or SSP2 being
> used, bytcr/PlatformEnableSeq.conf is also used with other codecs,
> e.g. the ESS8316 codec where this is not applicable at all.
> 
> Therefor this commit removes the " to aif?" part of the comments again
> to avoid confusing people reading this in the future.
> 
> Cc: Russell Parker <russell.parker7@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Thanks for updating the comments; I saw that the notes were in the rt5645
sequences and incorrectly assumed that it applied to the platform too. Glad
you caught it!
