From: asbjs@stud.ntnu.no (Asbjørn Sæbø)
Subject: Q: Periodsize for capture, SBLive
Date: Mon, 18 Oct 2004 15:36:14 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041018133613.GA14810@stud.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

As part of a research project I am writing some software for=20
low latency transmission of audio samples over the network.
For the audio part of this I am using ALSA.  (Development=20
takes place on a Dell box running Debian Sarge Linux.)

I open the sound card (a SoundBlaster Live) for capture, and=20
request a period size (using set_period_size_near()) of 8 frames,
but what I get is a period size of 384 frames. =20

At 44100 Hz, 384 frames corresponds to a delay of at least 8.7ms,=20
and I would like to do quite a bit better.  (And better should also=20
be possible.  As far as I know ALSA, latencies down to a couple of
milliseconds should be possible.) =20

Is this large period size given by the sound card, and therefore=20
unavoidable, or can the card give lower period sizes than 384?

If the card can do better, what can I do, programming wise, to achieve=20
better performance? =20

(For now, my program is quite simple, it opens the sound card=20
(snd_pcm_open()), sets hardware parameters to 2 channels,
44100hz, access to SND_PCM_ACCESS_RW_INTERLEAVED and format to=20
SND_PCM_FORMAT_S16_LE.  It then reads samples from the card using=20
snd_pcm_readi().)


Asbj=F8rn S=E6b=F8
--=20
Asbj=F8rn S=E6b=F8, post.doc.
Centre for Quantifiable Quality of Service in Communication Systems
Norweigan University of Science and Technology
http://www.q2s.ntnu.no


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
