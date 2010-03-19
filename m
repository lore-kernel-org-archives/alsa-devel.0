From: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Subject: Are ALSA io plugins implemented as threads or does
 ALSA use fork() ?
Date: Fri, 19 Mar 2010 15:20:27 +0100
Message-ID: <4BA3882B.4030809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from keymachine.tbmn.org (mail.tbmn.org [87.118.84.39])
	by alsa0.perex.cz (Postfix) with ESMTP id D020E1037EE
	for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2010 15:20:29 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by keymachine.tbmn.org (Postfix) with ESMTP id 3427A8AC5C1
	for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2010 15:20:29 +0100 (CET)
Received: from keymachine.tbmn.org ([127.0.0.1])
	by localhost (keymachine.tbmn.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jmCplP9LPfSb for <alsa-devel@alsa-project.org>;
	Fri, 19 Mar 2010 15:20:28 +0100 (CET)
Received: from [192.168.1.5] (chello080108001212.35.11.tuwien.teleweb.at
	[80.108.1.212])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mne@tbmn.org)
	by keymachine.tbmn.org (Postfix) with ESMTPSA id 53DD28AC5C0
	for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2010 15:20:28 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,

from what I have learned so far ALSA io plugins are implemented as
shared libraries with their entry point defined with the
SND_PCM_PLUGIN_DEFINE_FUNC() macro.

However, each plugin instance can only work for either the
SND_PCM_STREAM_PLAYBACK or SND_PCM_STREAM_CAPTURE stream.
Hence this is why io plugins supporting playback and capture usually set
up their callback functions depending on what type of stream is used.

For example in the pulseaudio io plugin, this is done with:

pcm->io.callback = stream == SND_PCM_STREAM_PLAYBACK ?
     &pulse_playback_callback : &pulse_capture_callback;




* If such a plugin is used for capture AND playback at the same time, it
seems that two instances of the plugin need to be running, right ?

* Are these instances running as separate processes (i.e. fork()) or are
they implemented as threads ? How is this implemented internally in the
ALSA code ?



In my plugin I'm planning that both the playback and the capture plugin
instances talk to a common data processing thread over shared buffers.
The reason for this is that the data processing threads needs to have
access to the capture and playback samples *at the same time*.
I'm guessing that the plugin instances run with different PIDs so that I
would need to use common IPC mechanisms in order to let them communicate
with each other, right ?

Hence my first approach would be to set up a common shared memory
together with a semaphore so that only one process can access the shared
memory at a time.
Any better ideas ?

cheers,
Stefan
