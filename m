From: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Subject: custom ioplug plugin does not work
Date: Mon, 17 Aug 2009 11:56:19 +0200
Message-ID: <4A892943.7060800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from netfinity.tbmn.org (mail.tbmn.org [88.117.197.126])
	by alsa0.perex.cz (Postfix) with ESMTP id 30F8A103811
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Aug 2009 11:56:35 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by netfinity.tbmn.org (Postfix) with ESMTP id 9F7524BE06
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Aug 2009 11:56:43 +0200 (CEST)
Received: from netfinity.tbmn.org ([127.0.0.1])
	by localhost (netfinity.tbmn.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mifGMjkFB1Rr for <alsa-devel@alsa-project.org>;
	Mon, 17 Aug 2009 11:56:42 +0200 (CEST)
Received: from [192.168.1.5] (chello080108001212.35.11.tuwien.teleweb.at
	[80.108.1.212])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mne@tbmn.org)
	by netfinity.tbmn.org (Postfix) with ESMTPSA id 1E4544BE05
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Aug 2009 11:56:40 +0200 (CEST)
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

Hi,

I'm trying to write an ioplug plugin which dumps the raw PCM stream to a device file in real time.
With real time I mean that a device available through a device file should receive the PCM samples exactly at the sampling rate.
Thus for example with a sampling rate of 8kHz and 16bit linear samples, each 1/8000 = 125us the device should receive exactly
one 16bit sample (if we assume that only one audio channel is used).
This should all happen on an ARM9 target with the device being a fast SPI device that can handle the transfer speeds.

In contrast to the existing file or tee plugins, this should also work if no slave device is specified.
With the mentioned two existing plugins all PCM data is immediately written to the output file if the null device is specified.
For this reason these plugins do not seem to be usable for my application.

To solve the mentioned problem it was suggested to me that I should write an ALSA plugin which does the job.

At the moment I already have some partially working code which is available at
http://pastebin.com/m3666868b

My problem with the code is that when playing audio over the plugin, it transfer some data chunks in the beginning and then it
seems to be blocking forever.


What I'm doing in my plugin code is basically the following:

1. 	open output file for writing (file descriptor is filedump->file_fd)

2. 	filedump->io.poll_fd = filedump->file_fd;
	filedump->io.poll_events = POLLOUT;
	filedump->io.mmap_rw = 0;

3.	snd_pcm_ioplug_create()


I have callbacks for start, stop, close, pointer, prepare and transfer:

In the start and stop callbacks I don't do anything at the moment.
In the close callback I close the output file.
In the pointer callback I just return the current hw_ptr.
In the prepare callback the hw_ptr is initialized with 0.

However, the most imporant callback seems to be the transfer callback.
At the moment it just prints a hexdump of the PCM buffer and returns the
size of the buffer to indicate that the whole buffer has been transfered.



* Is this correct so far ?
* Why is the plugin blocking forever after some parts of the buffer have been transfered and the start callback is called ?



The output of the plugin looks like this:
------------------------------------------------------------------------------------------
_snd_pcm_filedump_open:311 25740 SND_PCM_PLUGIN_DEFINE_FUNC(): done, err=0

Playing WAVE '/usr/share/sounds/card_shuffle.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
snd_pcm_filedump_prepare:134 25740 Preparing with io->period_size=5512 io->buffer_size=22050
snd_pcm_filedump_transfer:99 25740 snd_pcm_filedump_transfer(): areas->step=32 areas->first=0 offset=0, size=5512 io->nonblock=0
<hexdump ...>
snd_pcm_filedump_transfer:99 25740 snd_pcm_filedump_transfer(): areas->step=32 areas->first=0 offset=0, size=5512 io->nonblock=0
<hexdump ...>
snd_pcm_filedump_transfer:99 25740 snd_pcm_filedump_transfer(): areas->step=32 areas->first=0 offset=0, size=5512 io->nonblock=0
<hexdump ...>
snd_pcm_filedump_transfer:99 25740 snd_pcm_filedump_transfer(): areas->step=32 areas->first=0 offset=0, size=5512 io->nonblock=0
<hexdump ...>
snd_pcm_filedump_transfer:99 25740 snd_pcm_filedump_transfer(): areas->step=32 areas->first=0 offset=0, size=2 io->nonblock=0
<hexdump ...>
snd_pcm_filedump_start:70 25740 snd_pcm_filedump_start()

^CAborted by signal Interrupt...
snd_pcm_filedump_stop:76 25740 snd_pcm_filedump_stop()

snd_pcm_filedump_close:59 25740 snd_pcm_filedump_close()
------------------------------------------------------------------------------------------

As you can see, after calling snd_pcm_filedump_start() the plugin seems to be blocking forever.



* Why is data transfered at all before start is called ?



Unfortunately the ALSA documentation seems to be really bad.
Reading (and partially copying) code from other plugins brought me this far, but not further at the moment.

I would appreciate any help to get rid of the problem mentioned above.

cheers,
stefan
