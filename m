From: Joachim Falk <joachim.falk@gmx.de>
Subject: Control renaming for EMU10k1
Date: Sat, 26 Jun 2004 16:25:57 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40DD8775.2@jfalk.easynet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hey alsa-devel list,
I have a SB Live sound card
// 'Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
// Subsystem: Creative Labs SB Live! 5.1 Model SB0100'
//
// numeric:
// 'Class 0401: 1102:0002 (rev 07)
// Subsystem: 1102:8064'
With AC97 Sigmatel 9708/11. The names for the AC97 controls from
ac97_codec.c do not match how they are used on the Live.
So I have done some Control renaming in the emumixer.c
But the "AC97 Surround Playback control" is a stereo control
but is used for the Live as control for Center and LFE.

So my question is how can i best rename this control to have two
different names matching the functionality for the right and left
channel of the stereo channel ?

Or is driver hacking here foolish and there exists a better mechanisme
for this kind of stuff in userspace ?

My longterm goal is to improve the mixer for SB Lives.

MfG
Joachim Falk
- --
Joachim Falk <Joachim.Falk@gmx.de>

You can always tell a really good idea by the enemies it makes.
~  --programmers' axiom
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA3Yd1KwZcgs55jUMRAoLYAKDIOLMlPv46p59x7IBr+yx78Dhk0ACeKlmy
8K29AwabmQ9iRZr26gArP2w=
=wOBs
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
