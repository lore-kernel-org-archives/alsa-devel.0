From: David Henningsson <david.henningsson@canonical.com>
Subject: M-audio fasttrack pro, input device index
Date: Tue, 27 Mar 2012 08:40:36 +0200
Message-ID: <4F7160E4.8030506@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 3EBE7104139
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Mar 2012 08:39:04 +0200 (CEST)
Received: from hd9483857.selulk5.dyn.perspektivbredband.net ([217.72.56.87]
	helo=[192.168.8.102]) by youngberry.canonical.com with esmtpsa
	(TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.71)
	(envelope-from <david.henningsson@canonical.com>) id 1SCQ57-0004DY-5W
	for alsa-devel@alsa-project.org; Tue, 27 Mar 2012 06:40:37 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

M-Audio fasttrack pro has two stereo outputs and one stereo input. It 
looks like the input sometimes shows up at device 0 and sometimes at 
device 1. I e, a device string would sometimes be hw:1,0,0 and sometimes 
hw:1,1,0. (Assuming the card index is 1)

Do we know if there is a reason behind this behaviour, or should we just 
try both device strings?

I don't have this device myself, so I don't know if it's consistent 
given a specific physical device, if it differs between kernel versions, 
or anything else. I've just seen both.

Example alsa-info: 
https://launchpadlibrarian.net/45386782/alsa-info.txt.5TIcWGnRjL

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
