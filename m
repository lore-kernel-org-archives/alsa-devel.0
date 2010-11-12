From: Rajul Kumar <rajul.manit1@gmail.com>
Subject: ALSA error : frame 0 active: -75
Date: Fri, 12 Nov 2010 14:05:46 +0530
Message-ID: <AANLkTin2wz0U-nociG9qMFP5R8ZhgVdDQASdXsezgzEh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.216.172])
	by alsa0.perex.cz (Postfix) with ESMTP id D916F103820
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 09:35:48 +0100 (CET)
Received: by qyk5 with SMTP id 5so5876qyk.17
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 00:35:47 -0800 (PST)
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
Cc: tiwai@suse.de, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Hi ,

we are doing audio streaming using linux usb audio class interface .

sometimes when we start usb audio streaming ,

we get first this  error :

ALSA sound/usb/usbaudio.c:354: frame 0 active: -75

which is followed by coninous loop of below messages :

ALSA sound/usb/usbaudio.c:354: frame 0 active: -71
ALSA sound/usb/usbaudio.c:354: frame 0 active: -71
ALSA sound/usb/usbaudio.c:354: frame 0 active: -71
ALSA sound/usb/usbaudio.c:354: frame 0 active: -18
ALSA sound/usb/usbaudio.c:354: frame 0 active: -18
ALSA sound/usb/usbaudio.c:354: frame 0 active: -18
......
and so on

can i be suggested regarding the significance  of error :  -75 , and
the way to resolve this error .


Thanx & Regards
Rajul
