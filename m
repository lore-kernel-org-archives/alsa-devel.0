From: Tom Watson <sdc695@yahoo.com>
Subject: Problem with Pulse Audio plugin?
Date: Sat, 14 Mar 2009 18:57:20 -0700 (PDT)
Message-ID: <484027.10000.qm@web65416.mail.ac4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web65416.mail.ac4.yahoo.com (web65416.mail.ac4.yahoo.com
	[76.13.9.36]) by alsa0.perex.cz (Postfix) with SMTP id 7F505243C6
	for <alsa-devel@alsa-project.org>; Sun, 15 Mar 2009 02:57:21 +0100 (CET)
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


I'm doing some experimenting and found that a simple sequential play of a small sound file caused an assertion in the pulse audio plugin.  The base system is Fedora 8, and it uses alsa 1.0.16 versions.  I looked at the 1.0.19 versions and they still have assertions, so the problem may still be there.  It is pretty easy to trip up:

$ aplay blah.wav blah.wav
Playing WAVE 'blah.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Playing WAVE 'blah.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
aplay: pcm_pulse.c:524: pulse_hw_params: Assertion `!pcm->stream' failed.
Aborted by signal Aborted...

(where "blah.wav" is a simple short wav file)  The first time through, it plays find, but the second time it doesn't.

If this has been solved in 1.0.19, (I haven't installed it), please let me know and I'll go away.  If not, it may be a problem in the pulse audio thing.

Thanks.


-- 
Tom Watson
tsw@johana.com
