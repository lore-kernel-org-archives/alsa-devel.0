From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: ice1712 overwrite standard midi port names
Date: Thu, 13 Apr 2006 13:24:57 +0100
Message-ID: <200604131324.57651.gineera@aspect135.co.uk>
References: <200604012206.27893.gineera@aspect135.co.uk> <200604121048.23790.gineera@aspect135.co.uk> <s5hk69v6o4y.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hk69v6o4y.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wednesday 12 April 2006 12:15, you wrote:
> At Wed, 12 Apr 2006 10:48:23 +0100,
>
> Alan Horstmann wrote:
> > [1  <text/plain; iso-8859-1 (7bit)>]
> >
> > On Tuesday 04 April 2006 16:26, you wrote:
> > > At Mon, 3 Apr 2006 22:45:58 +0100,
> > >
> > > Alan Horstmann wrote:
> > > > On Monday 03 April 2006 17:47, you wrote:
> > > > > At Sat, 1 Apr 2006 22:06:27 +0100,
> > > > >
> > > > > Alan Horstmann wrote:
> > > > > > Following our discussions I had time to prepare this patch for
> > > > > > ice1712 driver. I figured you prefered the minimum changes to
> > > > > > achieve the end result.  The replacement names in ews.c are left
> > > > > > as I prefer, 'detail, card', but if you choose, just reverse the
> > > > > > order, to comply instead with convention.  How does this proposal
> > > > > > look?
> > > > >
> > > > > I don't think -0 and -1 suffix are necessary.  You give the
> > > > > individual name for each device, so they must be unique as they
> > > > > are.
> > > >
> > > > True, however I included them for the following reasons:-
> > > >   a)  The default name in mpu401...new has the 2 numbers with a
> > > > hyphen, so there is consistency making it clearer what they refer to.
> > > > b)  If only a single number were used, there would need to be some
> > > > extra characters to say that it refered to the card number, not
> > > > device, eg c-1 or card-1.
> > >
> > > There wasn't any assumption about the card/device number appearing in
> > > the name, and there won't.  The rule is simple: the name should be
> > > unique.  The current name is generated just to achieve it easily.
> > >
> > > >   c)  It records somewhere to users (not reading the source-code)
> > > > which device is connected to each of the name strings.
> > >
> > > For users, basically it doesn't matter which device has the device
> > > number 0 or 1.  User needs to know only what these devices are.
> > >
> > > >   d)  There seemed to be no overriding reason to leave them out.
> > >
> > > Ugliness.
> > >
> > > > > - Fix spaces / indentation
> > > >
> > > > Can you be more specific?  Do you mean second half of sprintf
> > > > brackets? I can only see one unneccesary blank line.  From the patch
> > > > lines it is probably not obvious that the second port lines are
> > > > indented further due to an extra 'if' statement.
> > >
> > > The indent level isn't aligned properly.  Not a big issue, I can
> > > adjust it by myself before merging.
> >
> > Revised patch is attached which I think is as requested.
> >
> > Alan
> >
> > ice1712-add-pref-midi-names-2.patch
> >
> > Summary: Provides specified midi port names instead of defaults
> >
> > Patch provides for the ice1712 card driver to overwrite the midi port
> > name string given by default in mpu401_uart, with one specified in
> > snd_ice1712_card_info.
> >
> > Signed-off-by: Alan Horstmann <gineera@aspect135.co.uk>
>
> The patch looks fine.
>
> I'll apply it after releasing 1.0.11-final (which should appear soon)
> since we want only real "fixes" to be merged right now.

Actually I meant to ask whether you wanted to add a 'c' in front of 
card->number to make eg 'c0' or 'c1',or just leave the digit solitary?

Alan



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
