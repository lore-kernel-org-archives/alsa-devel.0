From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: ALSA and SALSA install
Date: Fri, 7 Mar 2008 20:31:27 +0000
Message-ID: <200803072031.27878.gineera@aspect135.co.uk>
References: <200803061641.33445.gineera@aspect135.co.uk>
	<47D01FCB.2010509@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (wmsmtp.opaltelecom.net [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D1DB103924
	for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2008 21:02:17 +0100 (CET)
In-Reply-To: <47D01FCB.2010509@ladisch.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thursday 06 March 2008 16:46, Clemens Ladisch wrote:
> Alan Horstmann wrote:
> > Is there a way to install both at the same time, so on a PC code can be
> > compiled and experimented with first -lasound and then -lsalsa without
> > alternately re-installing the libraries with make install?
>
> It should be possible to install salsa-lib into another directory (by
> using the *prefix configure options) and then to change the include
> and library paths when compiling the program that uses it.
>

Thanks, that is the sort of thing I had hoped was possible; will try that at 
the next opportunity.

Alan
