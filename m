From: Nikhil Deo <nikhil_deo@usa.net>
Subject: Re: [Re: Configuring the mixer]
Date: Thu, 22 Apr 2004 18:37:31 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <973iDVwlf6624S07.1082673451@cmsweb07.cms.usa.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

no, Alsa is not on qnx, but I would like to know if you had to do this us=
ing
ALSA how would you do it. Not the exact function calls, but just the gene=
ral
idea, i will then try to put it in use in qnx world. =


To quote from the qnx audio developers guide:
 =

"This whole system is referred to as the QNX Sound Architecture (QSA). QS=
A has
a rich heritage and owes a large part of its design to version 0.5.2 of t=
he
Advanced Linux Sound Architecture (ALSA), but as both systems continued t=
o
develop and expand, direct compatibility between the two was lost. " =


A look at
http://www.qnx.com/developers/docs/momentics621_docs/neutrino/audio/summa=
ry.html
might explain why I am saying it is quite similar. =


If this is very much off-topic, I will understand. But in that case forge=
t
that I said QNX and replace it by ALSA. :)

Thanks for your time and the reply.

cheers!



Me Eby <meeby@yahoo.com> wrote:

> I was not aware that ALSA was available on QNX.  QNX
> is not Linux.  Good luck with QNX support for
> anyithing.  We dropped them like a hot potatoe years
> ago.
> =

> If ALSA is on QNX, you need to tell us what
> applications your are using.
> =

> Markeby
> =

> =

> --- Nikhil Deo <nikhil_deo@usa.net> wrote:
> > Ok. This is my first attempt at configuring the
> > mixer to get something done.
> > My two problems are: It is to be done on QNX and
> > nobody seems to be listening
> > on the QNX ngs. Since the concepts seem to be the
> > same, I am hoping someone
> > here would be able to point me in the right
> > direction. =

> > =

> > What I want to do:
> > =

> > I need to capture input from the mic AND the line
> > in. Then I need to output
> > the mic input on the Right-LineOut and leftLineIn on
> > leftLineOut. (right line
> > in can be ignored)
> > =

> > I have been playing with the samples on the qnx site
> > and was able to do the
> > follwing:
> > =

> > 1. Play a wav file on the line-out
> > 2. running the code for wave record =

> > =

> > =

> > in 1, I understood the concept of mixer group, found
> > out that the best group
> > for me was the PCM-Playback and then could modify
> > the mute bits to mute the
> > left and right channels simultaneously.  The
> > JOINT_MUTE in caps was set and so
> > I believe I cannot mute the left and right (front)
> > separately ( I tried
> > changing it, could change the bit in caps but still
> > could not mute the
> > channels separately)
> > =

> > in 2, my mixer group was input gain and although it
> > seemed to be recording
> > something, I could not figure out what it was. How
> > do I make it take the input
> > from  mic in only? =

> > =

> > So I would really appreciate if anyone can give me a
> > brief strategy on how to
> > proceed. =

> > =

> > I might ask more questions and will be glad to
> > clarify anything that is not
> > clear in this post. =

> > =

> > =

> > Thanks a lot for your time. I am beginning to creep
> > into frustration mode.
> > Answers need not be qnx specific, I have a feeling
> > that I will be able to
> > apply the logic. Also, pointers to any documentation
> > on the web for a beginner
> > like me are also welcome. =

> > =

> > =

> > =

> > =

> > =

> > =

> >
> -------------------------------------------------------
> > This SF.net email is sponsored by: The Robotic
> > Monkeys at ThinkGeek
> > For a limited time only, get FREE Ground shipping on
> > all orders of $35
> > or more. Hurry up and shop folks, this offer expires
> > April 30th!
> > http://www.thinkgeek.com/freeshipping/?cpg=12297
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@lists.sourceforge.net
> >
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> =

> =

> =

> 	=

> 		=

> __________________________________
> Do you Yahoo!?
> Yahoo! Photos: High-quality 4x6 digital prints for 25=A2
> http://photos.yahoo.com/ph/print_splash
> =

> =

> -------------------------------------------------------
> This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
> For a limited time only, get FREE Ground shipping on all orders of $35
> or more. Hurry up and shop folks, this offer expires April 30th!
> http://www.thinkgeek.com/freeshipping/?cpg=3D12297
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> =






-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
