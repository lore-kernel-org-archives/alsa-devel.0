From: "Martin Tufnel" <martin.tufnel@gmail.com>
Subject: Re: hdsp rpm support
Date: Mon, 26 May 2008 22:27:27 +1000
Message-ID: <c62722740805260527i9e612adr8d3bb029a6ea1e8e@mail.gmail.com>
References: <c62722740805260033t68f1ab1cu7ed5908f803fbacd@mail.gmail.com>
	<1211789980.5486.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.180])
	by alsa0.perex.cz (Postfix) with ESMTP id A93B4248D4
	for <alsa-devel@alsa-project.org>;
	Mon, 26 May 2008 14:27:30 +0200 (CEST)
Received: by py-out-1112.google.com with SMTP id a29so1247268pyi.36
	for <alsa-devel@alsa-project.org>; Mon, 26 May 2008 05:27:29 -0700 (PDT)
In-Reply-To: <1211789980.5486.8.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: reduzierer@yahoo.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Roman

Nice to hear from you.  I saw your other posts and had wondered if you had
chucked in the towel.  I would really like to see the RPM supported as it
suits my needs exactly.  I basically want to record (a mic-ed) electric
guitar and vocals and monitor it.  So, I need something with a mic preamp
and headphone amp.  I don't need something with 1024 channels (or whatever
they're up to now :) ).  However, I want something at professional quality.
The RPM seemed to fit the bill perfectly.  I was quite disappointed to see
it wasn't supported given that the other units that plug into exactly the
same board all were.  This seemed quite odd to me; however, it did give me
hope that the mods needed to the code wouldn't be that extensive.

Anyway, I emailed RME with some questions (because in the manual for the
product in chapter 7.5 it states that "Support for the RPM is expected
soon") and received the following reply:

*********************** start **********************

Hello,

> 1. Do you know if any particular person is currently developing a
> driver for the RPM?


No, sorry. In any case, there is no driver for the RPM as such, only for
the RME PCI or Cardbus card. Whether or not this driver supports the RPM
along with Multiface and Digiface is another question.

> 2. If so, do you have any idea what sort of time frame one could
> expect a driver to be released?


Sorry, no.

> 3. If not, would it be possible for you to release the necessary
> information in order for development work in continue for the RPM
> please?


I'm sure this information is available to ALSA.


Regards,
Daniel Fuchs
RME

*********************** end ***********************

So, I'm not sure where all this leaves us.  I guess if I knew that no-one
was working on it, I could either put up my hand to try to do the coding
myself, or give up on the unit altogether (but what would be a suitable
replacement though??).

Anyway, did you try the patch that Karl released in regards to the firmware
for the RPM by any chance?  I don't have any windows machines, so I can't do
what you do in regards to loading the firmware via Windows first.

Regards, Martin



On Mon, May 26, 2008 at 6:19 PM, Roman Haefeli <reduzierer@yahoo.de> wrote:

> hey martin
>
> after lurking around here for months, now we are already two. cool ;-) i
> know even more people with an rpm and linux. it would nice, if the rpm
> would be fully supported like the other cards from the hdsp series
> (although it's not too urgent for me, since i've managed to work with it
> for years by loading the firmware from ms-windows. yeah, it works, but
> it is definitely an ugly kludge)
>
> thank you, that you're bringing this topic up again. i would be grateful
> to contribute in any way, though i am afraid, that the only way i would
> be able to help would be testing.
>
> regards
> roman
>
>
>
> On Mon, 2008-05-26 at 17:33 +1000, Martin Tufnel wrote:
> > Hi All
> >
> > I was wondering if there is any more news in regard to the development
> > effort toward supporting the RME HDSP RPM?
> >
> > The last couple of emails I could find on the development were from
> > Karl Grill (please see below).
> >
> > Does anyone know if Karl (or anyone else) is still working on this?
> >
> > Thanks in advance for any help anyone can provide.
> >
> > Regards, Martin
> >
> >
> > On Mon, 2008-02-25 at 08:45 +0100, Karl Grill wrote:
> > >* Dear Roman and all,
> > *>* I'm sorry i promised a little too much - in fact I was too busy with
> > *>* other things to get back to the rpm stuff in time; last night, I
> started
> > *>* to check the current state of affairs, and it looks quite promising;
> in
> > *>* the next three weeks, I won't have too much time to devote to this
> > *>* project, but then there's the University's easter break which I hope
> > *>* will give me the time to get things done, so, if all goes well, at
> least
> > *>* an experimental version should be ready by the end of March.
> > *
> > *
> > *On Tue, 2008-02-26 at 21:58 +0100, Karl Grill wrote:
> > > *Hi all,
> > > as a first step towards implementing support for the hdsp rpm, I've
> > > uploaded a patch to the alsa-firmware branch as bug report #3810.
> > > Besides the patch, I've put up the firmware binaries in .tar.gz format.
> > > This contains replacements for the rev.11 firmware for the
> > > digiface/multiface and also for the rpm. The latter is of little use
> > > right now, but I'd be very happy if anybody could try those for the
> > > digiface/multiface and report if it works, so I know if my assumptions
> > > on the drivers are correct.
> > >
> > > best regards
> > > kg
> > >
> > > PS. sorry I didn't file this report in the firmware section, but the
> web
> > > form there doesn't give me any usable choice for Category yet insists
> > > that I supply one.
>
