From: Francesco Abbate <segfault@email.it>
Subject: problems with ALSA and SDL
Date: Tue, 27 Jan 2004 19:01:40 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040127190140.29693112.segfault@email.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello everyone,

I've recently switched to the 2.6.x kernel and I've decided to
switch to ALSA too.

I've enabled ALSA into the kernel *without* OSS emulation and
I've began to manage to get things works.

Now I can say that everything works with the exception of sfxload
(the program that load the soundfont for the AWE32/64) which still
require OSS (emulated or not). But this is not the problem I want
to discuss here.

One of the major problem I've encountered with ALSA is that it *seems*
to be very CPU intensive.
In fact I've compiled the SDL library with ALSA and I've discovered that
my CPU is not fast enough to run the game when the sound is anabled.
The CPU get a very heavy load and the sound is badly scattered (buffer
underrun I suppose).
The strange thing is that I've tried quite simple game that previously
works very well with OSS. My CPU is also not so bad because it is an
AMD K6 MMX 200 MHz.
I've given a glance to the ALSA code of SDL and it seems to be plain
PCM playback code without any sofistication.
At beginning I was thinking that the problem was the use of "plughw"
instead of "hw" but I've tried with "hw" and the situation is still
the same.

So the question is :
is ALSA much more CPU intensive then OSS or there is some
technical problem which cause this effect ?
why there is such difference with OSS ?

I hope I've not to switch back to OSS simply because I cannot run
some *simple* games.

-- 
Francesco Abbate
-- 
Francesco Abbate


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
