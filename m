From: Thomas Hood <jdthood@yahoo.co.uk>
Subject: Re: alsa-driver build fails with gcc-3.3
Date: Wed, 12 Oct 2005 16:44:46 +0200
Message-ID: <434D215E.9000205@yahoo.co.uk>
References: <434D19E1.4010201@yahoo.co.uk> <s5hy84yhky5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailservice.tudelft.nl (mailservice.tudelft.nl [130.161.131.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 85A6F14D
	for <alsa-devel@alsa-project.org>; Wed, 12 Oct 2005 16:44:47 +0200 (MEST)
In-Reply-To: <s5hy84yhky5.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> It's not due to gcc-3.3 but 2.4 kernel.


Right.


> Try the patch below.


It fixed the build failure at memory.c.  Thanks.
-- 
Thomas


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
