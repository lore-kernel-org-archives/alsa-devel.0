From: Pradeep Kumar Jilagam <pradeep.jilagam@gmail.com>
Subject: Help! Need to switch between normal speaker and BT
	headset dynamically
Date: Sun, 4 Apr 2010 21:20:23 +0530
Message-ID: <x2vc731536d1004040850gedb4eee1rccf18941cf25aade@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 5FA0B10383C
	for <alsa-devel@alsa-project.org>;
	Sun,  4 Apr 2010 17:50:24 +0200 (CEST)
Received: by pwj7 with SMTP id 7so2273583pwj.38
	for <alsa-devel@alsa-project.org>; Sun, 04 Apr 2010 08:50:23 -0700 (PDT)
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

I am trying to switch the ALSA audio output between default speaker and
BT(BlueTooth) headset.

For this, I have used the bluez stack for the BT headset scanning and
detection. After this, I have updated the .asoundrc file with the
corresponding details(like MAC address of the detected BT headset and the
device type as "pcm.bluetooth"). And finally, I used the aplay utility to
play the file.

This approach works fine but this needs restart of the playback session to
start routing on the BT headset. I am trying for a
solution(application/plugin) that can dynamically set the BT headset as the
default audio output device and start streaming to it automatically as soon
as the BT headset is detected in the middle of audio playback.

Is this possible to do and if yes, is there an ALSA application/plugin
already available for this?

Thanks,
Pradeep
