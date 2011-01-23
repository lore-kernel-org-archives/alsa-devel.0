From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Should "Master" control the "Line In" volume (loopback)
Date: Sun, 23 Jan 2011 17:37:07 +0000
Message-ID: <ihhp04$h9d$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 87DEB244DF
	for <alsa-devel@alsa-project.org>; Sun, 23 Jan 2011 18:37:28 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Ph3sP-000768-QE
	for alsa-devel@alsa-project.org; Sun, 23 Jan 2011 18:37:21 +0100
Received: from cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	([94.173.13.3]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 23 Jan 2011 18:37:21 +0100
Received: from gmane by cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 23 Jan 2011 18:37:21 +0100
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

Hi,

I have a question-by-proxy from a user who is confused because his
"Master" kcontrol is affecting the volume via Line In (which he uses to
loopback an analog signal to his speakers).

I've not got much hardware here for comparison, but I'm pretty sure that
Master usually doesn't affect Line In.

So couple of questions:
 1. Is it typical that Master affects Line In?
 2. If not, can it be fixed for this h/w?

ALSA info here: https://bzattachment.mandriva.com/attachment.cgi?id=18170

(for reference the full bug is here:
https://qa.mandriva.com/show_bug.cgi?id=62218)


Cheers
Col


-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mageia Contributor [http://www.mageia.org/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
