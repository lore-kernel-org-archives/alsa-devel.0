From: Robin Neatherway <neatherway@gmail.com>
Subject: Jack sense fails on Fujitsu p7120
Date: Wed, 19 Jan 2011 10:32:24 +0000
Message-ID: <AANLkTimGPyno7Wd3TfO7dhZe9e4a5QcXLS8Upa1Mq7q_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.216.172])
	by alsa0.perex.cz (Postfix) with ESMTP id D6188243B3
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2011 11:32:46 +0100 (CET)
Received: by qyk34 with SMTP id 34so398982qyk.17
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2011 02:32:45 -0800 (PST)
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

I posted regarding this issue to alsa-users, but haven't had any response.
I've come to the conclusion that I will have to modify the driver myself to
rectify this problem, so I would appreciate some pointers as to how to get
started with that.

Running Xubuntu 10.10 with Alsa 1.0.23

The sound chip is Intel HDA, ALC260. I have tried setting

options snd-hda-intel model=fujitsu

in /etc/modprobe.d/alsa-base.conf, but this hasn't made any difference.
There is no "Jack Sense" option in alsamixer. I've also tried a couple of
values for fix_position.

I've tried following the ubuntu wiki pages for Intel HDA and sound debugging
in general, to no avail. When doing the jack sense test recommended on
https://wiki.ubuntu.com/ALSA/JackSense the two files generated with and
without the headphones plugged in were identical. This makes me think it is
a driver problem. I pasted the output of `cat /proc/asound/card*/codec*` at
http://pastebin.com/4NyvdsXf in case this is of any help.
