From: =?iso-8859-1?Q?B=F6ttcher_Marcel?= <MBoettcher@ccsonline.de>
Subject: AW: General CS46xx spdif question
Date: Wed, 9 Oct 2002 22:00:45 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <A1C093A67286D511A159000629E2AAA00B9BFA@CCSMAIL>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: 'Benny Sjostrand' <gorm@cucumelo.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thanks for your response,
with my card (terratec 6pack ) there is no sound from spdif at all , is
there a special configuration needed?

regards=20
Marcel

-----Urspr=FCngliche Nachricht-----
Von: Benny Sjostrand [mailto:gorm@cucumelo.org]
Gesendet: Mittwoch, 9. Oktober 2002 21:51
An: B=F6ttcher Marcel; alsa-devel@lists.sourceforge.net
Betreff: Re: [Alsa-devel] General CS46xx spdif question


>
>
>If I unmute the spdif in should the audio automaticaly transfered to =
the
>speakers if a spdif source is connected or is there a need for a logic
>transfering the data?How can I figure out if the copyright , copy etc =
flags
>are set?Does it automatically synchronize to the input sample rate?
> =20
>
For the moment only 48Khz Stereo is supported by SPDIF input,
and it's not  possible to check the additional bits, copyright, etc.=20
with the current driver,
however it's supported by the DSP, just not implemented, and so on, any
fancy thing like Surround 5.1 is not implemented either (yet)

There are currenlty some problems with the SPDIF input parts, the sound
sometimes get's distorcionated, left and right channel sometimes gets=20
swapped.

/Benny


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
