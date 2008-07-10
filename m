From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
Subject: S24_LE is 3 bytes ? in alsa-lib example pcm.c
Date: Thu, 10 Jul 2008 10:24:16 +0200
Message-ID: <4875C730.7080003@aimvalley.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-vbr4.xs4all.nl (smtp-vbr4.xs4all.nl [194.109.24.24])
	by alsa0.perex.cz (Postfix) with ESMTP id A7EC51037F0
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Jul 2008 10:24:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


as far as I know:
sample format S24_LE is 24bit sample in 4 bytes
sample format S24_3LE is 24bit sample in 3 bytes
(why else have separate definitions), right ?

In the ALSA-LIb example /test/pcm.c however
(http://www.alsa-project.org/alsa-doc/alsa-lib/_2test_2pcm_8c-example.html)
there is no diff between the 2 sample formats.

I noticed this by simply showing the bytes presented to snd_pcm_writei
See:

S32_LE (for reference)
----------------------
./pcm -c 2 -o S32_LE -f 4000
Playback device is plughw:0,0
Stream parameters are 48000Hz, S32_LE, 2 channels
Sine wave rate is 4000.0000Hz
Using transfer method: write
write_loop: going to write: period_size=4096 samples
data[00:31]= 00000000 00000000 ffffff3f ffffff3f a0ebd96e a0ebd96e ffffff7f ffffff7f
data[32:63]= a0ebd96e a0ebd96e ffffff3f ffffff3f 00000000 00000000 010000c0 010000c0

S24_3LE (as expected)
----------------------
./pcm -c 2 -o S24_3LE -f 4000
Playback device is plughw:0,0
Stream parameters are 48000Hz, S24_3LE, 2 channels
Sine wave rate is 4000.0000Hz
Using transfer method: write
write_loop: going to write: period_size=4096 samples
data[00:31]= 00000000 0000ffff 3fffff3f ead96eea d96effff 7fffff7f ead96eea d96effff
data[32:63]= 3fffff3f 00000000 00000100 c00100c0 16269116 26910100 80010080 16269116

S24_LE
----------------------
./pcm -c 2 -o S24_LE -f 4000
Playback device is plughw:0,0
Stream parameters are 48000Hz, S24_LE, 2 channels
Sine wave rate is 4000.0000Hz
Using transfer method: write
write_loop: going to write: period_size=4096 samples
data[00:31]= 00000000 0000ffff 3fffff3f ead96eea d96effff 7fffff7f ead96eea d96effff
data[32:63]= 3fffff3f 00000000 00000100 c00100c0 16269116 26910100 80010080 16269116


I would expect to see
data[00:31]= 0x00000000 00000000 00ffff3f 00ffff3f 00ebd96e 00ebd96e 00ffff7f 00ffff7f
data[32:63]= 0x00ebd96e 00ebd96e 00ffff3f 00ffff3f 00000000 00000000 000000c0 000000c0
for S24_LE

do I miss something ?
is this is a fault in /test/pcm.c ?


-- 
This message has been scanned for viruses and is believed to be clean
