From: John Rigg <aldev@sound-man.co.uk>
Subject: Re: [PATCH] hdspm: native float
Date: Thu, 16 Apr 2009 19:32:42 +0100
Message-ID: <20090416183242.GA2713@localhost>
References: <1239883941.10715.26.camel@x200.watzmann.local>
	<20090416124159.GN16318@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.uklinux.net (mail3.uklinux.net [80.84.72.33])
	by alsa0.perex.cz (Postfix) with ESMTP id C3FA124434
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 20:17:30 +0200 (CEST)
Received: from localhost (unknown [78.32.150.178])
	by mail3.uklinux.net (Postfix) with ESMTP id 7C9B91F7722
	for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2009 19:17:30 +0100 (BST)
Received: from anon by localhost with local (Exim 4.63)
	(envelope-from <john@sound-man.co.uk>) id 1LuWOA-0000i0-6R
	for alsa-devel@alsa-project.org; Thu, 16 Apr 2009 19:32:42 +0100
Content-Disposition: inline
In-Reply-To: <20090416124159.GN16318@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 16, 2009 at 01:41:59PM +0100, Mark Brown wrote:
> On Thu, Apr 16, 2009 at 02:12:21PM +0200, Florian Faber wrote:
> 
> > > > It is a global change. The only use case is for jack, and jack doesn't
> > > > use different formats for input/output.
> > > "Using aplay + arecord" is a second use case.  :-)
> 
> > And they would willingly choose different formats?
> 
> A moderately common case is recording voice quality audio (at 8kHz or
> so) and playing back higher quality audio.

Perhaps a little less common on a 64-channel MADI interface
like this :-)

John
