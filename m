From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: snd_pcm_wait strangeness when resampling
Date: Thu, 11 Mar 2004 23:34:54 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <yw1xd67jnhbl.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
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


I've noticed some strange things with snd_pcm_wait.  My application
opens the sound device in non-blocking mode and uses snd_pcm_wait
whenever snd_pcm_writei return EAGAIN.  This works fine as long as
ALSA isn't doing any resampling.  However, when resampling (e.g. from
44.1 kHz to 48 kHz) snd_pcm_wait returns immediately, insisting that
there is room in the buffer, after which snd_pcm_writei obviously
returns EAGAIN once more.  The same thing happens if I use OSS
emulation and select() or poll().  Replacing the snd_pcm_wait call
with usleep(10000) makes the CPU load look normal again, while the
application still works.

I am using Linux 2.6.4, ALSA driver 1.0.3 and library 1.0.3a with a
SIS7012 chip.  It behaves the same way with kernel 2.6.3 and driver
1.0.2c.  I'm not quite sure when it started.

This application used to work properly.  Has something changed so I
need to modify my application?

--=20
M=E5ns Rullg=E5rd
mru@kth.se


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
