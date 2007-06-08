From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Testing/forcing XRUN
Date: Fri, 08 Jun 2007 17:59:05 +1200
Message-ID: <200706081759.06021.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (unknown [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 98DBA2442E
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Jun 2007 07:59:13 +0200 (CEST)
Received: from zaphod.local
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JJA00LJ5ZA7EP00@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Fri, 08 Jun 2007 17:58:56 +1200 (NZST)
Content-disposition: inline
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

I want to test my driver behaviour when an xrun happens.

I have tried using aplay/arecord, and suspending (ctrl-Z) them while 
playing/recording but this doesn't have the desired effect. (I don't see my 
driver code detecting an xrun).  Instead I see a trigger-stop command to the 
driver.

The apps do report an overrun when they are restarted though.

Can anyone answer these:

1) Is this a valid way to simulate an xrun due to application not keeping up?

1.1) If not, what is? Do I have to write an app that deliberately starves the 
streams?

2) Where is the xrun being detected if my driver doesnt see it?  Where does 
the trigger-stop command come from when I suspend the app?

thanks

Eliot Blennerhassett
AudioScience Inc.
