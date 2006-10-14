From: Adrian Bunk <bunk@stusta.de>
Subject: [2/3] 2.6.19-rc2: knwon regressions with workarounds
Date: Sat, 14 Oct 2006 13:25:34 +0200
Message-ID: <20061014112534.GK30596@stusta.de>
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org>
	<20061014111458.GI30596@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 2690B1A0
	for <alsa-devel@alsa-project.org>;
	Sat, 14 Oct 2006 13:25:36 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <20061014111458.GI30596@stusta.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew de Quincey <adq_dvb@lidskialf.net>, Michael Krufky <mkrufky@linuxtv.org>, Prakash Punnoor <prakash@punnoor.de>, v4l-dvb-maintainer@linuxtv.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

This email lists some known regressions with workarounds in 2.6.19-rc2 
compared to 2.6.18.

Unless proper solutions become available, we should implement the 
workarounds.

If you find your name in the Cc header, you are either submitter of one 
of the bugs, maintainer of an affectected subsystem or driver, a patch 
of you caused a breakage or I'm considering you in any other way 
possibly involved with one or more of these issues.

Please trim the Cc when answering.

Subject    : snd-hda-intel <-> forcedeth MSI problem
References : http://lkml.org/lkml/2006/10/5/40
             http://lkml.org/lkml/2006/10/7/164
Submitter  : Prakash Punnoor <prakash@punnoor.de>
Status     : suggested workaround for 2.6.19:
             deactivate MSI in snd-intel-hda by default


Subject    : DVB frontend selection causes compile errors
References : http://lkml.org/lkml/2006/10/8/244
Submitter  : Adrian Bunk <bunk@stusta.de>
Caused-By  : "Andrew de Quincey" <adq_dvb@lidskialf.net>
             commit 176ac9da4f09820a43fd48f0e74b1486fc3603ba
Handled-By : Michael Krufky <mkrufky@linuxtv.org>
             "Andrew de Quincey" <adq_dvb@lidskialf.net>
Status     : possible workaround: don't allow CONFIG_DVB_FE_CUSTOMISE=y


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
