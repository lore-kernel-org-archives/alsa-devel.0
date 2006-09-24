From: Sergei Steshenko <steshenko_sergei@list.ru>
Subject: Re: USB card @48kHz only: at what layer to resample?
Date: Sun, 24 Sep 2006 18:28:25 +0300
Message-ID: <20060924182825.2230a6bf@comp.home.net>
References: <J63PIH$040EF5CF6AFFDBCB31B65DEC3272A191@libero.it>
	<Pine.LNX.4.61.0609240755230.27883@info.physics.ubc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0609240755230.27883@info.physics.ubc.ca>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Bill Unruh <unruh@physics.ubc.ca>
Cc: alsa-user <alsa-user@lists.sourceforge.net>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 24 Sep 2006 08:12:09 -0700 (PDT)
Bill Unruh <unruh@physics.ubc.ca> wrote:

> On Sun, 24 Sep 2006, enrico_groups@libero.it wrote:
> 
> > Dear All,
> >
> > Apologies in advance if I am asking a stupid question, I am quite new with alsa.  I posting to both lists because I am not sure about handling this issue at the application development level or at the alsa driver configuration level.
> >
> > I am developing an audio application using the CCRMA synthesis tool-kit (STK) in Fedora Core4 using alsa.  I recently bought a Terratec Aureon 5.1 USB MKII card, because I needed to have better sound quality than what offered by my laptop.
> >
> > My understanding is that the usb card only works at 48kHz -- is this correct?
> > I manage to get aplay to work using the following plugin in /etc/asound.conf
> > pcm.!default {
> >    type plug
> >    slave {
> >        pcm "hw:2,0"
> >        rate 48000
> >    }
> > }
> >
> > However, in SKT I can enumerate the audio cards on my machine, but this does not give me alsa plugins, only the audio cards.  If I try to open the Aureon at 44.1kHz, I get an error saying rate not supported.
> >
> > Is there any way to have alsa handle the rate conversion for me?  Shouldn't or couldn't the driver take care of this?  (Was it my mistake in installing the driver? I can post my /etc/modprobe.conf if it helps)
> > Or is there any way to get STK to see the plugin?
> 
> This is audio card insanity. All CDs are at 44100 but for some reason many
> card manufacturers designed their cards to run at 48000. This is a real
> problem since this requires rate conversion. Rate conversion is in general
> a very very noisy operation. In particular simple linear interpolation,
> which is quick, is also really really terrible for sound quality.
> 
> If you want to see some tests using the sox rate conversion facilities, see
> www.theory.physics.ubc.ca/soundcard/resample.html
> 
> Ie, you would be far far better off, rather than using an alsa rate
> conversion, to use say sox to do the rate conversion for you  (using either
> resample or polyphase) and then play that through your 48000 card. Ie, why
> in the world would you buy a really good sound card and then feed it crap.
>   As far as I know, the alsa conversion facilities are still primative
> although discussions are there to improve it. 
> (I suspect the rate conversion in Windows is also crap, but do not know.)
> 
> 
> See the discussion in
> http://www.hydrogenaudio.org/forums/index.php?showtopic=47591
> The problem with using good samplerate conversion is that it is expensive
> in processor time.
> 
> 
> 
> >
> > Thank you in advance,
> > Enrico
> >
> >
> >
> >
> >
> > -------------------------------------------------------------------------
> > Take Surveys. Earn Cash. Influence the Future of IT
> > Join SourceForge.net's Techsay panel and you'll get the chance to share your
> > opinions on IT & business topics through brief surveys -- and earn cash
> > http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> > _______________________________________________
> > Alsa-user mailing list
> > Alsa-user@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/alsa-user
> >
> 

Takashi Iwai meant to include quality resampler into ALSA - I do not know
what the status is.

A LADSPA plugin can be created for the purpose.

Anyway, there are good quality resamplers, and they consume less than 5% CPU
even on old CPUs.

--Sergei.

-- 
Visit my http://appsfromscratch.berlios.de/ open source project.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
