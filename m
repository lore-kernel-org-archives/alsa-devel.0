From: Tony Hardie-Bick <tonyhb@easynet.co.uk>
Subject: Broken pipe problems (with details)
Date: Sat, 20 Jul 2002 15:06:05 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020720150605.A531@siberia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I'm writing an app that does audio analysis in real time. It works fine
under OSS. Moved to a laptop for demo purposes, using ALSA, and I've
found it incredibly difficult to reliably get audio from the soundcard. I
am considering using JACK, since it's clear that may save a lot of pain
long term. However, I would like to avoid recoding for now, if there is
something simple I am doing wrong with ALSA.

Basically, with a short input buffer of around 2000 frames (using stereo
16 bit 44.1kHz, no output stream) I can get the app to run until I call
up any other system resources, ie, start another app, or just flick
windows under KDE, thus causing some scheduling adjustment. Then it just
gives up. I get a "Broken pipe" error returned from the snd_pcm_readi()
call. snd_pcm_prepare() and snd_pcm_resume() aren't able to deal with
this, and so I'm left with setting up the whole connection all over again,
which surely shouldn't be necessary.

I have based the code on the latency.c example app, but am posting now,
rather than go through all the other possible methods that are given
in latency.c. In the present app, there is no problem with occasionally
losing a few milliseconds of audio data.

Thanks in advance,

Tony


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
