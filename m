From: Martin Michlmayr <tbm@cyrius.com>
Subject: Re: RFC: OSS driver removal, a slightly different approach
Date: Wed, 25 Jan 2006 02:47:55 +0000
Message-ID: <20060125024755.GA2002@deprecation.cyrius.com>
References: <20060119174600.GT19398@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sorrow.cyrius.com (sorrow.cyrius.com [65.19.161.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C729E177
	for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2006 03:48:09 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <20060119174600.GT19398@stusta.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

* Adrian Bunk <bunk@stusta.de> [2006-01-19 18:46]:
> SOUND_TRIDENT
> - ALSA #1293 (device supported by OSS but not by ALSA)
> - maintainer of the OSS driver wants his driver to stay

That driver generally doesn't seem very well maintained in ALSA.
I reported a bug report ages ago about a long delay when loading the
snd_ali5451 ALSA module which doesn't occur with trident but nothing
happened.  https://bugtrack.alsa-project.org/alsa-bug/view.php?id=873
-- 
Martin Michlmayr
http://www.cyrius.com/


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
