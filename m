From: Richard Smith <smithbone@gmail.com>
Subject: Status of M-Audio Audiophile USB
Date: Wed, 26 Oct 2005 14:16:42 -0500
Message-ID: <8a0c36780510261216x387ca9c0ib9e51f64e319852a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
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

I reciently purchased an Audiophile USB and it arrived last night.

My needs are not multi-channel and so I thought it would be nice to
have a high quality sound device I could use with both my laptop and
my desktop.  I googled for compatibility and found that usb-audio
stuff should work Ok with alsa

Of course I didn't google deep enough to find out that the Audiophile
USB is a non-standard device.  I've managed to make the device play
using alsaplayer and the Big Endian formats.  I see that if I set up
the plughw then I can probally get it to work with other programs.

What I haven't made work is recording.  Using arecord and hw:0,0 just
gives silence and hw:0,1 white noise.
I've dug up a post that said that recording on this device is
problematic and it could be a while before it worked but it was dated
earlier this year.

Has there been any movement on this device?  I can run under Windows
and capture USB logs if needed.

--
Richard A. Smith


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
