From: Gilles =?iso-8859-1?Q?PI=C9TRI?= <contact@gilouweb.com>
Subject: Re: hda-intel and Acer TravelMate 4062 LMi
Date: Fri, 3 Mar 2006 13:24:37 +0100 (CET)
Message-ID: <39815.81.250.186.122.1141388677.squirrel@mail.eclaireurs.org>
References: <1141047723.8504.4.camel@lepetit.gilouweb.com> from "Gilles   
    =?ISO-8859-1?Q?PI=C9TRI?=" at Feb 27, 2006 02:42:03 PM   
    <200602280132.k1S1WUNu021958@auster.physics.adelaide.edu.au>
    <43172.86.203.46.202.1141091943.squirrel@mail.eclaireurs.org>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43172.86.203.46.202.1141091943.squirrel@mail.eclaireurs.org>
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
Cc: Gilles =?iso-8859-1?Q?PI=C9TRI?= <contact@gilouweb.com>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org


Le Mar 28 f=E9vrier 2006 2:59, Gilles PI=C9TRI a =E9crit :
[snip]
> The subsystem ID is  1025:008f
>
> However, I must confess that I haven't checked that the labels of the
> mixer match perfectly the jack they indicate, being too happy to have
> sound while playing (almost) randomly with the mixer. I'll do that when=
 I
> have some time !
>
>> Note that the patch as ultimately submitted to alsa (as part of a
>> 7-patch
>> series earlier today) has evolved slightly since the one posted to bug
>> report 1618.  Once the latest ALC260 patches have been merged to CVS i=
t
>> would be good if you could test the result to make sure nothing's been
>> broken for you in the transition.
>>
>
> OK, then I'll probably use the CVS version to make my label tests once =
the
> CVS is up to date, and I'll tell you about it.
>

Hi again !
I've updated to CVS, and I think I lost a few things :
Using switches on the previous "test" version, I could switch the line on=
,
and the speakers/headphone off (I don't remember how, but I could), I
can't do that anymore.
I also have a problem with the CD, but I'm not sure it's alsa related :
xmms plays CD silently (no output at all, does not show any sound activit=
y
while playing), whereas VLC can play CDs fine, but I think it does not us=
e
ALSA (though configured to output on ALSA), because the CD switch has no
effect on it.

I'm unable to control the line output, the "Line" control does nothing fo=
r
the output (it does on input, so maybe it's intended for input only ?). I
don't remember being able to control the line output though, so maybe am =
I
dreaming ;)

Regards,
Gilou



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
