From: Gilles =?iso-8859-1?Q?PI=C9TRI?= <contact@gilouweb.com>
Subject: Re: hda-intel and Acer TravelMate 4062 LMi
Date: Fri, 3 Mar 2006 15:19:22 +0100 (CET)
Message-ID: <51402.81.250.186.122.1141395562.squirrel@mail.eclaireurs.org>
References: <1141047723.8504.4.camel@lepetit.gilouweb.com> from "Gilles      
    PIÉTRI" at Feb 27, 2006 02:42:03 PM      
    <200602280132.k1S1WUNu021958@auster.physics.adelaide.edu.au>   
    <43172.86.203.46.202.1141091943.squirrel@mail.eclaireurs.org>
    <39815.81.250.186.122.1141388677.squirrel@mail.eclaireurs.org>
    <44083BF6.50205@cr.vu.lt>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <44083BF6.50205@cr.vu.lt>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rimas Kudelis <rimas.kudelis@cr.vu.lt>
Cc: Gilles =?iso-8859-1?Q?PI=C9TRI?= <contact@gilouweb.com>, alsa-devel@lists.sourceforge.net, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Rimas Kudelis <rq@akl.lt>
List-Id: alsa-devel@alsa-project.org


Le Ven 3 mars 2006 13:52, Rimas Kudelis a =E9crit :
> Hello, Gilles,
>
>>> The subsystem ID is  1025:008f
>>>
>> I've updated to CVS, and I think I lost a few things :
>> Using switches on the previous "test" version, I could switch the line
>> on,
>> and the speakers/headphone off (I don't remember how, but I could), I
>> can't do that anymore.
>>
> Do you still load the module with "model=3Dtest" option? If you do, I
> don't quite understand the problems but well, nevermind. Try loading it
> with a "model=3Dacer" option. You should get much less controls - just
> those that work (or should work) on an Acer notebook. Set the "Line
> jack" control to Line In, and the "Mic jack" control to Mic 50pc. Unmut=
e
> and increase volume in all channels. Try playing some audio file then.
> If you hear it (the sound should now be redirected to the internal
> speakers or the headphone jack, if there's anything plugged in). If it
> works, try loading the module without any parameters and see if your
> notebook is autodetected, as it should be.

Well I may have been not clear enough, sorry.
When I used the model=3Dtest thing, on the previous version with the old
patch, I had a lot of controls I could play with, lot of them inactive or
weird, and one thing I managed to do was to enable the line out, while
disabling the internal speakers / headphone. Now with the new version, I
can't do that anymore. So maybe something was disabled and could still
bring a "feature". This is not THE important thing, but it could be nice
to have it if it's possible.
My notebook is autodected or so do I think, how can I be sure ? (it
ignores the model=3Dxxx things, and dmesg does not tell me about the mode=
l
the module uses, though I remember seeing this info..

>
>
>> I also have a problem with the CD, but I'm not sure it's alsa related =
:
>> xmms plays CD silently (no output at all, does not show any sound
>> activity
>> while playing), whereas VLC can play CDs fine, but I think it does not
>> use
>> ALSA (though configured to output on ALSA), because the CD switch has =
no
>> effect on it.
>>
> This Audio CD problem has been discussed on the list. I have a suspicio=
n
> that maybe Acers are expecting your software to do Audio CD decoding (a=
s
> opposed to the CD drive itself). If you load the module with
> "model=3Dacer" parameter, you'll see the CD volume control in the mixer=
.
> Be aware that it does NOT affect CD playback volume (yet?), so don't ge=
t
> stressed about it. ;)

OK, not a big deal though, I don't have that much CDs to play ;)

[snip]
> One last thing (just not to miss a silly thing): if you edited the
> patch_realtek.c previously, you should rename/delete, and then retrieve
> a fresh copy of it from the CVS, because simple "cvs update" won't
> retrieve it for you if you have edited it before.
>

No problem, it was in another directory, and the patch was properly
updated ;)

Gilou



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
