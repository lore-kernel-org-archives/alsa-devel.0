From: "Munzir Taha (=?utf-8?q?=D9=85=D9=86=D8=B0=D8=B1?=
	=?utf-8?q?_=D8=B7=D9=87?=)" <munzirtaha@gmail.com>
Subject: Alsa on HP Pavilion dv6-1225ee audio problems
Date: Wed, 2 Sep 2009 15:03:17 +0300
Message-ID: <200909021503.17373.munzirtaha@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f207.google.com (mail-fx0-f207.google.com
	[209.85.220.207])
	by alsa0.perex.cz (Postfix) with ESMTP id 15194103800
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Sep 2009 14:03:21 +0200 (CEST)
Received: by fxm3 with SMTP id 3so737336fxm.32
	for <alsa-devel@alsa-project.org>; Wed, 02 Sep 2009 05:03:20 -0700 (PDT)
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

Hi sirs,
I bought this
http://h10010.www1.hp.com/wwpc/me/en/ho/WF06b/321957-321957-3329744-64354-64354-3872814-3982366.html
and found the audio is not working and thankfully gnubien on #alsa pointed me 
to manually add
snd-hda-intel: model=hp-hdx
which really made the sound come out of the speakers though the laptop is not 
hdx series. Now when I plug the headset the Speakers are still playing (no 
auto sensoring?) and I had to mute them manually which could be a feature or a 
bug depending on how you look at it.

alsa-info.sh:
http://www.alsa-project.org/db/?f=dcbcc7d98ffceb95cd7491aed02064fba337bfa7

I hope this would help you properly support this nice laptop out of the box.

-- 
Munzir Taha
Telecommunications and Electronics Engineer
Master CIW Designer, ICDL, MOUS, Linux+, LPI, SCSA
Riyadh, SA
