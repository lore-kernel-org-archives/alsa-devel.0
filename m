From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Problem with PPH plugin
Date: Tue, 19 Jan 2010 17:49:16 +0000
Message-ID: <hj4rap$ofp$2@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 46D33103891
	for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2010 18:49:29 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.50) id 1NXICl-0001iG-77
	for alsa-devel@alsa-project.org; Tue, 19 Jan 2010 18:49:27 +0100
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2010 18:49:27 +0100
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2010 18:49:27 +0100
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

Just wanted to highlight a bug over on Mozilla relating to a crash in
the PPH plugin.

https://bugzilla.mozilla.org/show_bug.cgi?id=540460

It was initially though to be in PulseAudio, but on closer inspection
this doesn't involve PA at all and in fact seems to relate to the PPH
plugin from what I can gather.

The backtrace is here:
https://bug540460.bugzilla.mozilla.org/attachment.cgi?id=422264

The user did submit a bug report to the bugtracker
(https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4878) but given
previous experience there (see other mail!) I figured I'd post a message
here to highlight it seeing as the reporter has already done a lot to
try and work out what is going on and posting a message on his behalf
seemed like a good idea :)

Cheers

All the best.

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mandriva Linux Contributor [http://www.mandriva.com/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
