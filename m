From: "John L. Utz III" <john.utz@dmx.com>
Subject: Re: FIXME for Rear Channels of CMI8738,
 how do i write a softvol to fix this defect?
Date: Wed, 9 May 2007 10:07:42 -0700
Message-ID: <20070509100742.12b5e965@jutz-fc6.na.corp.dmxmusic.com>
References: <20070507141018.7deae44f@jutz-fc6.na.corp.dmxmusic.com>
	<s5hwszi5eu3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id ABFE124485
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2007 19:05:44 +0200 (CEST)
In-Reply-To: <s5hwszi5eu3.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 09 May 2007 15:03:32 +0200
"Takashi Iwai" <tiwai@suse.de> wrote:

> At Mon, 7 May 2007 14:10:18 -0700,
> John L. Utz III wrote:
> > 
> > Hello;
> > 
> > the CMI8738 allows for 4 channel output by providing a second DAC,
> > but sadly the hardware has no volume control for said second DAC.
> > 
> > A review of /usr/share/alsa/cards/CMI8738-MC6.conf shows that the
> > implementor of said file was aware of the need to fix the problem:
> > 
> > # 2nd DAC
> > # FIXME: we need a volume attenuator for rear channel.
> > CMI8738-MC6.pcm.rear.0 {
> >         @args [ CARD ]
> >         @args.CARD {
> >                 type string
> >         }
> >         type hw
> >         card $CARD
> >         device 1
> > }
> > 
> > 
> > 
> > I'd really like to fix this!
> > 
> > Is it fixable by creating a softvol plugin?
> > 
> > http://www.alsa-project.org/alsa-doc/alsa-lib/pcm_plugins.html#pcm_plugins
> > 
> > so, if i have to invoke speaker test with -Dhw:0,1 to get 4 channel
> > out, what does that tell me about how i need to configure a softvol
> > for this item?
> > 
> > Or am i missing the point and it's actually the *driver* that needs
> > to be doctored up to provide a softvol implementation. If so, how?
> 
> For using the rear PCM defined in the above, you must use "rear" PCM
> as it's named, not hw:0,1, such as
> 	% aplay -Drear foo.wav

thankyou for pointing that out!

however, i wasnt planning on using -Drear, i included the snippet to
provide context concerning the fact that a set of folks larger than me
agree that the problem needs fixin! :-)

i need to have four channel output, thus my use of hw:0,1.

So, fixing rear volume via softvol or something else has to work in the
context of four channel output.

if there is a way to get 4 channel output (as defined as successful use
of 'speaker-test -t sin -c 4 -Dhw:0,1) *besides* using hw:0.1, i would
be interested to learn of it.

> The softvol implementation is easy.  See CMI8738-MC8.conf as a
> reference.  Note that you should use a different mixer name instead of
> "PCM Playback Volume".  If an existing control name is specified,
> softvol will be skipped automatically.  Use "Rear Playback Volume"
> instead, for example.

I will absolutely use Rear Playback Volume! :-)

> 
> Takashi
> 

tnx for your help!

johnu

(ps: it's so nice to be able to use a proper email client again! i am
really grateful that our windows centric admins where willing to make a
special exception and turn on IMAP for me!)
