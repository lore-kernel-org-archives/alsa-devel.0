From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Fwd: Writing a new plugin for ALSA
Date: Tue, 10 Jul 2007 16:29:44 +0530
Message-ID: <8d6898730707100359g5c76b670y59120a776ed33e51@mail.gmail.com>
References: <8d6898730707090459o10ea89a0qc9fc888af153b85b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 090811038CD
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jul 2007 12:59:45 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so1669653wag
	for <alsa-devel@alsa-project.org>; Tue, 10 Jul 2007 03:59:45 -0700 (PDT)
In-Reply-To: <8d6898730707090459o10ea89a0qc9fc888af153b85b@mail.gmail.com>
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
To: Sudhanshu Saxena <sudhanshu.saxena@gmail.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Read through this, and you can ask more to this guy. This guy
implemented alsa-lib and lot of other things in  alsa.

Please copy alsa-devel@alsa-project.org when you mail him, so that
others in mailing list will also benefit.

---------- Forwarded message ----------
From: Nobin Mathew <nobin.mathew@gmail.com>
Date: Jul 9, 2007 5:29 PM
Subject: Writing a new plugin for ALSA
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>


Hi,

I am trying to write a new ALSA plugin, like dmix.

My intend is to give priority to streams, i will not do up sample and
down sample as we do in the case of dmix.

If we do up sample and down sample then I think it will take lot of cpu.

In my case I have three streams audio, bluetooth sco and Navigation sound data.

priority is audio < sco < Nav

audio rate is 44100hz, sco rate is 8000hz

when sco is up audio should pause playback and audio should continue
when sco is finished. I dont want to do software mixing. Thats why I
am trying to write this new plugin.


Assume that audio is active first, then sco comes to active state. So
what i will do is in the library i will put audio app in sleep(), and
re-configure the pcm for sco. Once sco is finished i will re-configure
pcm for audio again like wise.

so my question is there any api in the alsa-lib to take a copy of pcm
structures, so when audio comes back gain i can use these saved pcm
conf to that.

Is there any api in the alsa-lib to reset the pcm structure to
initialized state, means state just after open.

Thanks
Nobin Mathew
