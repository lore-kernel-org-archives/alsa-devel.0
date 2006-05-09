From: "Markus Rechberger" <mrechberger@gmail.com>
Subject: Re: crypto layer in alsa
Date: Tue, 9 May 2006 03:57:49 +0200
Message-ID: <d9def9db0605081857g2ef2f37cu2aa3c389e1b032f0@mail.gmail.com>
References: <7c587400605081323g53cae85fudbdf30167b500407@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <7c587400605081323g53cae85fudbdf30167b500407@mail.gmail.com>
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
To: lorenzo <lagrespan@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I think this will not really work out. Many applications encode the
data stream in a lossy format I'm sure so does Skype.
That's just what I think about it..

Markus

On 5/8/06, lorenzo <lagrespan@gmail.com> wrote:
> Greetings. In those days where the FCC is imposing ISPs to let voip to
> be tapped, I was thinking if there's a way to use my favorite VoIP
> (skype) app in a secure way.
> Let me state it clear: I don't like how skype handles security,
> because I can't *see* how it works. But it's widely spread, everybody
> uses it, and so it's my VoIP app of choice.
>
> Now to the point: would it be difficult to implement some sort of
> crypto layer into alsa? So that what I say in the microphone gets
> encrypted *before* being available to the userland applications?
> Being the naive sort of programmer I am, I was thinking of a kernel
> module (let's call it alsa-crypto) that intercepts the audio stream
> coming from the microphone, encrypts it with a (say) block cipher + a
> user-supplied key, and sends it out as if it was a regular audio
> stream. Same thing on the other end.
> The user-supplied key could be provided by a userland application that
> reads the other part's public key file from a keyring.
>
> Other questions are: would this layer add too much complexity and
> delay to the whole audio stream (clicks, delays, white noise) to be
> helpful?
> Might a dedicated co-processor help? Or it's all about CPU horsepower?
> Also, would this make audio-compressing algoritmhs completely useless
> or, worse, could such algorithms make the cipherstream useless? I'm
> thinking about, say, Skype that to make things faster might use some
> algorithm to "compress" the audio stream and make it smaller to send
> to the other end.
>
> begging your perdon if I'm asking a silly question,
>
> my best regards to everybody
>
> l.g.
>
> ps: I've tried to google for it but I couldn't find an already started pr=
oject.
> ps2: a windows .dll should also be done, but that's anoter game..
>
> --
> :lorenzo grespan
> GPG Key fingerprint =3D 5372 1B49 9E61 747C FB9A  4DAE 5D2A A9A0 74B4 8F1=
A
>
>
> -------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job ea=
sier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronim=
o
> http://sel.as-us.falkag.net/sel?cmdlnk&kid=120709&bid&3057&dat=121642
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>


--
Markus Rechberger


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
