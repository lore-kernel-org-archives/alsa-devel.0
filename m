From: Florian Bomers <Florian.Bomers@sun.com>
Subject: Re: Playing always at half of the rate of recording.
Date: Tue, 19 Nov 2002 14:07:13 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DDAB611.E2DEF97B@sun.com>
References: <F9hQkQiijdhvs3qJSyl00011c5a@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?iso-8859-1?Q?=E8=B6=20=E6?= <flyingwalter@msn.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

are you sure that sample size, number of channels and sample rate is the =
same for playback
and record?

Florian


"=E8=B6 =E6" wrote:
> =

> Hi All,
>   I'm using alsa library to write an application that play and record a=
udio
> at the same time. I openned the default pcm device twice, and set param=
s for
> them, nonblock, RW_INTERLEAVED, S16_LE format, 8000Hz, and 1 channel, t=
he
> only difference is using SND_PCM_STREAM_CAPTURE for recording, and usin=
g
> SND_PCM_STREAM_PLAYBACK for playing.
>   But the bytes played are always near half of the recorded, and the so=
und I
> heard is slowed comparing with its normal speed.
>   My enviroment are:
>   RedHat 7.3 / alsa 0.9.0 rc5 / linux kernel 2.4.18-3
>   sound card module: via82xx
> =

>   How can I solve this?
>   Thanks!
> =

> Walter
> =

> _________________________________________________________________
> MSN 8 helps eliminate e-mail viruses. Get 2 months FREE*.
> http://join.msn.com/?page=3Dfeatures/virus
> =

> -------------------------------------------------------
> This sf.net email is sponsored by: To learn the basics of securing
> your web site with SSL, click here to get a FREE TRIAL of a Thawte
> Server Certificate: http://www.gothawte.com/rd524.html
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- =

Florian Bomers
Java Sound
Java Software/Sun Microsystems, Inc.
http://java.sun.com/products/java-media/sound/


-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
