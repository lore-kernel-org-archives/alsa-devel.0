From: Patrick Lightbody <patrick@lightbody.net>
Subject: Strange Config: Fedora 8 running on Amazon EC2
Date: Wed, 28 Jan 2009 19:20:01 -0800
Message-ID: <c372afa40901281920k4504f7b0j7f06adca8b4b4bcf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.170])
	by alsa0.perex.cz (Postfix) with ESMTP id C1BA2103804
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 04:20:02 +0100 (CET)
Received: by wf-out-1314.google.com with SMTP id 24so7687536wfg.23
	for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2009 19:20:01 -0800 (PST)
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

I have a strange request (which is why I'm sending directly to the dev
list). I'm trying to run Flash video (v9 or v10) on Firefox 3 on a
Fedora 8 image running on Amazon EC2. I don't actually want/need sound
(it's of course technically not possible, since EC2 doesn't provide a
sound card). Video playback (when watched through VNC) goes fine for a
couple minutes, but then the browser and flash lock up entirely. I've
looked for ways to tell Firefox and/or Flash to not send audio out,
but I've come up empty so far. So now I'm hoping that fixing this
error and putting in perhaps some sort of "no op" device might help
out.

I'm not positive the error is related to ALSA, though the fact that
there appear to be a ton of the following logs just before the lockup
is suspicious:

ALSA lib confmisc.c:768:(parse_card) cannot find card '0'
ALSA lib conf.c:3513:(_snd_config_evaluate) function
snd_func_card_driver returned error: No such file or directory
ALSA lib confmisc.c:392:(snd_func_concat) error evaluating strings
ALSA lib conf.c:3513:(_snd_config_evaluate) function snd_func_concat
returned error: No such file or directory
ALSA lib confmisc.c:1251:(snd_func_refer) error evaluating name
ALSA lib conf.c:3513:(_snd_config_evaluate) function snd_func_refer
returned error: No such file or directory
ALSA lib conf.c:3985:(snd_config_expand) Evaluate error: No such file
or directory
ALSA lib pcm.c:2144:(snd_pcm_open_noupdate) Unknown PCM default
ALSA lib pcm_hw.c:1240:(_snd_pcm_hw_open) Invalid value for card

(these lines repeat over and over again until the crash happens, then
it stops promptly)

As you can see by the alsa-info output at the following URL, I don't
have any running snd modules:

http://www.alsa-project.org/db/?f=6b2431d0564b3638cdb798a6d1a21eb73982588c

Similarly, I don't have any sound-related devices installed (ie:
/dev/audio, etc). My hope in emailing this list is that there may be a
solution that causes ALSA to no-op the requests that Firefox/Flash
send it's way, potentially solving the lockup I'm experiencing.

I would really appreciate any ideas that could be shared. Thank you very much!

Patrick
