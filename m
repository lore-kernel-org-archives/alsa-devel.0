From: "Munzir Taha (=?utf-8?q?=D9=85=D9=86=D8=B0=D8=B1?=
	=?utf-8?q?_=D8=B7=D9=87?=)" <munzirtaha@gmail.com>
Subject: Re: Problems with Intel HDA driver
Date: Mon, 28 Sep 2009 00:58:35 +0300
Message-ID: <200909280058.35181.munzirtaha@gmail.com>
References: <200909272327.57943.munzirtaha@gmail.com>
	<200909280031.37483.munzirtaha@gmail.com>
	<604760770909271453v5360d50h8047b3d8acba029@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id B8AAC1037FB
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Sep 2009 23:58:40 +0200 (CEST)
Received: by bwz25 with SMTP id 25so6598185bwz.32
	for <alsa-devel@alsa-project.org>; Sun, 27 Sep 2009 14:58:39 -0700 (PDT)
In-Reply-To: <604760770909271453v5360d50h8047b3d8acba029@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Chen <seven.steps@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Yaum al-Ithnain 08 Shawwal 1430 12:53:18 am Daniel Chen wrote:
> (Sorry for top-posting)
> 
> Is the enable_msi=1 line in your options snd-hda-intel line in
> /etc/modprobe.d/alsa-base.conf?

Yes, the line in the file looks like this:
options snd-hda-intel enable_msi=1 model=hp-dv5
and I can manually mute the speakers by moving its slider all the way down to 
level 0 (but not muting it). However, auto hp jack sensing doesn't work.


-- 
Munzir Taha
