From: Rimas Kudelis <rimas.kudelis@cr.vu.lt>
Subject: Re: hda-intel and Acer TravelMate 4062 LMi
Date: Fri, 03 Mar 2006 14:52:06 +0200
Message-ID: <44083BF6.50205@cr.vu.lt>
References: <1141047723.8504.4.camel@lepetit.gilouweb.com> from "Gilles       PIÉTRI" at Feb 27, 2006 02:42:03 PM       <200602280132.k1S1WUNu021958@auster.physics.adelaide.edu.au>    <43172.86.203.46.202.1141091943.squirrel@mail.eclaireurs.org> <39815.81.250.186.122.1141388677.squirrel@mail.eclaireurs.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060508060705080404070605"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <39815.81.250.186.122.1141388677.squirrel@mail.eclaireurs.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?ISO-8859-1?Q?Gilles_PI=C9TRI?= <contact@gilouweb.com>
Cc: alsa-devel@lists.sourceforge.net, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Rimas Kudelis <rq@akl.lt>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060508060705080404070605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello, Gilles,

>> The subsystem ID is  1025:008f
>>     
> I've updated to CVS, and I think I lost a few things :
> Using switches on the previous "test" version, I could switch the line on,
> and the speakers/headphone off (I don't remember how, but I could), I
> can't do that anymore.
>   
Do you still load the module with "model=test" option? If you do, I 
don't quite understand the problems but well, nevermind. Try loading it 
with a "model=acer" option. You should get much less controls - just 
those that work (or should work) on an Acer notebook. Set the "Line 
jack" control to Line In, and the "Mic jack" control to Mic 50pc. Unmute 
and increase volume in all channels. Try playing some audio file then. 
If you hear it (the sound should now be redirected to the internal 
speakers or the headphone jack, if there's anything plugged in). If it 
works, try loading the module without any parameters and see if your 
notebook is autodetected, as it should be.


> I also have a problem with the CD, but I'm not sure it's alsa related :
> xmms plays CD silently (no output at all, does not show any sound activity
> while playing), whereas VLC can play CDs fine, but I think it does not use
> ALSA (though configured to output on ALSA), because the CD switch has no
> effect on it.
>   
This Audio CD problem has been discussed on the list. I have a suspicion 
that maybe Acers are expecting your software to do Audio CD decoding (as 
opposed to the CD drive itself). If you load the module with 
"model=acer" parameter, you'll see the CD volume control in the mixer. 
Be aware that it does NOT affect CD playback volume (yet?), so don't get 
stressed about it. ;)

> I'm unable to control the line output, the "Line" control does nothing for
> the output (it does on input, so maybe it's intended for input only ?).
Yes. All volume switches only affect how a certain channel is 
preamplified before going to the mixer, not after leaving it. Master 
(output) volume can only be controlled by LOUT1 and LOUT2 (where 
applicable) controls. In "acer" model, LOUT1 is called "Master".

> I don't remember being able to control the line output though, so maybe am I
> dreaming ;)
Probably...

One last thing (just not to miss a silly thing): if you edited the 
patch_realtek.c previously, you should rename/delete, and then retrieve 
a fresh copy of it from the CVS, because simple "cvs update" won't 
retrieve it for you if you have edited it before.

best regards,
RQ


--------------060508060705080404070605
Content-Type: text/x-vcard; charset=utf-8;
 name="rimas.kudelis.vcf"
Content-Disposition: attachment;
 filename="rimas.kudelis.vcf"
Content-Transfer-Encoding: 7bit

begin:vcard
fn:Rimas Kudelis
n:Kudelis;Rimas
org:Vilniaus universitetas
adr:;;Universiteto g. 3;Vilnius;;LT-01513;Lietuva
email;internet:rimas.kudelis@cr.vu.lt
title;quoted-printable:Interneto svetain=C4=97s administratorius
tel;work:(8~5)2687001
tel;fax:(8~5)2687096
tel;cell:(8~672)96017
url:http://www.vu.lt/
version:2.1
end:vcard


--------------060508060705080404070605--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
