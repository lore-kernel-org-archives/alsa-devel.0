From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Subject: Re: what does alsaconf do?
Date: Sun, 29 Jan 2006 11:40:23 +0000
Message-ID: <20060129114023.GA16314@palantir8>
References: <1138456724.9726.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mra04.ch.as12513.net (mra04.ch.as12513.net [82.153.252.44])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E0511188
	for <alsa-devel@alsa-project.org>; Sun, 29 Jan 2006 12:40:26 +0100 (MET)
Received: from localhost (localhost [127.0.0.1])
	by mra04.ch.as12513.net (Postfix) with ESMTP id BDB59C0401
	for <alsa-devel@alsa-project.org>; Sun, 29 Jan 2006 11:40:27 +0000 (GMT)
Received: from mra04.ch.as12513.net ([127.0.0.1])
 by localhost (mra04.ch.as12513.net [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 17970-01-58 for <alsa-devel@alsa-project.org>;
 Sun, 29 Jan 2006 11:40:27 +0000 (GMT)
Received: from palantir8.mph.eclipse.net (unknown [81.168.73.77])
	by mra04.ch.as12513.net (Postfix) with ESMTP id 1FD7CC035F
	for <alsa-devel@alsa-project.org>; Sun, 29 Jan 2006 11:40:27 +0000 (GMT)
Received: from mhabets by palantir8.mph.eclipse.net with local (Exim 3.36 #1 (Debian))
	id 1F3Aut-0004H2-00
	for <alsa-devel@alsa-project.org>; Sun, 29 Jan 2006 11:40:23 +0000
Content-Disposition: inline
In-Reply-To: <1138456724.9726.13.camel@localhost.localdomain>
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

On Sat, Jan 28, 2006 at 01:58:44PM +0000, Adrian McMenamin wrote:
> I have been looking through the sources because I cannot get it to run
> properly on my set up and I may need to rewrite it or patch it and
> possibly also modinfo and wonder if someone could give me a short
> summary?

I would say in essence it tries to:
1) Detect your audio hardware (usually by scanning a system bus)
2) Update /etc so the appropriate modules are loaded upon boot.
   This part depends on distro and kernel version.

> My setup is pretty limited - ash (from busybox) not bash, uclibc not
> glibc, no awk, no dialog, buildroot supplied modinfo does not appear to
> give the output alsaconf is looking for etc...

If your hardware does not vary an alternative is to avoid alsaconf and
hardcode the entries in /etc/modules.conf (or whatever you use).
It would be quite substantial to rewrite alsaconf for your setup.
If you really need such a tool maybe it would be better to write a
ucalsaconf. Hard to say really, as I have no clue about the actual
hardware you have.

-- 
Martin
---------------------------------------------------------------------------
30 years from now GNU/Linux will be as redundant a term as MERT/UNIX is 
today. - Martin Habets
---------------------------------------------------------------------------


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
