From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: Re: [PATCH] sparc dbri: recording is back
Date: Thu, 24 Aug 2006 08:09:26 +0200
Message-ID: <44ed42960731f@wp.pl>
References: <44ec9a1bf3034@wp.pl> <s5hirkjwc4w.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-reply-to: <44ec9a1bf3034@wp.pl> <s5hirkjwc4w.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org



Dnia 23-08-2006 o godz. 20:16 Takashi Iwai napisa=B3(a):
> At Wed, 23 Aug 2006 20:10:35 +0200,
> Krzysztof Helt wrote:
> > =

> > @@ -2159,7 +2139,7 @@ static snd_pcm_uframes_t snd_dbri_pointe
> >  	snd_pcm_uframes_t ret;
> >  =

> >  	ret =3D bytes_to_frames(substream->runtime, info->offset)
> > -		% substream->runtime->buffer_size;
>  >+		% (substream->runtime->buffer_size + 1);
> >  	dprintk(D_USR, "I/O pointer: %ld frames of %ld.\n",
> >  		ret, substream->runtime->buffer_size);
> >  	return ret;
> =

> What is the reason of this change?  The original code looks OK
to me.
> The pointer callback must return a value between 0 and
> (buffer_size-1).
> =

> =


I will recheck if recording works without this change. The last
returned pointer value is equal to buffer_size. Your email
implies that 0 means "I have full buffer filled with data".

Regards,
Krzysztof

----------------------------------------------------
Ogl=B1daj -> Wydarzenia.wp.pl -> Wiesz, co najwa=BFniejsze!
Najbardziej aktualne materia=B3y filmowe - Kliknij:
http://klik.wp.pl/?adr=3Dwww.wydarzenia.wp.pl&sid=3D848



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
