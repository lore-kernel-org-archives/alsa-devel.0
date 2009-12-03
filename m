From: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Subject: io-plugin does not call start callback function
Date: Thu, 03 Dec 2009 12:49:32 +0100
Message-ID: <4B17A5CC.5050906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from netfinity.tbmn.org (mail.tbmn.org [88.117.197.126])
	by alsa0.perex.cz (Postfix) with ESMTP id 4FEF0243FC
	for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2009 12:49:34 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by netfinity.tbmn.org (Postfix) with ESMTP id 096EF4BEE0
	for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2009 12:49:34 +0100 (CET)
Received: from netfinity.tbmn.org ([127.0.0.1])
	by localhost (netfinity.tbmn.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qM119CroWCnp for <alsa-devel@alsa-project.org>;
	Thu,  3 Dec 2009 12:49:33 +0100 (CET)
Received: from [192.168.1.5] (chello080108001212.35.11.tuwien.teleweb.at
	[80.108.1.212])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mne@tbmn.org)
	by netfinity.tbmn.org (Postfix) with ESMTPSA id A2BE94BE05
	for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2009 12:49:33 +0100 (CET)
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

Hi,

I'm writing an io plugin that should transfer all PCM samples to a UNIX socket.

For this reason in my plugin I open the socket and then fill the plugin struct like this:

socketdump->io.mmap_rw = 0;
socketdump->io.poll_fd = socketdump->sock_fd;
socketdump->io.poll_events = POLLOUT;

Thus for my understanding (the alsa doc is really bad), every time
the socket file descriptor is available for writing the alsa plugin would generally speaking issue a data transfer.

However, when playing audio over that plugin for some reason the start callback function is never called.
Instead I get output like this:

socketdump_hw_constraint:417 26944 
_snd_pcm_socketdump_open:585 26944 SND_PCM_PLUGIN_DEFINE_FUNC(): done, err=0

Playing WAVE 'test_8khz_16LE_mono.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
snd_pcm_socketdump_prepare:309 26944 Preparing with io->period_size=164 io->buffer_size=3936
snd_pcm_socketdump_pointer:229 26944 hw_ptr: 0 ()
snd_pcm_socketdump_write:268 26944 snd_pcm_socketdump_write(): areas->step=16 areas->first=0 areas->addr=0x22f1f60 offset=0, size=164 io->nonblock=0
......


Do you have any idea why the start callback function is not called at all ?

cheers,
stefan
