From: Hynek Hanke <hanke@brailcom.org>
Subject: The different STATES of ALSA
Date: Sun, 31 Jul 2005 15:35:52 +0200
Message-ID: <20050731133552.GA13386@brailcom.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp-out3.iol.cz (smtp-out3.iol.cz [194.228.2.91])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6E7D31A1
	for <alsa-devel@alsa-project.org>; Sun, 31 Jul 2005 15:39:03 +0200 (MEST)
Received: from antivir3.iol.cz (unknown [192.168.30.206])
	by smtp-out3.iol.cz (Internet on Line ESMTP server) with ESMTP id 6DE2C3183B3
	for <alsa-devel@alsa-project.org>; Sun, 31 Jul 2005 15:39:04 +0200 (CEST)
Received: from localhost (antivir3.iol.cz [127.0.0.1])
	by antivir3.iol.cz (Postfix) with ESMTP id 66B736DC003
	for <alsa-devel@alsa-project.org>; Sun, 31 Jul 2005 15:39:04 +0200 (CEST)
Received: from smtp-out3.iol.cz (unknown [192.168.30.28])
	by antivir3.iol.cz (Postfix) with ESMTP id 57D086DC002
	for <alsa-devel@alsa-project.org>; Sun, 31 Jul 2005 15:39:04 +0200 (CEST)
Received: from chopin (unknown [80.188.214.108])
	by smtp-out3.iol.cz (Internet on Line ESMTP server) with ESMTP id 06CF53BF53
	for <alsa-devel@alsa-project.org>; Sun, 31 Jul 2005 15:39:01 +0200 (CEST)
Received: from hanke by chopin with local (Exim 3.36 #1 (Debian))
	id 1DzDyr-0007Cn-00
	for <alsa-devel@alsa-project.org>; Sun, 31 Jul 2005 15:35:53 +0200
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi everyone,

I'm having very much troubles programming an ALSA interface because the
documentation is pretty poor. I'm very much confused about the different states
in alsa-lib.

(After I was told alsa-lib is not thread-safe and there is some bug in the kernel
implementation of the underlaying calls of snd_pcm_writei(), I'm now running the
non-blocking/polling approach).

My questions:

1) In which states am I allowed to call
	a) snd_pcm_hw_params_any
	b) snd_pcm_hw_params
	c) snd_pcm_prepare
	d) snd_pcm_drop and _drain

2) Which states do they bring me to, if they don't return an error?

3) How is it possible that snd_pcm_drain returns with a success value *and*
   the snd_pcm_state() still reports SND_PCM_STATE_DRAINING ? Is this a bug?

4) How is it possible, that the whole time a sound is played snd_pcm_writei()
   never returns the value -EPIPE and still, when checking the state before
   playing the next sound, I find the device in the SND_PCM_STATE_XRUN
   (snd_pcm_drain() gets called in the meantime).

The problems (3) and (4) seem to arrise only under some circumstances, possibly
when more sounds are played in a quick succession.

Thank you for help,
Hynek Hanke



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
