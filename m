From: Vasilis Manwlopoulos <vmanolop@gmail.com>
Subject: Surround problems with cs46xx
Date: Sat, 16 Jun 2007 16:56:53 +0300
Message-ID: <4673EC25.1020507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by alsa0.perex.cz (Postfix) with ESMTP id C40E61038DB
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Jun 2007 15:56:54 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id o2so1077126uge
	for <alsa-devel@alsa-project.org>; Sat, 16 Jun 2007 06:56:54 -0700 (PDT)
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


Sorry for bothering the list again, but I have major problems with the 
surround 5.1 sound. I have manually compiled/installed th latest 
alsa-1.0.14 drivers but nothing improved. I am using Ubuntu 7.04 and my 
soundcard is  the Hercules Fortissimo III. This is, as far as I know by 
reading on Internet, supported by the module snd-cs46xx in ALSA. I have 
enabled the surround sound by creating the following .asoundrc file.

pcm.!default {
    type plug
    slave.pcm "surround51"
    slave.channels 6
    route_policy duplicate
}


The problem is that sound pauses whenever I try to do something "heavy" 
such as opening a new firefox window or generally another app. Also, 
there are delays and echo between the front and the rear speakers from 
time to time. I think that the problem is that, this alsa setup(meaning 
surround5.1 and the specific soundcard) places a heavy load on the cpu. 
There are 99% cpu usage times when the only thing active is a player 
playing a "normal bitrate" mp3. When I delete the .asoundrc file and I 
switch to default stereo sound using only the 2 front speakers the 
problems disappear.

Can anyone suggest anything about this?


Thanks in Advance
V.Manolopoulos
