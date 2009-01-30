From: Jens Jorgensen <jbj1@ultraemail.net>
Subject: No digital output on HP Pavilion dv6936us (intel_hda
 ALC268), also volume low--help me hack?
Date: Fri, 30 Jan 2009 11:32:26 +0800
Message-ID: <498274CA.8010304@ultraemail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from QMTA10.emeryville.ca.mail.comcast.net
	(qmta10.emeryville.ca.mail.comcast.net [76.96.30.17])
	by alsa0.perex.cz (Postfix) with ESMTP id 38BC42434D
	for <alsa-devel@alsa-project.org>; Fri, 30 Jan 2009 04:33:36 +0100 (CET)
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

Hello,

I've got sound working on my laptop but there are two problems I'd like
to solve. One is the volume is kind of low. Not so low I'm positive
something is wrong, but it seems like it isn't right. Second, and more
interesting, is this laptop seems to digital audio output that goes over
the HDMI connector. Or, I should say, in Windows XP (installing that was
another adventure I would have preferred not to have done) The mixer has
a control to enable S/PDIF output. I'm a (non-kernel) c++ developer by
trade and I've got a local kernel tree from git and should be able to
manage pulling the alsa git as well, so if some alsa person could guide
me along in hacking the driver to help me try to get this working that
would be great. I ran alsa-info.sh on my box, here's the URL:

http://www.alsa-project.org/db/?f=1b5a45d1336cee176dbd99e725a56f7ad4e20b42

-- 
Jens B. Jorgensen
jbj1@ultraemail.net
