From: Bill Kapralos <billk@cs.yorku.ca>
Subject: Question Regarding Simple ALSA Stereo Output
Date: Wed, 23 Jun 2004 09:57:34 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0406230944290.6839@blue.cs.yorku.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

Hello

I am failry new to Linux programming and recently started using the ALSA
API for some software I am writing involving the output of sound to a apir
of headphones. Using (and slightly modifying) a simple example found on
the ALSA web site (Matthias Nagorni, "ALSA 0.9.0 Howto") I am able to
open the auduio port and send data to it however,  I am having some
difficulty with the output of stereo data.  In particular, I am
initializing the device for interleaved output (e.g.
SND_PCM_ACCESS_RW_INTERLEAVED) and specifying two channels (at 16 bit
little endian format).  I then have some stereo data (which I "create"
which is in interleaved format (e.g. first word (2-byte sample) is for the
left channel, second for the right channel, third for the left etc... but
when i do send this data to the audio device (using the "writei" function,
I do not get the desired result.  It appears as if it is simply outputting
the data assuming one channel e.g. the same signal is heard in both the
left and right ear even when I have deliberately made the signals
different (e.g. introduced a considerable delay to one channel etc.).
Furthermore, when I explicitly set all left channel samples to "0" and the
right channel samples to "non-zero", no sound is heard at all - it seems
as if only the left channel data is being output which is of course all
zero.  In contrast, if i set all the right channel samples to zero and the
left channel samples to non-zero, the sound is heard.

I am really confused with this problem! It appears as if I cannot control
what is sent to the left/right channel! Am i completely overlooking
something here? I am really puzzled by what I initially thought of as a
trivial matter!!!

Any help would be greatly appreciated! Thank You in advance!

Please reply to: billkATcs.yorku.ca (of course replace "AT" with "@".

Regards,


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
