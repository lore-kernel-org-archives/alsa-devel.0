From: Siegfried Kettlitz <alsa@siegfried-kettlitz.de>
Subject: Re: Float sample format
Date: Sun, 7 Nov 2004 19:11:19 +0100
Message-ID: <200411071911.19778.alsa@siegfried-kettlitz.de>
References: <Pine.HPX.4.33n.0411050933220.6258-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0411050933220.6258-100000@studcom.urz.uni-halle.de>
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

Am Freitag, 5. November 2004 09:37 schrieb Clemens Ladisch:
> Nicolas H=FCppelsh=E4user wrote:
> > On Thursday 04 November 2004 15:52, Clemens Ladisch wrote:
> > > Nicolas H=FCppelsh=E4user wrote:
> > > > When playing, the sound is loudest when using the whole range the
> > > > type offers.
> > >
> > > Really?  What sound card lets you play inifinitely loud samples? :-)
> >
> > ;-)  Well, in fact for playback I use [FLT_MIN,FLT_MAX] and it turned o=
ut
> > to be louder than [-1,1]
>
> The float->linear conversion code clips at -1/1 (search for GET32F_END
> in alsa-lib/src/pcm/plugin_ops.h), so what you got what a case of
> extreme compression.  No doubt this _is_ louder. :)
>

If you can do, generate a sine with 80Hz this should be a pure low tone whe=
n=20
amplitude is low. If you can't hear it use 160Hz instead.
(The equipment/stereo should be on low volume to make sure nothing is harme=
d.)=20
Until you reach the +-1 in amplitude it should only get a bit louder but no=
=20
changes should happen. When you excess it it gets interesting:
a) The limit is above of +-1 and it still dosen't get distorted.
b) Clipping occurs. You hear some distortion, getting bigger the bigger the=
=20
volume is. It appears to get louder but this is because of human perception.
c) Overflow occurs +1.1 gets mapped to -0.9. Your ears will fall off.


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
