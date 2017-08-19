From: Dimitrios Semitsoglou-Tsiapos <kmhzsem@gmx.com>
Subject: [alsa-utils] alsaloop falls into loop after SIGCONT
Date: Sat, 19 Aug 2017 19:26:58 +0300
Message-ID: <29f775f0-bdfd-e221-1096-a0d300b18e85@gmx.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------D6904CC8EC8B12271F3D1104"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by alsa0.perex.cz (Postfix) with ESMTP id BC13F266E0E
 for <alsa-devel@alsa-project.org>; Sat, 19 Aug 2017 18:27:16 +0200 (CEST)
Received: from [192.168.2.201] ([62.169.225.210]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MCcja-1dsPyr2kxm-009T9d for
 <alsa-devel@alsa-project.org>; Sat, 19 Aug 2017 18:27:15 +0200
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------D6904CC8EC8B12271F3D1104
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello everyone,

I've ran into some issues while writing a wrapper around alsaloop. It's possible to make it fall into infinite loops of silence. Here is how to trigger one such loop:

	alsaloop -C cloop -P Audio -t 100000 -v... & # Read attached asoundrc
	sleep 2
	mpc play
	pkill -STOP -x alsaloop; sleep 0.1; pkill -CONT -x alsaloop

On the great majority of times, this happens:

...
pool took 68171us
playback hw:Audio/capture cloop: pollfds handle
playback hw:Audio: delay 2160 / 38400 / 0
capture cloop: delay 15120 / 38400 / 0
playback hw:Audio/capture cloop: prevents = 0x4, crevents = 0x0
playback hw:Audio/capture cloop: queued 5040/18000 samples
playback hw:Audio: end delay 5040 / 38400 / 0
capture cloop: end delay 18000 / 38400 / 0
playback hw:Audio/capture cloop: processing time 69us
pool took 192670us
playback hw:Audio/capture cloop: pollfds handle
playback hw:Audio: delay error: Broken pipe / 38400 / 0
capture cloop: delay 8400 / 38400 / 0
playback hw:Audio/capture cloop: prevents = 0xc, crevents = 0x1
underrun for playback hw:Audio
playback hw:Audio/capture cloop: xrun sync 0 1
sync: cdelay=18000(18000), pdelay=9600(9600), fill=4800 (delay=27600), src_out=0
sync: cbufcount=9600, pbufcount=9600
sync: capt stop removed 9600 samples
playback hw:Audio/capture cloop: xrun sync 0 1
sync: cdelay=18000(18000), pdelay=0(0), fill=4800 (delay=18000), src_out=0
sync: cbufcount=0, pbufcount=0
sync: capt stop removed 0 samples
playback hw:Audio/capture cloop: xrun sync 0 1
sync: cdelay=18000(18000), pdelay=0(0), fill=4800 (delay=18000), src_out=0
sync: cbufcount=0, pbufcount=0
sync: capt stop removed 0 samples
playback hw:Audio/capture cloop: xrun sync 0 1
...

Moving outwards, some observations,

* `remove_samples()` falls into `if (loop->play->buf == loop->capt->buf)`, which is what decides to always remove 0 samples after some point (as seen in output).

* cdelay (from `snd_pcm_delay(capt->handle, &cdelay)`) is consistently 18000, meaning that `delay1 > fill` in `xrun_sync()` will always be true as `fill` is fixed during the run. If one forces this check to fail (by setting cdelay to 0), alsaloop recovers, with no audible delay compared to what's being played back.

* It is this code that leads to `xrun()` in the first place:

	if (avail == -EPIPE) {
		if ((err = xrun(lhandle)) < 0)

* The issue is hinted even earlier, as after

	err = snd_pcm_poll_descriptors_revents(play->handle, fds,
					       play->pollfd_count,
					       &prevents);

`(prevents & POLLERR)` is true.

* Depending on when STOP is sent, the same sometimes holds true after `thread_job1`'s

	err = poll(pfds, j, wake);

on `pfds[i].revents`.

I am not sure what the correct way of fixing this is, especially because I couldn't figure out why `snd_pcm_delay` returns this specific value. I can only guess it is related to aloop.

Other ways of throwing alsaloop into infinite loops is unplugging a soundcard that it's using (I believe it should exit in this case) and suspending/resuming the system. I haven't gone through the codepaths in those cases carefully yet, but I'm interested in fixing them eventually.

Please let me know if I can provide more useful output,
Dimitri

[alsa-info.sh]http://www.alsa-project.org/db/?f=89eb0056b0876a3b4fb377c39d5bc81405a308a7

--------------D6904CC8EC8B12271F3D1104
Content-Type: text/plain; charset=UTF-8;
 name="asoundrc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="asoundrc"

IyBwbGF5YmFjayBQQ00gZGV2aWNlOiB1c2luZyBsb29wYmFjayBzdWJkZXZpY2UgMCwwCnBj
bS5hbWl4IHsKICB0eXBlIGRtaXgKICBpcGNfa2V5IDIxOTM0NQogIHNsYXZlLnBjbSAiaHc6
TG9vcGJhY2ssMCwwIgp9CgojIGNhcHR1cmUgUENNIGRldmljZTogdXNpbmcgbG9vcGJhY2sg
c3ViZGV2aWNlIDAsMQpwY20uYXNub29wIHsKICB0eXBlIGRzbm9vcAogIGlwY19rZXkgMjE5
MzQ2CiAgc2xhdmUucGNtICJodzpMb29wYmFjaywwLDEiCn0KCiMgZHVwbGV4IGRldmljZSBj
b21iaW5pbmcgb3VyIFBDTSBkZXZpY2VzIGRlZmluZWQgYWJvdmUKcGNtLmFkdXBsZXggewog
IHR5cGUgYXN5bQogIHBsYXliYWNrLnBjbSAiYW1peCIKICBjYXB0dXJlLnBjbSAiYXNub29w
Igp9CgojIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQojIGZvciBqYWNrIGFsc2FfaW4gYW5kIGFsc2Ffb3V0OiBsb29wZWQtYmFjayBz
aWduYWwgYXQgb3RoZXIgZW5kcwpwY20ucGxvb3AgewogIHR5cGUgcGx1ZwogIHNsYXZlLnBj
bSAiaHc6TG9vcGJhY2ssMSwxIgp9CgpwY20uY2xvb3AgewogIHR5cGUgZHNub29wCiAgaXBj
X2tleSAyMTkzNDgKICBzbGF2ZS5wY20gImh3Okxvb3BiYWNrLDEsMCIKfQoKIyAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIyBkZWZh
dWx0IGRldmljZQoKcGNtLiFkZWZhdWx0IHsKICB0eXBlIHBsdWcKICBzbGF2ZS5wY20gImFk
dXBsZXgiCn0K
--------------D6904CC8EC8B12271F3D1104
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------D6904CC8EC8B12271F3D1104--
