From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: additional problem
Date: Fri, 1 Jul 2011 01:01:52 +0800
Message-ID: <20110630170152.GG26397@qtel.sh.intel.com>
References: <4E0B2F67.3070304@digital-pipe.com>
	<4E0C68ED.1070506@digital-pipe.com>
	<4E0C99B2.3070103@digital-pipe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 94D5A10384A
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Jun 2011 19:05:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E0C99B2.3070103@digital-pipe.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henderson <dhenderson@digital-pipe.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 30, 2011 at 11:43:46PM +0800, David Henderson wrote:
> On 06/30/2011 08:15 AM, David Henderson wrote:
> > On 06/29/2011 09:57 AM, David Henderson wrote:
> >> Hi gang!  I've successfully been able to compile the alsa-utils 
> >> package with the 
> >> "--with-alsa-inc-prefix=/opt/staging/alsa/var/share/include 
> >> --with-alsa-prefix=/opt/staging/alsa/lib", but the problem I'm having 
> >> now is that the compiled binaries are looking for those directories 
> >> during run-time and not just compile-time.  Does anyone have any 
> >> thoughts on using those directories for package creation, but that 
> >> the software doesn't use the '/opt/staging/alsa' prefix during run-time?
> >>
> >> Thanks,
> >> Dave
> >
> > bump for help
> 
> Maybe I'm asking the wrong questions :), so lets try this... what are 
> the recommended steps to compile this software for package maintainers?

I'm not the maintainer, so it might not be correct. They might use some
kind of auto build services, e.g. build.opensuse.org

> 
> Thanks
> Dave
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
guanqun
