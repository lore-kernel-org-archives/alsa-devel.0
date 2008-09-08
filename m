From: umeshyv <umeshyv@gmail.com>
Subject: Asoc and alsa utils regarded
Date: Mon, 8 Sep 2008 10:20:03 +0530
Message-ID: <b5c34db00809072150w4928030t34a660bfd158d4eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 802FC243ED
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Sep 2008 06:50:04 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 36so746999yxh.2
	for <alsa-devel@alsa-project.org>; Sun, 07 Sep 2008 21:50:03 -0700 (PDT)
Content-Disposition: inline
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

Hi to all,
Currently working on Asoc for Au1200.I need to know whether the framework is
completed since I see some of the files missing in the all versions of the
kernel and moreover I am trying to compile alsa libs and utils ,it compiled
successfully but when I run at the target

sh-3.2# aplay -c1 -r8000 -fs8 Infected.wav
ALSA lib conf.c:3009:(snd_config_update_r) Cannot
access file /home/alsa/install/share/alsa/alsa.conf
ALSA lib pcm.c:2184:(snd_pcm_open_noupdate) Unknown

PCM default
aplay: main:583: audio open error: No such file or
directory

Do I need to export any PATH at the target.Can anyone guide me.

Thanks & Regards
Umesh
