From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Writing a new plugin for ALSA
Date: Mon, 9 Jul 2007 17:29:17 +0530
Message-ID: <8d6898730707090459o10ea89a0qc9fc888af153b85b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.238])
	by alsa0.perex.cz (Postfix) with ESMTP id BFD60103898
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Jul 2007 13:59:19 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id m22so597210nzf
	for <alsa-devel@alsa-project.org>; Mon, 09 Jul 2007 04:59:18 -0700 (PDT)
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
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

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
