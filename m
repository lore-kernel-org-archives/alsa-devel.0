From: "RKHenry" <robert.henry@earthlink.net>
Subject: RE: error: broken pipe
Date: Sun, 15 May 2005 10:12:59 -0400
Message-ID: <000601c55958$34396d20$6501a8c0@rkh>
References: <Pine.LNX.4.58.0505151101040.4270@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0505151101040.4270@pnote.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



-----Original Message-----
From: alsa-devel-admin@lists.sourceforge.net
[mailto:alsa-devel-admin@lists.sourceforge.net] On Behalf Of Jaroslav =
Kysela
Sent: Sunday, May 15, 2005 5:02 AM
To: Christian Konrad
Cc: alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] error: broken pipe

On Sat, 14 May 2005, Christian Konrad wrote:

> Hi!
>=20
> what exactly does this error mean? This is just a sine-genrator and it
> uses the following code:
>=20
> while( (pcmreturn =3D snd_pcm_writei(pcm_handle, data, frames)) < 0)
> {
> 		=09
> 	switch(pcmreturn)
> 	{
> 	case EBADFD:	cout << "EBADFD" << endl; break;
> 	case EPIPE:	cout << "Buffer underrun." << endl; break;
> 	case ESTRPIPE:	cout << "suspend. " << endl; break;=09
> 	default: cout << snd_strerror(pcmreturn) << endl;
> 	}
> 		=09
> =09
> 	snd_pcm_prepare(pcm_handle);
> }
>=20
> The only error I get is broken pipe (returned by snd_strerror).

It's correct. You should check for negative values (e.g. -EPIPE) in your =

switch statement.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=3D7393&alloc_id=3D16281&op=3Dclick
_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
