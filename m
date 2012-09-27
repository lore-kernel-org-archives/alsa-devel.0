From: Herton Ronaldo Krzesinski <herton.krzesinski@canonical.com>
Subject: Re: [PATCH] ALSA: hda/realtek - Fix detection of
	ALC271X codec
Date: Thu, 27 Sep 2012 11:04:35 -0300
Message-ID: <20120927140434.GA3211@herton-Z68MA-D2H-B3>
References: <1348753094-15618-1-git-send-email-herton.krzesinski@canonical.com>
 <5064598C.30303@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D55B264F02
 for <alsa-devel@alsa-project.org>; Thu, 27 Sep 2012 16:04:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5064598C.30303@canonical.com>
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

On Thu, Sep 27, 2012 at 03:50:04PM +0200, David Henningsson wrote:
> On 09/27/2012 03:38 PM, Herton Ronaldo Krzesinski wrote:
> >In commit af741c1 ("ALSA: hda/realtek - Call alc_auto_parse_customize_define()
> >always after fixup"), alc_auto_parse_customize_define was moved after
> >detection of ALC271X.
> >
> >The problem is that detection of ALC271X relies on spec->cdefine.platform_type,
> >and it's set on alc_auto_parse_customize_define.
> >
> >Move the alc_auto_parse_customize_define and its required fixup setup
> >before the block doing the ALC271X and other codec setup.
> >
> >BugLink: https://bugs.launchpad.net/bugs/1006690
> >Signed-off-by: Herton Ronaldo Krzesinski <herton.krzesinski@canonical.com>
> 
> Looks good. I would add a cc to stable though.
> 
> Reviewed-by: David Henningsson <david.henningsson@canonical.com>

Thanks. Indeed, we should add a cc stable to this one (3.4+), forgot
about it.

-- 
[]'s
Herton
