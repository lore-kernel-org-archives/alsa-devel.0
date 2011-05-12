From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: hdspmixer/ubuntu
Date: Thu, 12 May 2011 10:36:20 +0200
Message-ID: <20110512083620.GQ24348@ltw.loris.tv>
References: <iqb15b$hrl$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id CF216103831
	for <alsa-devel@alsa-project.org>;
	Thu, 12 May 2011 10:36:44 +0200 (CEST)
Received: from localhost (ltw.loris.tv [127.0.0.1])
	by ltw.loris.tv (Postfix) with ESMTP id 73B49500054
	for <alsa-devel@alsa-project.org>;
	Thu, 12 May 2011 10:36:34 +0200 (CEST)
Received: from ltw.loris.tv ([127.0.0.1])
	by localhost (ltw.loris.tv [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 0CmBsshfW7Tw for <alsa-devel@alsa-project.org>;
	Thu, 12 May 2011 10:36:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <iqb15b$hrl$1@dough.gmane.org>
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

On Tue, May 10, 2011 at 11:39:55AM +0200, Tim Blechmann wrote:

> hi all,

Hi!

> the current version of ubuntu ships alsa-tools without hdspmixer [1],
> [1] https://bugs.launchpad.net/ubuntu/+source/alsa-tools/+bug/723276

I agree with David (from the bug report) that there might be some
trouble with the build system or missing dependency.

> - gitcompile currently does not work on ubuntu, but requires this
> patch [2] in 

That's not exactly true. I guess calling gitcompile in the hdspmixer sub
directory (in contrast to the toplevel directory) would give you a
working hdspmixer.

I don't know if Ubuntu provides non-security related updates after a
release. If not, somebody should simply package a git checkout in a PPA.



Cheers

-- 
mail: adi@thur.de  	http://adi.thur.de	PGP/GPG: key via keyserver
