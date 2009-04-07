From: Ernesto Torres <skullmate@gmail.com>
Subject: Help for writting an ASoC driver
Date: Tue, 7 Apr 2009 12:18:25 -0500
Message-ID: <fb44c3530904071018o542cb622k6ab9b939b3144c78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.157])
	by alsa0.perex.cz (Postfix) with ESMTP id A002024603
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Apr 2009 19:18:27 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 4so2069660yxp.2
	for <alsa-devel@alsa-project.org>; Tue, 07 Apr 2009 10:18:26 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi, i'm new to alsa and i would like some advice on where to get information
about writing an ASoC driver it would be for the beagle board, since is the
board i have available. I have already made some progress initializing and
loading info to the codec via I2C, but I think there are still many things I
don't know.
I still don't know the exact way for playing via pcm with aplay or the order
of the callbacks. I have checked the web for info but not much about ASoC,
just the documentation with the linux kernel.

My driver actually tries to play with aplay, but gets stuck in : omap-pcm.c:
omap_pcm_pointer
It just won't send the frames.

Thank you for your help.

- Ernesto
