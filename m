From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: current CVS: compile error
Date: 06 Jan 2005 18:16:11 -0800
Message-ID: <1105064170.26216.102.camel@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp3.Stanford.EDU (smtp3.Stanford.EDU [171.67.16.138])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5586527B
	for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2005 03:16:16 +0100 (MET)
Received: from cm-mail.stanford.edu (cm-mail.Stanford.EDU [171.64.197.135])
	by smtp3.Stanford.EDU (8.12.11/8.12.11) with ESMTP id j072GBoO025344
	for <alsa-devel@alsa-project.org>; Thu, 6 Jan 2005 18:16:13 -0800
Received: from cmn37.stanford.edu (cmn37.stanford.edu [171.64.197.186])
	by cm-mail.stanford.edu (8.11.6/8.11.6) with ESMTP id j072GBH27532
	for <alsa-devel@alsa-project.org>; Thu, 6 Jan 2005 18:16:11 -0800
Received: from localhost (localhost [127.0.0.1])
	by cmn37.stanford.edu (8.12.8/8.12.5) with ESMTP id j072GBDJ026945
	for <alsa-devel@alsa-project.org>; Thu, 6 Jan 2005 18:16:11 -0800
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

I'm getting this error while building current CVS (one FC3):

  CC [M] 
/usr/src/rpm/BUILD/alsa-driver-1.0.8rc2/pci/echoaudio/darla20.o
  CC [M] 
/usr/src/rpm/BUILD/alsa-driver-1.0.8rc2/pci/cs46xx/dsp_spos_scb_lib.o
In file included from
/usr/src/rpm/BUILD/alsa-driver-1.0.8rc2/pci/echoaudio/darla20.c:109:
/usr/src/rpm/BUILD/alsa-driver-1.0.8rc2/pci/echoaudio/echoaudio_dsp.c:
In function `load_firmware':
/usr/src/rpm/BUILD/alsa-driver-1.0.8rc2/pci/echoaudio/echoaudio.h:424:
sorry, unimplemented: inlining failed in call to 'free_firmware':
function body not available
/usr/src/rpm/BUILD/alsa-driver-1.0.8rc2/pci/echoaudio/echoaudio_dsp.c:544: sorry, unimplemented: called from here
make[5]: ***
[/usr/src/rpm/BUILD/alsa-driver-1.0.8rc2/pci/echoaudio/darla20.o] Error
1
make[4]: *** [/usr/src/rpm/BUILD/alsa-driver-1.0.8rc2/pci/echoaudio]
Error 2
make[4]: *** Waiting for unfinished jobs....


-- Fernando




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
