From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: alsa driver, repeat playback of buffer contents
Date: Mon, 14 Mar 2005 23:20:29 +0100
Message-ID: <yw1xu0ndj2du.fsf@ford.inprovide.com>
References: <200503141530.20339.random.bits@rogers.com> <1110836720.15088.3.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
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

Lee Revell <rlrevell@joe-job.com> writes:

> On Mon, 2005-03-14 at 15:30 -0500, random.bits wrote:
>> I have been reading up on the alsa driver. I would like=20
>> to have the alsa driver play a small pcm sound bite=20
>> over and over without have to re-write it to the=20
>> device.
>>=20
>> By small, I mean 1.9K in length. I have followed the=20
>> examples enough to get it to play the sound bite once,=20
>> but I cannot figure out how to get it to play it=20
>> multiple times without having to make another call to=20
>> snd_pcm_writei() again.
>
> Why in the heck are you using write() instead of mmap()?

snd_pcm_writei() often uses mmap() behind the scenes.

--=20
M=E5ns Rullg=E5rd
mru@inprovide.com



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
