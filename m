From: joy ping <joy@pingfm.org>
Subject: Re: Requesting guidance
Date: Tue, 16 Apr 2002 17:14:21 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.40.0204161653050.14889-100000@ping01.stura.uni-weimar.de>
References: <F38tK01svuQRg5YbhEH00010225@hotmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <F38tK01svuQRg5YbhEH00010225@hotmail.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: cjs 2895 <cjs2895@hotmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hi,

as i looked trough the code of my ens1371 driver, a few weeks ago, i
recognized that it would be possible to have a real 4-speaker enviroment.
as the ens1371 have 2 DAC's its not difficult to make this happen, and i
know that it works with win$. it works that way that the line-out will be
switched as a second line-out. the ens1370-driver has such kind of switch,
probably you have to buy a soundcard with a ens1370 chip. i would
implement such kind of switch to the ens1371-driver too, but dont know
which bit has to be set. i didn't asked creative till now, cause i think
they want that i subscribe a non-disclosure-agreement, and this wont help
to our project. maybe it could be found out with some kind of
reingeneering.
but anyway, for your project i think you didnt have to do much coding for
routing 4 mono-channels to 4 physical channels, it could be solved with
the runtime-configuring-options of alsa, the only thing your app has to do
then, to write to the right 'logical' PCM's. this could be done with every
multi-channel soundcard.

____
joy

On Mon, 15 Apr 2002, cjs 2895 wrote:

> Howdy folks,
>
> I've got an idea for a game I'd like to build for my kids. To make it work
> like I want I need to have four mono sound channels feeding into four
> physical speakers. To make that work it looks like my options are:
>   1) Use four separate sound cards (PCI or USB)
>   2) Do some coding to use each channel in a sound card to drive a
>      separate speaker.
> I like option two the best because its cost effective, and I think the newer
> Sound Blaster cards will drive four speakers (even if not, two cards is
> better then four). Unfortunately I don't
> think Linux's OSS can handle either of these options so now I'm looking to
> Alsa as a solution. From reading the Alsa manual it looks like I can do what
> I want by interleaving the sound buffers in one memory space. Is that the
> best approach? Its been a week since I read the manual, so I don't recall if
> I can do something like a select() loop to feed data to the sound cards as
> needed, but I'm thinking that would be easier if the method is available.
> Can anyone give me some guidance on how to proceed? I would appreciate it.
> Also, I haven't bought any sound cards yet, so if there is another make that
> might be better suited for this application (and is also cheap) please clue
> me in.
>
> Thanks,
> Christopher
>
>
>
> _________________________________________________________________
> MSN Photos is the easiest way to share and print your photos:
> http://photos.msn.com/support/worldwide.aspx
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>
