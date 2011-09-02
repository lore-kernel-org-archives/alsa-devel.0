From: Greg KH <greg@kroah.com>
Subject: Re: submitting patch: specify destination kernel
 version(s)
Date: Fri, 2 Sep 2011 06:57:35 -0700
Message-ID: <20110902135735.GA28815@kroah.com>
References: <1322a11922c.1088573675407063638.-3372964620296301533@zoho.com>
	<CACTFLAN-HSBbYz1NQo7oLyMqz50wvz_dhTRBWA+OF2gVp6b=1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 7D2AA24420
	for <alsa-devel@alsa-project.org>;
	Sat,  3 Sep 2011 02:19:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CACTFLAN-HSBbYz1NQo7oLyMqz50wvz_dhTRBWA+OF2gVp6b=1w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Torsten Schenk <torsten.schenk@zoho.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 02, 2011 at 02:50:36PM +0200, Daniel Mack wrote:
> On Fri, Sep 2, 2011 at 2:16 PM, Torsten Schenk <torsten.schenk@zoho.com> wrote:
> > Hi,
> >
> > I'm currently preparing a patch for the kernel, I want it to be included from 3.0 on, but not in versions before. I once got a hint to put
> >
> > Cc: stable@kernel.org
> >
> > but that seems not to do the trick. How could it be achieved, that the patch only appears in 3.0 (and later)?
> >
> 
> This is not really officially documented, but there seems to be a
> general agreement that this line should do what you want:
> 
>   Cc: stable@kernel.org [3.0+]
> 
> At least, other patches were submitted that way. Greg, is that correct?

Yes, that is correct.

Please see Documentation/stable_kernel_rules.txt for the details.

greg k-h
