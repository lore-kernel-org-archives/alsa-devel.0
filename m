From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: Re: Problem with __OLD_GET
Date: Fri, 16 Jan 2004 22:12:01 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <opr1vzubwoq1sf88@mail.broadpark.no>
References: <opr1tl8sroq1sf88@mail.broadpark.no> <s5h7jzren70.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7jzren70.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi, Takashi

I have no experience with libtool myself, but from what I can see the=20
plugin host (beep-media-player) uses it. libtool --version tells me this:=
=20
ltmain.sh (GNU libtool) 1.4.3 (1.922.2.111 2002/10/23 02:54:36). But at=20
the same time we have another person, Rene Rebe, posting about a similar=20
problem and who does not appear to be using libtool (correct me here if=20
I'm mistaken).

Regards

Arve Knudsen

On Fri, 16 Jan 2004 19:57:23 +0100, Takashi Iwai <tiwai@suse.de> wrote:

> At Thu, 15 Jan 2004 15:23:06 +0100,
> Arve Knudsen wrote:
>>
>> Hi
>>
>> Like I explained in a post some time back, I've been having problems=20
>> with
>> not getting correct values from snd_pcm_hw_params functions=20
>> (specifically
>> snd_pcm_hw_params_get_channels_max). I never got an answer though, and=
=20
>> the
>> problem disappeared for a while. However it has reappeared, so I decid=
ed
>> to find the source (no pun intended) of the problem. It turns out for=20
>> some
>> reason the deprecated symbols are getting called (__OLD_GET), so when =
I
>> expect to have the passed value pointer filled in, all that happens is=
=20
>> it
>> gets zeroed. I'm afraid I don't understand all the preprocessor magic,=
=20
>> so
>> I don't completely understand why this happens. That is, the correct
>> versions of these functions have been called correctly, but suddenly t=
he
>> old ones are used instead.
>>
>> Maybe its down to some weird linking problem, it only happens with a
>> dynamically loaded PortAudio plugin I've written for an xmms fork call=
ed
>> beep-media-player. If anyone could come up with a likely explanation a=
s=20
>> to
>> what's going on here, I'd be grateful. Is there some mechanism that
>> figures my lib is linked against an old version of ALSA-lib? Btw, I'm
>> using ALSA-lib 1.0.1, and drivers compiled into 2.6.1-mm2.
>
> is libtool enough new?
> otherwise this kind of confusion can happen.
>
>
> Takashi
>
>
> -------------------------------------------------------
> The SF.Net email is sponsored by EclipseCon 2004
> Premiere Conference on Open Tools Development and Integration
> See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> http://www.eclipsecon.org/osdn
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
