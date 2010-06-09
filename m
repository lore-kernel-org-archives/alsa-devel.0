From: Alex Lee <lee188@singnet.com.sg>
Subject: Open source UAC2 sound card for UAC2 driver testing
Date: Wed, 9 Jun 2010 14:00:24 +0000 (UTC)
Message-ID: <loom.20100609T154158-159@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 347ED103946
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Jun 2010 16:05:05 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OMLtw-0006R9-IX
	for alsa-devel@alsa-project.org; Wed, 09 Jun 2010 16:05:04 +0200
Received: from S01060016762af236.vc.shawcable.net ([24.80.177.198])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 09 Jun 2010 16:05:04 +0200
Received: from lee188 by S01060016762af236.vc.shawcable.net with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 09 Jun 2010 16:05:04 +0200
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

Hi all,

We are developing an open source high speed USB sound card.  Please see:

http://code.google.com/p/sdr-widget/

for details.

With the alpha-1 hardware, we are doing development and testing of the UAC2
firmware against the latest alsa driver here.  We have already demonstrated
96khz 24bit stereo capture with UAC2 and we will proceed to 192khz soon.

Alpha-1 has an ENOB of at least 20 and we hope alpha-2 will have an ENOB of 22
or better.  Alpha-2 kits are available for order now.  (Note that these are
prototype kits for experimenters only.)

With both the UAC2 driver and the sound card firmware being open source, we hope
to expedite full UAC2 spec compliance.  We are already working closely with
Daniel Mack on the testing.

Alex 
