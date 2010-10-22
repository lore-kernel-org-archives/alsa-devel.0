From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH] ALSA: HDA: Correctly apply
 position_fix quirks for ATI and VIA controllers
Date: Fri, 22 Oct 2010 09:00:42 -0700
Message-ID: <20101022160042.GC18595@kroah.com>
References: <4CA9A951.2010604@canonical.com> <4CA9BC8C.4030809@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	by alsa0.perex.cz (Postfix) with ESMTP id D60B3103838
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 19:00:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4CA9BC8C.4030809@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 04, 2010 at 01:37:48PM +0200, David Henningsson wrote:
> On 2010-10-04 12:15, David Henningsson wrote:
> >Position_fix quirks for specific machines now override the default
> >position_fix behavior for all HDA controllers.
> >
> >BugLink: http://launchpad.net/bugs/465942
> >BugLink: http://launchpad.net/bugs/580749
> >BugLink: http://launchpad.net/bugs/587546
> >
> >Signed-off-by: David Henningsson <david.henningsson@canonical.com>
> 
> ...and here's the version for 2.6.35 and 2.6.32 stable trees.

Ok, but what's the corrisponding fix in Linus's tree?  What is the git
id of the patch there?

Please resend your version with that information in it.

thanks,

greg k-h
