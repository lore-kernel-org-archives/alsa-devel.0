From: Anksh Agarwal <anksh.agarwal@gmail.com>
Subject: Query about code organization for kernel driver.
Date: Tue, 25 May 2010 01:17:39 +0530
Message-ID: <AANLkTin91dBbESP2i_LyZKoL0KdBWFKzqKPIpuQyIIGY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.221.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 029C910383B
	for <alsa-devel@alsa-project.org>;
	Mon, 24 May 2010 21:47:45 +0200 (CEST)
Received: by qyk9 with SMTP id 9so5936040qyk.2
	for <alsa-devel@alsa-project.org>; Mon, 24 May 2010 12:47:44 -0700 (PDT)
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

Hi Everyone,

I am currently working on a custom ARM based board and have succeeded in
running alsa on my target.
In this reference I have some basic queries and would be great if someone
could give me pointers.This would help me in rorganizing the code as per
acceptance from the group.

since we planning to support a list of devices I wanted to keep the
interface independent of
playback/record session.this helps in switching to different devices in
middle of playback. At any point a single device would be enabled.

So i have another driver snd_device.c  which uses sysfs interface to get
device index or name to enable/disable device. The reason for this was that
we could
reuse a lot of code from the alsa-plugin(maemo). But then will it be right
to put
the device enable/disable code under sound/soc/xxxx/snd_device.c path,
or can we split and place it seperately under sound/driver/xxxx/snd_device.c
or any other suggested directory?

i am not aware how to split the audio path enable/disable code from the soc
driver
and which would be ideal directory to place them, since there is hardly any
interaction
between playback and device enable/disable routines? I think the device
enable/disable code outside sound/ directory wont be a good idea as its
to be specifically used by alsa playback/record only.

please suggest as this would help me a lot. Also let me know if any more
info would help to get to a better conclusion.

Really appreciate all the help.

Thanks,
Anksh
