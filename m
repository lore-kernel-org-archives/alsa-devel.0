From: "Edward Wildgoose" <ed@wildgooses.com>
Subject: Re: HDSP 9632 driver and expansion cards
Date: Sat, 24 Jan 2004 21:10:03 -0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <00c201c3e2be$708df140$0369a8c0@BigMotha>
References: <1074650862.6893.10.camel@rivendell.home.local> <400E74F6.1040803@undata.org> <02f701c3e04e$1f39d2e0$5d40a8c0@FRiskMan.com> <400EEDE9.80208@undata.org> <013301c3e0fc$f4ea92e0$5d40a8c0@FRiskMan.com> <4010F57E.7070207@undata.org> <01e001c3e1d4$a32393c0$5d40a8c0@FRiskMan.com> <40125C4E.80807@undata.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > Alsaplayer also works fine I think (on different files), as does aplay.  I
> > would be pretty sure that for a given FLAC file, alsaplayer would play it
> > fine and mplayer would stutter.
> >
> > I will try and grab the mplayer source and have a peer at the audio output
> > code.
> >
> >
>
> It sounds like an application design issue, then.

I have had a look at mplayers audio code.  I think I made some notes on a seperate email?  It looks fine actually, and it does seem
to be trying to set the buffer size to 1024 with 2 fragments.  This should sort out any latency problems I think.

Actually this system seems to work quite well with buffer sizes as low as 64 so I think it isn't latency issues with the system (at
least as far as the system being capable of running that fast, of course the app may not be written in a way that can feed that data
that quickly...)

It's interesting that it doesn't work under both OSS and Alsa with mplayer.

Obvious question really.  If you have your card in a machine, can you please try mplayer 1.00rc3 and see if it works for you, either
alsa or oss? (Or anyone else with one?)

The same setup works if I change nothing other than using either the RME 96/8 or the onboard intel8x0 card, so I don't think that
it's an app design issue, as such.  I suspect that the app might be doing something innocent which is perhaps even causing the
latency to be reset?  Sound plausible?

By the way, some other things which might be just my misunderstanding: "amixer cset numid=5" doesn't seem to do anything for me,
perhaps I have fumbled the syntax though?  Is it supposed to work?  Secondly, everytime I load hdspmixer it resets the card to
default settings.  Pressing the save button and saving to one of the card defaults doesn't seem to stay changed - should it do?
Perhaps I misunderstood how I should save changes to the mixer?


Thanks Thomas.  I think I'm slowly getting it all hooked up now.  Seems to be a very impressive card anyway.  Thanks again for your
work on the driver - much appreciated

Ed W



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
