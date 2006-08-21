From: "Marc Brooker" <marcbrooker@gmail.com>
Subject: Re: Sample Rate Conversion Quality in ALSA
Date: Mon, 21 Aug 2006 17:05:04 +0200
Message-ID: <b5ee41f40608210805i1a4ba369sd4a3eb0d2b49176@mail.gmail.com>
References: <b5ee41f40608210316t562c803eye73701c75904627@mail.gmail.com>
	<44E9AAFA.2060400@superbug.co.uk> <s5hy7tiqmf7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hy7tiqmf7.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 8/21/06, Takashi Iwai <tiwai@suse.de> wrote:
> At Mon, 21 Aug 2006 13:45:46 +0100,
> James Courtier-Dutton wrote:
> >
> > Marc Brooker wrote:
> > > Hello,
> > >
> > > I am new to the ALSA development, and would be interested in
> > > contributing in future.
> > >
> > > After installing the latest Ubuntu on my home machine, I noticed that
> > > dmix is enabled by default. This is a very good move in my opinion, as
> > > it makes Linux sound much more transparent to the end user. However, I
> > > was concerned with the quality of the mixing algorithm and sample rate
> > > conversion used by dmix.
> > >
> > >
> > > Cheers
> > >
> > > Marc Brooker
> > >
> > The problem is actually far more complicated than you described. A fair
> > amount of ALSA core will have to be modified to really fix the problem.
> > The main problem is the buffer and period sized as they pass through dmix.
> > For example, if the sound card hardware is running with 1024 samples per
> > period at 48000, and an application wished to use a sample rate of
> > 44100, the application should really get 940.8 samples per period. That
> > is nor possible, so the application gets 940. dmix then tries to convert
> > 940 samples to 1024 samples ready for the hardware. So, even if the dmix
> > algorithm used the super high quality sample rate conversion function,
> > the actual rate change applied would still be slightly off.
>
> Well, the problem raised in the original post is rather the usability
> issue.  As mentioned there, the quality issue can be solved by using
> rate plugin in alsa-plugins package.  The question is how easily one
> can set it up.
>
> IMO, it's just a problem of lack of (so-called user-friendly)
> configuration tool.
>
>
> Takashi
>

Takashi,

You are right that the original problem is a usability one. The reason
I posted it here (instead of on the -users list) is that, in my
opinion, the current behaviour of alsa is not optimal for desktop
machines. While the extreme quality-speed tradeoff that alsa takes
would make sense on low-power desktops and embedded systems, in my
opinion a higher quality default would be better on desktops. That's
only my opinion, though, and it's clear the original developer had a
different (and possibly more valid) one.

In terms of a terse bug report, I would write "Dmix sound quality is
poor" rather than "Configuration of sample rate plugin is difficult".

There are, it seems to me, two ways to fix this for desktop users. The
first is to change the defaults to use the rate plugin. This would
also involve convincing distros to include this plugin in their
packages (which Debian and Ubuntu don't do by default, at the moment).
Another solution would be to change the alsa-lib code to a better
algorithm. This would probably involve either linking against
libsamplerate, so it isn't optimal either.

On a side note: A while ago I started writing a graphical setup
utility for .asoundrc (see www.sourceforge.net/projects/kasound) which
supported many of alsa's features and made them easier to set up. It's
less useful for the majority of people now that alsa uses dmix by
default.

Regards, and thanks for your responses

Marc Brooker

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
