From: Adam K Kirchhoff <adamk@voicenet.com>
Subject: Re: YMF754 with front & rear output?
Date: Wed, 20 Feb 2002 10:00:19 -0500 (EST)
Message-ID: <Pine.LNX.4.10.10202200951090.3803-100000@sorrow.ashke.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <s5hn0y4b44v.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On Wed, 20 Feb 2002, Takashi Iwai wrote:

> At Wed, 20 Feb 2002 08:50:23 -0500 (EST),
> Adam K Kirchhoff wrote:
> > 
> > 
> > On Wed, 20 Feb 2002, Takashi Iwai wrote:
> > 
> > > At Mon, 18 Feb 2002 22:45:07 EST (-0500),
> > > Adam K Kirchhoff wrote:
> > > > 
> > > > 
> > > > I'm curious if anyone has gotten one of the ymfpci cards to work with
> > > > 
> > > > front and rear output with the OSS emulation?  Is it even supported at
> > > > 
> > > > this point?
> > > 
> > > (please note i myself didn't test the following:)
> > > 
> > > the rear pcm assigned to device #2.  so at first please check whether
> > > the driver really supports rear speakers by playing via hw:0,2, i.e.
> > 
> > It does....  Alsa has natively supported both the front and rear channels
> > for a number of months now, iirc.
> > 
> > > 	% aplay -Dhw:0,2 foo.wav
> > 
> > Yep.  That works fine.
> > 
> > One of the first things I'm noticing now, however, is that the only Alsa
> > application that seems to use the rear speakers is aplay, and only when
> > specified.  For example, alsaplayer will still only use the front
> > speakers.
>  
> it's a problem of alsaplayer.  doesn't work "alsaplayer -d hw:0,2" ?

Good question...  That's something I haven't tried.  I'll give it a shot
when I get home.  

However, here's the thing...  alsaplayer uses both the front and rear
outputs with the SB Live! by default.  No need to specify one or the
other.

Now, I understand that since so many more people have SB Live! cards
driver development obviously isn't going to focus on the ymfpci cards as
much, but I'm curious if this is something that can eventually be enabled?
Is it an issue with the yamaha hardware?

> > Now, is this something that needs to be set up in the .asoundrc file?  Is
> > this documented somewhere?
> 
> no, you don't need to edit asoundrc.
> to the latter question - again - no.  no documents, so far.
>  
> > > if it's ok, please try to add the following option to snd-pcm-oss:
> > > 
> > > 	options snd-pcm-oss snd_adsp_map=2
> > > 
> > > so that hw:0,2 is mapped to /dev/adsp.
> > 
> > Done.  But what exactly does this give me :-)  I hate to seem like an
> > idiot, but my only other experience with the alsa drivers is with a SB
> > Live! With the SB Live!, you don't need to take any extra steps to get
> > both the front and rear channels working.  I certainly don't remember
> > having to setup anything for /dev/adsp :-)
>  
> hmm, i'm not sure whether sb live supports rear outputs on OSS
> emulation mode..  does it?

Yes.  Every OSS application I've come across (games, video players, audio
players, sound editing apps, etc.) is able to use the front and rear
outputs at the same time, with the Alsa SB Live drivers, without any extra
configuration :-)

> > I see a couple references to adsp in the alsa-howto, but nothing that
> > really explains how to set it up and use it :-)
>  
> well, this is also not documented.
> i'm going to write a brief note later.
> 
> 
> > > The another possibility is to use ALSA OSS wrapper library.
> > > You can define like this in your ~/.asoundrc
> > > 
> > > 	pcm.adsp0 pcm.rear
> > > 
> > > then run program via aoss wrapper.
> > 
> > Is this documented somewhere, too?  Searching for "aoss wrapper" in google
> > doesn't turn up anything, and the search mechanism on the Alsa homepage
> > seems to be broken (someone might want to remove it till it gets fixed)
> > :-) 
>  
> it's included in alsa-oss package.  aoss is a very small wrapper
> script.  there is a man page, so please refer to it.

Cool.  I'll take a look when I get home.

> and, i should answer before you ask; the usage of alsa-oss lib is also
> almost undocumented :-<

lol.  I wasn't going to ask...

I have no objection to working on any of this documentation but, of
course, I'd need to understand how these things work in the first place
:-)  I haven't taken a very close look, but is the source code documented
well enough to understand these issues?

Adam


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
