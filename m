From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: CMedia 8738 - problems running Jack
Date: Mon, 24 Oct 2005 23:35:41 -0400
Message-ID: <1130211341.28314.28.camel@mindpipe>
References: <5bdc1c8b0510240924w10e1a8d1o499e3739fd8e1923@mail.gmail.com>
	 <5bdc1c8b0510240932o6566fef2q96f1f2a5a970b771@mail.gmail.com>
	 <20051024202157.GA11137@meep>
	 <5bdc1c8b0510241455s1aaf8940gc408902fe06af8f@mail.gmail.com>
	 <20051024223838.GA25313@meep> <1130193988.23853.69.camel@mindpipe>
	 <20051025002420.GB11137@meep>
	 <5bdc1c8b0510241909j6dc178e8xfaa33c0692bed907@mail.gmail.com>
	 <1130206459.28314.26.camel@mindpipe>
	 <5bdc1c8b0510241930l798609f1gb888dfc1afef6b4f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <5bdc1c8b0510241930l798609f1gb888dfc1afef6b4f@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@gmail.com>
Cc: Dave Cunningham <spark@xdev.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2005-10-24 at 19:30 -0700, Mark Knecht wrote:
> On 10/24/05, Lee Revell <rlrevell@joe-job.com> wrote:
> > On Mon, 2005-10-24 at 19:09 -0700, Mark Knecht wrote:
> > > Can someone check out and let me know how to run aplay to card #2?
> > >
> > > gigastudio ~ # cat /proc/asound/cards
> > > 0 [M2496          ]: ICE1712 - M Audio Audiophile 24/96
> > >                      M Audio Audiophile 24/96 at 0xa400, irq 10
> > > 1 [R15            ]: RME9636 - RME Digi9636 (Rev 1.5)
> > >                      RME Digi9636 (Rev 1.5) at 0xe2000000, irq 9
> > > 2 [CMI8738MC6     ]: CMI8738-MC6 - C-Media PCI CMI8738-MC6
> > >                      C-Media PCI CMI8738-MC6 (model 55) at 0xd800, irq 11
> >
> > aplay -D plughw:2,0 file.wav
> >
> > Lee
> 
> Thanks. I thought plughw went through some processing - for resampling
> or something. Is that not true? And if so, how do I go to the device
> directly? (aplay -D hw:2,0?)

It does.  I recommended hw:2,0 because most of the .wav files people
have sitting around are 44100 Hz, and some cheap onboard hardware can
only do 48000Hz.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
