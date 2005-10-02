From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: surround51 problems.
Date: Sun, 02 Oct 2005 20:05:38 +0100
Message-ID: <43402F82.6030603@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-35.mail.demon.net (anchor-post-35.mail.demon.net [194.217.242.85])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 588D31B9
	for <alsa-devel@alsa-project.org>; Sun,  2 Oct 2005 20:05:36 +0200 (MEST)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.1.10])
	by anchor-post-35.mail.demon.net with esmtp (Exim 4.42)
	id 1EM87p-00047g-H2
	for alsa-devel@alsa-project.org; Sun, 02 Oct 2005 17:59:49 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

Has something changed in alsa-lib recently.
I am using the latest alsa-cvs, and I cannot get surround51 to work.
All these work:
speaker-test -c2 -Dfront
speaker-test -c2 -Dcenter_lfe
speaker-test -c2 -Drear
But the following fails and only outputs a distorted sound to the front
right speaker irrespective of the speaker it should come out of.
speaker-test -c6 -Dsurround51

James




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
