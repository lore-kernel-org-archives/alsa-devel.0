From: cong fu <fc4976@gmail.com>
Subject: [Alsa-devel]JACK will block audio application and
 audio application will also blcok JACK
Date: Mon, 18 Apr 2011 09:56:28 -0400
Message-ID: <BANLkTikSZMqJeRJ5EHZZShvskV-ccx08rw@mail.gmail.com>
References: <BANLkTi=u9OvWJkPXbxhg5tj_O9Mti9Jeew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D3F6103810
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Apr 2011 15:56:29 +0200 (CEST)
Received: by vws20 with SMTP id 20so4197548vws.38
	for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2011 06:56:28 -0700 (PDT)
In-Reply-To: <BANLkTi=u9OvWJkPXbxhg5tj_O9Mti9Jeew@mail.gmail.com>
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

Hi experts:
I installed JACK and the GUI of it looks good.
 But it seems it will block the "audio application" and "audio
application" will also blcok it.
That is to say:
1) If I started the JACK by:
sudo /usr/bin/jackd -r -m -dalsa -dhw:0 -r44100 -p1024 -n2 -P
Then I open my web brower and try to play a streaming song(play by
flash), the song can't play!

2) If I stoped the JACK
Then  I open my web brower and try to play a streaming song, the song
played good!

3)if I play a song by mplayer or web brower at first
Then I try to start the JACK, there is an error:

Acquire audio card Audio0
creating alsa driver ... hw:0|-|1024|2|44100|0|0|nomon|swmeter|-|32bit
Using ALSA driver HDA-Intel running on card 0 - HDA NVidia at 0xfe024000 irq 23
the playback device "hw:0" is already in use. Please stop the
application using it and run JACK again
Cannot initialize driver
JackServer::Open() failed with -1
Failed to start server

My system is Debian Lenny.

So how can I play sound with JACK started?
