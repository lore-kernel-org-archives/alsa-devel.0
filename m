From: Kevin Puetz <puetzk@iastate.edu>
Subject: Re: Re: Phase Reversal on Santa Cruz (cs46xx)
Date: Sun, 17 Nov 2002 22:41:14 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200211172241.14373.puetzk@iastate.edu>
References: <200211170056.11190.puetzk@iastate.edu> <200211171652.05776.puetzk@iastate.edu> <3DD87414.8060303@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DD87414.8060303@cucumelo.org>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sunday 17 November 2002 23:01, Benny Sjostrand wrote:
> >>So... anything that can be done to fix this (I assume so, since it's a
> >> new problem since older alsa), or do I have to cut my speaker wires
> >> apart? :-P
>
> I'm still a newbie to the audio world, but just wondering, why design a
> audio equipment
> that behaves like this ??
> (When you run out of ideas howto fix something let's try to move it into
> a HW bug instead -;) )

well, the basic premise is simple... the speaker wires have a positive and 
negative wire, current flows through the coil, and the cone moves one way or 
the other. If you swap the wires, the cone moves the other way. Inaudible, 
except that if the two speakers aren't moving the same way, they waves tend 
to cancel each other out. It affects bass more than treble because the waves 
are longer and slower, so a) they correleation between the stereo channels is 
stronger and b) inaccuracies in soundcard timing, etc have less impact. The 
fact that sound is sensitive to polarity is just basic physics :-)

Now, why in the world the santa cruz would be wired in such a way that 
software which is fine on other cards would get one channel backwards on it 
is an excellent question. Espescially when there is older software that 
worked on all (though not so well, I definitely like having multiple apps 
accessing it at once).

> >Still hopfully alsa gets fixed and I can throw away the effect plugin :-)
>
> One alternative solution would be program the DSP to do the job instead
> and you will
> save CPU time. (Yet another thing that I dont known howto do -:(  )

well, how did it work before (0.9.0rc1 worked for sure, I guess I should try 
to identify the specific version that developed this problem)? Were we using 
the DSP to invert it previosly, did we lose some Santa Cruz specific 
bittwiddling (the 'fix' consists of just negating all the levels for one 
stereo channel). Any guesses?

> /Benny
>
> PS. being out for traveling some days (wont respond any mail for a while
> ...)

Just as another question, do anyone know if it's possible to use the internal 
SPDIF connector to feed CD audio into the card instead of the analog input? I 
can't find anything in the mixer that seems to recieve that input.


-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
