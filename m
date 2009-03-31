From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: problem with speaker-test
Date: Tue, 31 Mar 2009 10:20:32 +0200
Message-ID: <49D1D250.7060500@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atmel-es2.atmel.fr (mail.atmel.fr [81.80.104.162])
	by alsa0.perex.cz (Postfix) with ESMTP id 445901037ED
	for <alsa-devel@alsa-project.org>;
	Tue, 31 Mar 2009 10:20:46 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

I am trying to use speaker-test on my sam9g20 board, with the Wolfson 
wm8731, but I can't have any tone...
Instead it returns this error:
# speaker-test -c 2 -t1

speaker-test 1.0.14

Playback device is default
Stream parameters are 48000Hz, S16_LE, 2 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 16 to 1073745880
Period size range from 0 to 0
Using max buffer size 1073745880
Periods = 4
was set period_size = 0
was set buffer_size = 8192
Unable to set sw params for playback: Invalid argument
Setting of swparams failed: Invalid argument

So I tried:
# speaker-test -D"name" -c 2 -t1, but I don't know exactly what should I 
pass as "name".
I did: aplay -L to list all the devices, but I don't see anything...

Is anybody got an idea here?

Regards,
Sedji
