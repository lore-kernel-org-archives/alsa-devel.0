From: gammay <gammay@gmail.com>
Subject: ALSA and MP3
Date: Thu, 13 Aug 2009 13:48:01 +0530
Message-ID: <8aaaf9230908130118hec83f4awe28fb5e53b5e02a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.147])
	by alsa0.perex.cz (Postfix) with ESMTP id CA6FE2443E
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Aug 2009 10:18:01 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 13so153209eye.56
	for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2009 01:18:01 -0700 (PDT)
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
I am looking at making this product use case possible:
Audio samples are streamed over wire/wireless from a source device to a sink
device. The streaming format is in mp3. On the source device I need to
capture locally played mp3 samples and stream to the sink device. The sink
device takes care of uncompressing and playback.

Can we capture compressed mp3 streams directly using ALSA? It is possible to
capture uncompressed PCM samples using file plug or by other means in
ALSA. While it is possible to directly read from the mp3 file, I would
rather grap the samples that a media player sends out because a) it takes
care of timing b) I can control the media player to play/pause the stream
and for playlist management. For the user it is transperent - he/she will
use only the local media player to control the streaming.

I am not sure if this lies in the domain of ALSA at all - as I understand
once we are in ALSA we are dealing with only PCM. In such case, please give
me some pointers where I can look at to make this possible. I am using
mplayer, but can also look at other types (non-GUI, command-line based). Can
we do this in a non-media player specific way?

Thank you,
Girish
