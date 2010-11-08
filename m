From: torbenh <torbenh@gmx.de>
Subject: alsa jack plugin
Date: Mon, 8 Nov 2010 10:26:47 +0100
Message-ID: <20101108092647.GS4410@siel.b>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by alsa0.perex.cz (Postfix) with SMTP id 2B3622438C
	for <alsa-devel@alsa-project.org>; Mon,  8 Nov 2010 10:26:49 +0100 (CET)
Received: from torbenh by siel.b with local (Exim 4.72)
	(envelope-from <torbenh@gmx.de>) id 1PFNzz-0004AL-UB
	for alsa-devel@alsa-project.org; Mon, 08 Nov 2010 10:26:47 +0100
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


the alsa jack plugin has quite some problems:
a) does not work correctly with mplayers alsa output. (and quite a few
   others)
b) it includes the pid in its clientname.
c) it requires port connections.
d) jack client is deactivated when alsa stream is not active.
e) no way to set the jack clientname

the master branch on git://hochstrom.endofinternet.org/alsa-plugins
carries fixes for a, b and e.

c and d have their own branches.

i have seen a few problems with making the write end of the fd
non-blocking. would it be possible to use eventfd(2) for this ?


-- 
torben Hohn
