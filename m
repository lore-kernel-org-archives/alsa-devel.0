From: ian <deviant@custard.org>
Subject: midi byte stream decoder
Date: Thu, 5 Dec 2002 16:33:48 +0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0212051621100.22092-100000@rhubarb.custard.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
I've been using the midi byte stream encoder/decoder to convert
snd_seq_event_t's to and from midi byte streams. I discovered that the
decoder is not handling sysex events properly - a valid sysex event gets
decoded to junk. Looking at lines 440 onwards of seq_midi_event.c (in the
rc6 library source), the code is writing the event to dev->buf, the
decoder buffer, and doesn't touch buf, the argument to the decode
function, which is where the user is supposed to get the returned byte
stream from.
I'm assuming that the code should be copying to buf, not dev->buf?
Thanks,
Ian



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
