From: "Sebastian H." <vand2@gmx.de>
Subject: Alsamixer-Qt 0.4.1 available
Date: Wed, 11 Aug 2010 17:50:54 +0200
Message-ID: <4C62C6DE.9020403@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by alsa0.perex.cz (Postfix) with SMTP id F3166103868
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Aug 2010 17:49:36 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-user@lists.sourceforge.net
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello again

This is a bugfix release. Not all issues have been addressed, but
hopefully the most annoying ones.

1.)
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3678

The "EQ Peaks" mixer element gets skipped since there's not way to
display it correctly at the moment.
Also the mixer now looks for all element channels from 0 up to
SND_MIXER_SCHN_LAST (= 31). Formerly it was only for the first 9 channels.


2.)
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4204

Raymond brought this up but I'm not entirely sure what's the problem
here. Are there actually 5 controls named "Master" on this card?
If so alsamixer-qt4 now appends the element index to the element name
for elements whose name appears more that once. This should happen for
all elements but I could only test it for "Capture" and "Input Source".
Both appear twice on my HDA-Intel onboard card.

Download at:
http://xwmw.org/alsamixer-qt4/
http://sourceforge.net/projects/alsamixer-qt4/files/

Comments are welcome!

Best,
Sebastian H.
