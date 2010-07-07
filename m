From: Adish Kuvelker <adkuvi@gmail.com>
Subject: Problems running "amixer"
Date: Wed, 7 Jul 2010 17:59:32 +0530
Message-ID: <AANLkTinSa0nOGY0OQDdjRaPZFES9QM-5zr_F3ZwIxCEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id F420224485
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Jul 2010 14:29:34 +0200 (CEST)
Received: by vws9 with SMTP id 9so5354194vws.38
	for <alsa-devel@alsa-project.org>; Wed, 07 Jul 2010 05:29:33 -0700 (PDT)
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

Hello,

I have cross-compiled alsa-utils (alsa-utils-1.0.13) and alsa-lib
(alsa-lib-1.0.13). But when I ran the "amixer" I found some errors. I
am pasting the same for your reference.
# ./amixer
ALSA lib control.c:910:(snd_ctl_open_noupdate) Invalid CTL default
amixer: Mixer attach default error: No such file or directory

The snddevices script creates a node "/dev/snd" and the device number
of these nodes matches with the ones registered in "/proc/asound".

Can anyone point me to the reason why the above mentioned error
occurs? If any more information is required over the way my sound
nodes are registered with the system I shall post it.

Regards;
Aadish
