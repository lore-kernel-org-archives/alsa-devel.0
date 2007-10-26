From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Sample format coversion bug?
Date: Fri, 26 Oct 2007 19:18:42 +0600
Message-ID: <4721E932.5090603@ums.usu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay4.usu.ru (relay4.usu.ru [194.226.235.39])
	by alsa0.perex.cz (Postfix) with ESMTP id 4760E24475
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Oct 2007 15:18:51 +0200 (CEST)
Received: from relay4.usu.ru (localhost [127.0.0.1])
	by relay4.usu.ru (PostSystem) with ESMTP id 60A5018116
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Oct 2007 19:18:53 +0600 (YEKST)
Received: from usu2.usu.ru (usu2.usu.ru [194.226.237.16])
	by relay4.usu.ru (PostSystem) with ESMTP id 98AE917EA9
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Oct 2007 19:18:52 +0600 (YEKST)
Received: from usu2.usu.ru (localhost.usu2.usu.ru [127.0.0.1])
	by usu2.usu.ru (Postfix) with ESMTP id 2B0F6A7E95
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Oct 2007 19:18:45 +0600 (YEKST)
Received: from ums.usu.ru (ums.usu.ru [194.226.236.116])
	by usu2.usu.ru (Postfix) with ESMTP id C9AA7A7EB0
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Oct 2007 19:18:44 +0600 (YEKST)
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

Hello,

I am writing an application that uses ALSA, and I don't want to write 
code to support all possible sample formats. On IRC, I asked whether it 
is OK to support only S24 format internally and rely on the "plug" to do 
the required conversion. I got a positive answer, but, when testing my 
application against my SAA7134-based tuner as a capture device, found 
that it doesn't work.

The problem is also reproducible with "arecord". Given that plughw:1 
refers to a SAA7134-based tuner (which obviously doesn't support S24_LE 
natively), running the following command

arecord -vvv -f S24_LE -c 2 -r 32000 -D plughw:1 /dev/null

produces the following output:

ALSA lib pcm_mmap.c:369:(snd_pcm_mmap) mmap failed: Invalid argument
arecord: set_params:961: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S24_LE
SUBFORMAT:  STD
SAMPLE_BITS: 32
FRAME_BITS: 64
CHANNELS: 2
RATE: 32000
PERIOD_TIME: 125000
PERIOD_SIZE: 4000
PERIOD_BYTES: 32000
PERIODS: 4
BUFFER_TIME: 500000
BUFFER_SIZE: 16000
BUFFER_BYTES: 128000
TICK_TIME: 4000

This is on Debian, the kernel is 2.6.22-2-amd64, libasound2 is 
1.0.14a-2. Same for S32_LE.

-- 
Alexander E. Patrakov
