From: Adrian Bunk <bunk@stusta.de>
Subject: [RFC: 2.6 patch] Makefile: sound/ must come before drivers/
Date: Tue, 20 Dec 2005 22:13:59 +0100
Message-ID: <20051220211359.GA5359__36990.6994667419$1135113439$gmane$org@stusta.de>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org> <20051220131810.GB6789@stusta.de> <20051220155216.GA19797@master.mivlgu.local> <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org> <20051220191412.GA4578@stusta.de> <Pine.LNX.4.64.0512201156250.4827@g5.osdl.org> <20051220202325.GA3850@stusta.de> <Pine.LNX.4.64.0512201240480.4827@g5.osdl.org> <43A86DCD.8010400@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 806061B6
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2005 22:13:59 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <43A86DCD.8010400@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Sergey Vlasov <vsu@altlinux.ru>, Ricardo Cerqueira <v4l@cerqueira.org>, mchehab@brturbo.com.br, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 20, 2005 at 08:47:09PM +0000, James Courtier-Dutton wrote:
> Linus Torvalds wrote:
> >
> >On Tue, 20 Dec 2005, Adrian Bunk wrote:
> >
> >>But the non-saa7134 access to my soundcard (e.g. rexima or xmms) is no 
> >>longer working.
> >
> >
> >Ahh. I assume it's the sequencer init etc that is missing.
> >
> >Maybe we'll just have to do the late_init thing for at least the 2.6.15 
> >timeframe.
> >
> >		Linus
> >
> 
> But that's not really a useable fix. The problem is with almost all ALSA 
> sound cards.

No, inside sound/ it's working due to the link order.

Thinking about this, what about the patch below?

I don't know whether this might break anything else, but it fixes my 
problem.

cu
Adrian


<--  snip  -->


drivers might require an already initialized sound subsystem.

Fix the link order for a static sound subsystem.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-rc6/Makefile.old	2005-12-20 21:53:26.000000000 +0100
+++ linux-2.6.15-rc6/Makefile	2005-12-20 21:53:42.000000000 +0100
@@ -470,7 +470,7 @@
 
 # Objects we will link into vmlinux / subdirs we need to visit
 init-y		:= init/
-drivers-y	:= drivers/ sound/
+drivers-y	:= sound/ drivers/
 net-y		:= net/
 libs-y		:= lib/
 core-y		:= usr/



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
