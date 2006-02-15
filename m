From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Subject: Re: How to compile kernel with adding new alsa driver?
Date: Wed, 15 Feb 2006 11:37:34 +0000
Message-ID: <20060215113734.GA6465@palantir8>
References: <715d90900602131740v4e98723ak26c1fbe793322829@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mra04.ch.as12513.net (mra04.ch.as12513.net [82.153.252.44])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D8B961AC
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2006 12:37:38 +0100 (MET)
Received: from localhost (localhost [127.0.0.1])
	by mra04.ch.as12513.net (Postfix) with ESMTP id EA167C026B
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2006 11:37:39 +0000 (GMT)
Received: from mra04.ch.as12513.net ([127.0.0.1])
 by localhost (mra04.ch.as12513.net [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 28237-01-72 for <alsa-devel@alsa-project.org>;
 Wed, 15 Feb 2006 11:37:39 +0000 (GMT)
Received: from palantir8.mph.eclipse.net (unknown [81.168.73.77])
	by mra04.ch.as12513.net (Postfix) with ESMTP id 55E0CC08A1
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2006 11:37:39 +0000 (GMT)
Received: from mhabets by palantir8.mph.eclipse.net with local (Exim 3.36 #1 (Debian))
	id 1F9KyU-0001iQ-00
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2006 11:37:34 +0000
Content-Disposition: inline
In-Reply-To: <715d90900602131740v4e98723ak26c1fbe793322829@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 14, 2006 at 09:40:16AM +0800, boku wrote:
> Dear all,
>      How to compile linux kernel with adding my driver into alsa?

Do you build alsa inside or outside the kernel structure? If it's a
part of the normal kernel build, you only need entries in Kconfig
and Makefile in the 'arm' subdirectory.
If you're building alsa outside the kernel, more may be needed. See below.

> If my
> platform is ARM's Integrator, do I need to set any configs before compiling
> for my new alsa driver? Or where I can find such information? Thank you very
> much~

Sorry, I am not familiar with the ARM Integrator platform. What cpu does
it use?
If is's not supported yet the configure script would need some changes.
No problem if you know you're autoconf stuff. I didn't, so the experts
did this part for me.

I do not recall any documentation on alsa's platform support, but then I
would not expect anything. It's standard autoconf stuff.
There is the excellent "Writing an alsa driver" and more at
http://www.alsa-project.org/documentation.php
See chapter 15 especially.

-- 
Martin


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
