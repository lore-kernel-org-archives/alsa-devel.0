From: "Bob Ingraham" <bobi@netshel.net>
Subject: Converting OSS ioctl's to ALSA API
Date: Mon, 5 Sep 2005 17:49:58 -0700 (PDT)
Message-ID: <33017.65.103.251.231.1125967798.squirrel@65.103.251.231>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hello,

I'm converting the audio subroutines of a video-conferencing application
from using OSS to using ALSA.  This app uses the blocking-read/write
model.

I've read through all of the documentation I could find, but am not sure
how to convert some of the more "advanced" OSS ioctl's directly to ALSA
Library API calls.

For example, what would be the equivalent of the OSS SNDCTL_DSP_SYNC
ioctl?  The previous programmer used this to wait for playback completion=
.

Another example would be the equivalent of the SNDCLT_DSP_GETOSPACE,
SNDCTL_DSP_GETISPACE and SNDCTL_DSP_SETFRAGMENT ioctls.

BTW, in case anyone mentions it, we don't want to use the OSS emulation
mode, as it hasn't worked-out for us.

Any help would be most appreciated.

Thanks,
Bob


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
