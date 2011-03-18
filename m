From: =?ISO-8859-1?Q?Marc=2DAndr=E9_H=E9bert?= <hebert.marcandre@gmail.com>
Subject: Keyclick latency
Date: Fri, 18 Mar 2011 10:13:29 -0400
Message-ID: <AANLkTim=b2hc-DB+UZN8bnr9XzpHpiA8EerjsyUh69N+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DA567103A01
	for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2011 15:13:31 +0100 (CET)
Received: by gwj15 with SMTP id 15so1711094gwj.38
	for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2011 07:13:29 -0700 (PDT)
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

I am working on an embedded device which does audio playback. Now when
the user presses a key, we want to play a tone to provide a keyclick
feedback to the user.

What we always did (we were using OSS before) was pretty much the
simplest thing possible which is for the application to:
-stop sending playback samples
-send the keyclick samples
-resume sending the playback samples

With our new hardware this approach does not produce good results
because of the size of the device's ringbuffer. The larger buffer
introduces a significant latency issue for the user feedback. Reducing
the ring buffer size is not a viable option to ensure no underruns are
generated on the system.

Now I was wondering if there a good approach for this using alsa.
Checking the api, a simple solution would be to:
-call snd_pcm_drop
-send the keyclick samples
-resume sending the playback samples

I've tried this and the latency is good, unfortunately there is the
drawback that some samples were dropped. So I guess the application
could :
-keep a copy of the samples sent,
-check the amount of  samples left in the ringbuffer before calling
snd_pcm_drop,
-send the keyclick
-resend dropped samples
-resume sending the playback samples

Seems a little overcomplicated so I was wondering if I was missing
something. Would there be a simpler approach? Something like pausing
the stream or reading the contents of the ringbuffer before dropping.

Thanks
Marc
