From: Eliot Blennerhassett <linux@audioscience.com>
Subject: asihpi: Control naming
Date: Thu, 30 Sep 2010 16:44:14 +1300
Message-ID: <4CA4078E.6010601@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 179E1103821
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Sep 2010 05:44:50 +0200 (CEST)
Received: from [192.168.36.2]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0L9J000HRJPQ7700@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 30 Sep 2010 16:44:15 +1300 (NZDT)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi all,

I'm struggling with getting the correct names for controls, so that they
show up correctly in the Playback or Capture modes of alsamixer

E.g. "PCM 3 Capture Meter" appears in the playback controls?

How is capture vs playback display determined?
or to put it another way: What are the rules for creating control names.

Here is a reduced schematic of one of our cards (in reality more
channels e.g. 4 physical stereo ins and outs, 12 players, 8 recorders)
All players and inputs are mixed to outputs.
All inputs and players multiplexed to each capture.

How should all these controls be named?


                               (1)-[vol]--+
                               (2)-[vol]--+
[play0]--[vol]--[meter]--[mode]--,-[vol]--+----[vol]-[meter]--[level]--[lineout0]
                                 `-[vol]--|-.
                                          | |
                                 .-[vol]--' |
[play1]--[vol]--[meter]--[mode]--'-[vol]----+--[vol]-[meter]--[level]--[lineout1]
                               (1)-[vol]----+
                               (2)-[vol]----+

[linein0]-[level]-\                     \
                mux>-[meter]-(1)-,-------|\
[digitalin0]------/              |    mux >--[mode]--[meter]--[cap0]
                                 |    ,../
                                 |   |
                                  `--|--\
[linein1]-[level]-\                  |   >--[mode]--[meter]--[cap1]
                mux>-[meter]-(2)-----'--/
[digitalin1]------/

notes
[level] means calibrated reference level setting in dBu
[mode] stereo channel modifier
+ summing junction
--|-- wires cross, no join
(1) connect from input to matrix mix output

thanks and regards

-- 
Eliot Blennerhassett
AudioScience Inc.
