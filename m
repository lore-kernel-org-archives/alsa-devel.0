From: asbjs@stud.ntnu.no (Asbjørn Sæbø)
Subject: Distorted sound writing audio to Delta 44 sound card
Date: Tue, 8 Nov 2005 15:19:27 +0100
Message-ID: <20051108141927.GA2923@stud.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from fri.itea.ntnu.no (fri.itea.ntnu.no [129.241.7.60])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1A6AA1C0
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2005 15:19:29 +0100 (MET)
Received: from localhost (localhost [127.0.0.1])
	by fri.itea.ntnu.no (Postfix) with ESMTP id 642D080FA
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2005 15:19:28 +0100 (CET)
Received: from tiger.stud.ntnu.no (tiger.stud.ntnu.no [129.241.56.180])
	by fri.itea.ntnu.no (Postfix) with ESMTP
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2005 15:19:28 +0100 (CET)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I am developing an application for transmission of audio over IP.
(See http://www.q2s.ntnu.no/~asbjs/ldas/ldas.html )

I did have two-way transmission working between two computers equipped
with SoundBlaster Live cards.  But when I swithced one of the sound
cards for a M-Audio Delta 44, the audio transmitted to this computer
became very distorted.  (I describe the situtation in more detail
below.)  Any advice regarding what may be the cause of this, and how it
can be fixed, would be very welcome.  I am especially interested in=20
comments on the code lines included at the bottom.


Description
-----------
The audio transmitted from the Delta 44-equipped computer to the SBLive
equipped one comes out fine, as before.  But the audio transmitted the
other way, from the SBLive computer to the Delta 44 computer comes out
very distorted.  The distorted signal is clearly correlated to the
original signal.  The distortion is not noise, neither is it the result=20
of clipping or overdriving.  (It sounds kind of like a model airplane
engine modulated in some way by the original signal.)

Furthermore, instead of having signal on two channels as expected (the
transmitted signal is stereo), the Delta 44 has signals on all eight
"PCM Out"  channels shown by the mixer (envy24control).  When
transmitting music, all of these channels sound quite alike, with the
same distorted signal.  When transmitting a click track, the clicks come
and go (a few clicks are heard, then there is silence for a few clicks)
for many of the channels.


Theories and questions
----------------------
I have been adviced that the Delta 44 is a 24 bit device, and that=20
opening the "plughw:0,0" device (instead of the "default" device) might=20
give better results.  But this does not seem to be the case.  Actually=20
it seems that the plughw layer is used anyhow, snd_pcm_dump() gives the=20
same output in both cases, showing a PLAYBACK device with=20
MMAP_INTERLEAVED access, S16_LE format and two channels (equal to the=20
SBLive setup) and the actual Delta 44 card as a "Slave".

I am not very familiar with this plughw layer.  But can I assume that
the resulting device can be accessed and used like a "real" card with=20
the same properties reported by snd_pcm_dump()?  Or are there any=20
subtleties that one should care for when transferring data to the card=20
(or otherwise)?

I suspect that the problem may be connected to the conversion from a
series of bytes transmitted on the network to audio frames that I write
to the sound card.  If something goes astray in this mapping, it may
very well explain the observed behaviour. =20
Details of the conversion follows below.  This worked before the sound
card was changed.  Are there any reasons that is should not work now
that the SBLive has been replaced with the Delta 44?

-------------------------------------------

typedef int databuffer_t[BUFFERBYTES / 4];  =20
    /* A frame is 4 bytes (2 channels, 16 bits), an int is 4 bytes */
const snd_pcm_channel_area_t *dst_area;=20
databuffer_t *dst_address; =20


retval =3D snd_pcm_mmap_begin(receiver->soundcardh, &dst_area,=20
                                &offset, &frames);

    /*  dst_area->address is "base address of channel samples"
     *  dst_area->first is "offset to first sample in bits". =20
     *  (Seems to be zero here.  Does this come in addition to "offset"? =
=20
     *  If so, add dst_area->first/8 to dst_address.)
     *
     *  offset is "Returned mmap area offset in area steps (=3D=3D frames=
)".
     *  The documentation does not say so specifically, but it seems=20
     *  that the pcm_area that we
     *  get access to trough the snd_pcm_mmap_begin() call should be=20
     *  used from the offset off. =20
     *  (The number of bytes per frame is given by SND_FRAME_BYTES.)
     */  =20
dst_address =3D (databuffer_t *) ((char *)dst_area->addr +=20
                                      offset*SND_FRAME_BYTES);
retval =3D queuecopydata(&queue, dst_address, &pool);

nwritten =3D snd_pcm_mmap_commit(receiver->soundcardh, offset, frames);

--------------------------------------------------

Where queuecopydata() mainly copies data from the queue to the area=20
starting at dst_address, an int at a time.  (An int is used for a=20
frame of data, since in this case, both are four bytes.  Ugly, I=20
know.)




Asbj=F8rn S=E6b=F8



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
