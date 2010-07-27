From: Adam Rosenberg <adam@alcorn.com>
Subject: using plug for sample format conversion
Date: Tue, 27 Jul 2010 18:17:08 -0400
Message-ID: <AANLkTimd1EShJJ75Y_FZX7fkv1vDg8JDFTMBcLnWHAR8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 507A224416
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Jul 2010 00:17:11 +0200 (CEST)
Received: by qyk8 with SMTP id 8so3343985qyk.17
	for <alsa-devel@alsa-project.org>; Tue, 27 Jul 2010 15:17:09 -0700 (PDT)
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

I am trying to use plug to play audio files that are S16_LE but my
hardware only supports S32_LE.  It is not working.  Here is an example
of the problem using speaker-test.  First I use S32_LE and it works as
expected.  I then try S16_LE but it fails.  Does this mean the plug
plugin cannot convert between these sample formats?

Thanks,
Adam

root:/> speaker-test -l 1 -r 48000 -c 2 -F S32_LE -Dplughw:0,0,0

speaker-test 1.0.12

Playback device is plughw:0,0,0
Stream parameters are 48000Hz, S32_LE, 2 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 1 to 4096
Period size range from 1 to 4096
Using max buffer size 4096
Periods = 4
was set period_size = 1024
was set buffer_size = 4096
 0 - Front Left
 1 - Front Right
Time per period = 5.844000

root:/> speaker-test -l 1 -r 48000 -c 2 -F S16_LE -Dplughw:0,0,0

speaker-test 1.0.12

Playback device is plughw:0,0,0
Stream parameters are 48000Hz, S16_LE, 2 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 1 to 4096
Period size range from 1 to 4096
Using max buffer size 4096
Periods = 4
was set period_size = 1024
was set buffer_size = 4096
Unable to set hw params for playback: Invalid argument
Setting of hwparams failed: Invalid argument
