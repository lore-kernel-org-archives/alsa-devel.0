From: ajay khandelwal <ajay.lforum@gmail.com>
Subject: SPDIF: How to play mono sound
Date: Tue, 8 Nov 2011 15:34:28 +0530
Message-ID: <CAL7V=_ETiUeQ1f30SFh-DLYjbvvjcdNoAN0Q1dtCSoOTNsUirw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id AA3E224360
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2011 11:04:29 +0100 (CET)
Received: by vwl15 with SMTP id 15so216208vwl.38
	for <alsa-devel@alsa-project.org>; Tue, 08 Nov 2011 02:04:28 -0800 (PST)
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
 I have a pc with SPDIF out. I want to play audio file with single
channel(mono) using aplay.

How to do that, when I try to play with following command, it gives error

aplay -Diec958:CARDICH6,DEV=0 mono_music.wav

it gives following error
aplay: set_param:1065: Channels count not available.

Thanks and Regards,
Ajay
