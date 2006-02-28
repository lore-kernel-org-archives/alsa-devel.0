From: Gilles =?iso-8859-1?Q?PI=C9TRI?= <contact@gilouweb.com>
Subject: Re: hda-intel and Acer TravelMate 4062 LMi
Date: Tue, 28 Feb 2006 03:27:16 +0100 (CET)
Message-ID: <39973.86.203.46.202.1141093636.squirrel@mail.eclaireurs.org>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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
List-Id: alsa-devel@alsa-project.org

Le Mar 28 f=E9vrier 2006 2:32, Jonathan Woithe a =E9crit :
> Hi Gilou
>
>> > Over the weekend there have been major developments in this regard, =
to
>> the
>> > point that at least some Acers can make noise from the internal
>> speaker and
>> > the headphone jack.  I am preparing a series of ALC260 consolidation
>> patches
>> > now which will include the initial implementation of an "acer" model=
.
>> This
>> > should be posted tomorrow.  It would be good if you could test these
>> patches
>> > with your Acer and let us know how it goes.
>> >
>> > If it *does* help, it would be good to know the make/model of your
>> laptop
>> > and the PCI IDs of your laptop's sound system.  The latter are
>> reported via
>> > lspci. Refer to a post against bug 1618 by me earlier today for the
>> full
>> > details on getting these numbers.
>>
>> Hi, and thanks for your answer !
>>
>> I followed Rimas Kudelis' advice, and I applied the patch on the bug
report about the ALC260, and it just works smoothly.
>
> That's good to know.  If you can get us the subsystem IDs from your
laptop as described by myself in a post under bug 1618 that would be
good.

The subsystem ID is  1025:008f

However, I must confess that I haven't checked that the labels of the
mixer match perfectly the jack they indicate, being too happy to have
sound while playing (almost) randomly with the mixer. I'll do that when I
have some time !

> Note that the patch as ultimately submitted to alsa (as part of a
7-patch series earlier today) has evolved slightly since the one posted
to bug report 1618.  Once the latest ALC260 patches have been merged to
CVS it would be good if you could test the result to make sure nothing's
been broken for you in the transition.
>

OK, then I'll probably use the CVS version to make my label tests once th=
e
CVS is up to date, and I'll tell you about it.

Gilou



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
