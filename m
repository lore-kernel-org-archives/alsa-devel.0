From: Cameron Barfield <cbarfield.cd@gmail.com>
Subject: Softvol for Independent Volume Control
Date: Mon, 07 Apr 2008 13:16:24 -0700
Message-ID: <47FA8118.7010001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by alsa0.perex.cz (Postfix) with ESMTP id 308B324535
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Apr 2008 22:16:29 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so419124ana.80
	for <alsa-devel@alsa-project.org>; Mon, 07 Apr 2008 13:16:28 -0700 (PDT)
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

Hi --

I've got an application that receives multiple network audio streams. Using DMIX, I am 
able to play back all the streams through my sound card.

The problem is that I would like to be able to independently adjust the volume of each 
audio stream. Would Softvol work for this? All the examples I've found only show Softvol 
working as a replacement for a master volume control (and that's all I've been able to get 
it to do).

If Softvol won't work for independent volume controls, is there any other ALSA plugin or 
API call that I'm missing? Switching to something like Pulseaudio would probably not be an 
option since I'm running in an embedded environment.

Regards,
Cameron
