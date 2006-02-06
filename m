From: Rimas Kudelis <rq@akl.lt>
Subject: Re: Intel HDA and Realtek ALC 260
Date: Mon, 06 Feb 2006 07:42:09 +0200
Message-ID: <43E6E1B1.3000405@akl.lt>
References: <200602060229.k162THBb025229@auster.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8B15599E7ED13B4B742CB7DB"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200602060229.k162THBb025229@auster.physics.adelaide.edu.au>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8B15599E7ED13B4B742CB7DB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello Jonathan,

>>I'm one of the people affected by
>>https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1618. ... So I have
>>a question for the maintainer of that module (I guess that's jwoithe)
>>    
>>
>Not to my knowledge - I've just provided the Fujitsu model and some other
>more general patches to patch-realtek.c because I have a laptop with the
>ALC260 in it and want it to work. :) Takashi would be the official
>maintainer of this file AFAIK.
>  
>
Ah, I see.

>>would it be possible to add a "test" model, like in case of ALC880, which
>>would have controls for all of the chipset pins available? I guess that
>>would simplify things a lot...
>>    
>>
>I think that's possibly worth considering.  I'll have a look into this
>tonight and see how much extra code it would add.  Since most of the
>infrastructure is already present I suspect it won't be too bad.  Such a
>feature would allow people to test new computers without having to patch
>anything and as such would probably be quite useful, as you suggest.
>

Thank you. Also, it would be useful for this model to add mixer controls
for retasking pins, as you did with Fujitsu model. That would hopefully
allow to quickly test what pins are connected to what jacks/hardware
(i.e., one could connect external speakers/headphones to all sound jacks
first). And the naming of controls - I suppose these should either be
named the way Paulo has named them (0x08 Volume, for example), or
similar to what they are marked in Realtek datasheet. That would make
things even easier for you developers to add new models based on user input.

BTW the notebook i'm having this problem with is an Acer Travelmate 4060
series, like Paulo's (but 4061 in my case), so I could help you
test/debug the Acer model specifics. Don't hesitate to contact me
regarding this.

Hope to hear from you soon.

Rimas


--------------enig8B15599E7ED13B4B742CB7DB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFD5uG1AlYAh8azrv8RAvBEAJsHReYnmR4giQ/Bw1OStG2slvTCKgCfT3bF
dMIaNFUW9m2Jvqm5Uklbpd0=
=+7Dw
-----END PGP SIGNATURE-----

--------------enig8B15599E7ED13B4B742CB7DB--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
