From: Koushik jaikishan <jaykishankrk@yahoo.co.in>
Subject: Full Duplex audio using ALSA [Through UDP] .
Date: Tue, 10 May 2005 12:25:37 +0100 (BST)
Message-ID: <20050510112537.23622.qmail@web8310.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: 6667
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


hello all,
the present work of mine is in the area of transfering
audio through UDP.
i am stuck up in a stage where i am hearing to my own
voice instead i should have heard the other persons
voice. much of my code is from latency.c  file from
alsa-proj, and i am hearing Cliche sound for every
iteration of the for loop, i think this is because of=20
  initail writes that latency.c does for playback.
this  initialises sound card to read and write if i am
correct. please let me know the possible solution to
get audio through UDP. Thanks=20

regards,

Koushik P S R=20






--- Clemens Ladisch <clemens@ladisch.de> wrote:
> Koushik jaikishan wrote:
> > i am not able to read constant amount of data from
> the
> > sound card i dont know why, it always gives me -
> 11 as
> > the returned value for reading 960 bytes of data.
>=20
> -11 is -EAGAIN.  You would be able to read some data
> if you waited
> some time.
>=20
> Either disable the non-blocking mode with
> snd_pcm_nonblock, or wait
> with snd_pcm_wait, or, if you have other devices to
> wait for, use the
> snd_pcm_poll_* functions with poll().
>=20
>=20
> HTH
> Clemens
>=20
>=20

________________________________________________________________________
Yahoo! India Matrimony: Find your life partner online
Go to: http://yahoo.shaadi.com/india-matrimony


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=3D7393&alloc_id=3D16281&op=3Dclick
