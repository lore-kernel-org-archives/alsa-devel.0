From: Florin Andrei <florin@andrei.myip.org>
Subject: Re: HDSP 9632 driver and expansion cards
Date: 22 Jan 2004 22:27:07 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1074839227.3202.36.camel@rivendell.home.local>
References: <1074650862.6893.10.camel@rivendell.home.local>
	 <400E74F6.1040803@undata.org> <02f701c3e04e$1f39d2e0$5d40a8c0@FRiskMan.com>
	 <1074711322.4129.4.camel@rivendell.home.local>
	 <012301c3e0f9$42e41bf0$5d40a8c0@FRiskMan.com>
Reply-To: alsa-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <012301c3e0f9$42e41bf0$5d40a8c0@FRiskMan.com>
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

On Thu, 2004-01-22 at 07:06, Ed Wildgoose wrote:
> > > > Florin Andrei wrote :
> > > > > Anyone using the latest RME HDSP 9632 driver in ALSA, while also
> using
> > > > > the expansion cards? I mean, the newer AI4S-192 and/or AO4S-192
> which
> > > > > are required to get the 192kHz sampling on all analogs.
> >
> > > I have a 9632 now and also the 4 port analogue expansion card.
> >
> > The new, 192kHz ones?
> 
> Hi, tested this very briefly last night (I only have enough plugs to wire up
> a single channel...), and got sound out of it!!  Wahey!
> Yes, it is the new 192Khz one, and the card has balanced, large 1/4" phono
> sockets out of the back (which is useful, yet inconvenient).

Balanced? Are you sure?
Wow! That's not specified on their website.
Very, very good news.

I was kinda feeling inclined to save a bucketful of bucks and get the
M-Audio 1010LT instead, which is supposed to be pretty good as well, but
now that you said the Hammerfall has balanced connectors... i don't care
about money anymore. :-)

> I would suggest that you could save money and stick with the 96khz 96/8PAD
> card unless you need some of the 9632 features

(see below)

> However, as a negative to the 9632 card, I find that I can't use it with
> many apps such as Mythtv, mplayer, etc.  The sound just stutters.  I suspect
> that the driver defaults to a short period size and some of these apps don't
> request anything other than the default?

Whoops, not good.
Which application does work for you?

The main reason why i'm planning to get the Hammerfall is to use it with
JACK and music apps. But of course i'd like to use it with XMMS, Xine,
etc as well.
So that's why what you noticed is kinda scary to me.

As for the 192-vs-96kHz thing...
I want to use the RME in a small music studio (hence the JACK thing).
Digital processing, if done entirely at 44.1 (for CD) or 48kHz (for DAT)
has an ugly "lifeless" flavour that's disliked by most musicians. One
way to work around it is to simply bump up the frequency of the entire
digital chain, to 88.2 or 96kHz. But i've heard recently about some
famous british composer who simply went all the way up to 176.4/192kHz,
with results that amazed even the dyed-in-the-wool analogue fans.
To get back to 44.1 before burning the master, you have to do an
interpolating downsample (do NOT simply discard 3 samples out of 4!); it
may seem counterintuitive, but apparently it sounds a lot better this
way than if you process all along at 44.1

So... balanced connectors + 192kHz = i want the RME

-- 
Florin Andrei

http://florin.myip.org/



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
