From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: probing state of high definition audio card
	in	windows / SigmaTel STAC9221 microphone problems
Date: Fri, 08 Jun 2007 16:07:47 -0700
Message-ID: <1181344067.5053.8.camel@razman.gruemaster.com>
References: <4669311C.6020800@stanford.edu>
	<75b66ecd0706081524v6242f1adw1038dc27d015ab4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 1ECB124496
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Jun 2007 01:07:49 +0200 (CEST)
In-Reply-To: <75b66ecd0706081524v6242f1adw1038dc27d015ab4d@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Eran Guendelman <erang@stanford.edu>
List-Id: alsa-devel@alsa-project.org

For Sigmatel Codecs, this is correct.  You need to look at the verb
tables in the inf file.  Other HD Audio drivers have the verb tables
built into the driver, and the inf file just tells the driver which
table to use.

As to building a program to gather this information, I have actually
been thinking of adding a virtual hal to Xen that would imitate an HD
Audio bus.  This way, I could see what the driver is doing, just by
running Windows in a virtual machine.  I need to see if this violates
any reverse engineering regulations first.

Tobin



On Fri, 2007-06-08 at 18:24 -0400, Lee Revell wrote:

> On 6/8/07, Eran Guendelman <erang@stanford.edu> wrote:
> > So the question is, does anyone have a ready-made utility for Windows to
> > do this probe of the high definition audio codec?  I could probably try
> > writing one myself, but thought I'd check if it already exists.
> 
> I think it's just in the .inf file.
> 
> Lee
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis <tdavis@dsl-only.net>
