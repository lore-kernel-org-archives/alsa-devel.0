From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re:
	=?iso-8859-1?q?I_want_to_improve_Sigma-Tel_STAC9227_?=
	=?iso-8859-1?q?driver_/_How_to=09implement_support_for_multiple_AD?=
	=?iso-8859-1?q?C?=
Date: Thu, 23 Aug 2007 17:09:04 +0300
Message-ID: <200708231709.04749.maximlevitsky@gmail.com>
References: <200708200448.52138.maximlevitsky@gmail.com>
	<s5h4piripvg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 43822103867
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Aug 2007 16:10:18 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id b21so371339nfd
	for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2007 07:10:17 -0700 (PDT)
In-Reply-To: <s5h4piripvg.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wednesday 22 August 2007 17:51:47 Takashi Iwai wrote:
> At Mon, 20 Aug 2007 04:48:52 +0300,
> Maxim Levitsky wrote:
> > 
> > Hello,
> > 
> > I am a user of Sigma-Tel STAC9227 intel hda based chip.
> > I have studied its documentation, and found that alsa driver doesn't support 
> > number of its features.
> > 
> > 
> > 1) it has "analog loop-back" which means it can mix sound just before it 
> > enters ADC0 to output of DAC0 (headphones/front).
> > For me it is the most important feature, since I have a tv card with analog 
> > output.
> 
> I couldn't find it in the datasheet...  Is it just a matter of amp or
> widget connection?

Well, I was looking for it for about a month :-)

Look at AGF node , DACMode verb (FEB/7EB), bit ADCMixDAC 

> 
> > 2) it has the ability to "swap" left/right channels, and this can be very 
> > useful for LFE/center channel
> 
> This would be relatively easy (if we really need).
> 
> > 3) It has a VolumeKnob "widget" , that allows to decrease volume of all DACs 
> > _after_ their own volumes were applied, and I think I turn it to "master 
> > volume"
> 
> The problem is how to know whether this widget is really used or not.
> (That is, whether the volume knob is implemented in this hardware)
> 
I tested it, and it works
> > Those things below aren't supported by windows driver ether, but that doesn't 
> > mean we can't support that :-)
> > 
> > 4) this chip has 3 ADC, each capable recording from different source, but alsa 
> > uses only first.
> 
> OK, that's a bug.
> 
> > 5) I have 5.1 configuration, so DAC1 is unused.
> > It is possible to connect it to "front" mic, and get 7.1 sound card
> > I think about a option "Use front mic as output", for 3Stack configuration
> 
> Hm, but still too tricky to set up in that way.
> You cannot imagine easily such a switch means 7.1 output.
Why, we already have Mic as output/Line-in as output,
so lets add Front mic as output (I already did that)
> 
> For other codecs, we have "Channel Mode" enum.  The pins are set up
> according to this value.  But, sigmatel code doesn't have this enum
> list but rather individual switches.  It's slightly confusing, I
> think.  From the easiness POV, I prefer the channel mode enum
> solution.
> 
> > 1,2,3 are easy to implement, since those are just mixer switches.
> 
> Not really.  patch_sigmatel.c is written to be as generic as
> possible.  Thus, if you add something special for a specific device,
> you should be careful not to break others.
I will read datasheets of all other Sigmatels that this driver support

as for  7.1 support I told, it shouldn't break anything:
the code checks only in case we have one output (line-out) for DAC connected to mic and line in, 
if it there it adds them to output pin list.
Only in that case I will also check if front mic is connected to a DAC, and if so, I will add it to output list too as a side channel
I already did that , and it work here.
> 
> > But I have a question about 4:
> > 
> > Now the driver has buggy support for second ADC, it record from it, but fails 
> > to connect it to any input source, and unmute it.
> > 
> > I can fix that and trivially add support for third ADC, but current driver 
> > makes all ADCs a sub-streams of a single  PCM device.
> > 
> > I think that sub-streams are meant to be used only by playback PCMs that have 
> > hardware support of mixing,
> 
> No, it's misunderstanding :)
Great, I already fixed support for all ADCs to be a substreams of single PCM
Just one question:

This chip has two-level gain on each adc,
first is a four step boost in 10 db values, and it is currently used in driver,
And a more fine tuned inPortnVol, that is currently unused.

I have three options:

1) use  inPortnVol for capture volume, and forget about that crude boost,
2) impement complex control that will emulate single volume, but will change both
3) impement two controls (the easiest thing)

What shall I do?

> 
> > so I feel that is is better  to make  each ADC to 
> > be a separate PCM device, with separate  mixer controls (enabled/input 
> > source/gain), and I want to ask you whenever you agree with me.
> 
> ... thus I disagree.  And, the mixer controls can be provided
> separately anyway (as other codecs already do).
> 
> > Also I noticed that dsnoop chokes on record streams with more that one 
> > substream, it fails with error, when I try to open second arecord.
> 
> Yes, and note that it's the intentional behavior.
> 
> The problem is _not_ that the secondary capture is assigned to the
> secondary substream.  As long as you use the default PCM, it'll be not
> accessed anyway.  The problem is rather that currently the overall
> design doesn't suit for the multi-stream environment.
> 
> We provide "default" PCM for the generic purpose.  That's fine.  It's
> a mighty ace that can be used for everything.  Now we have a second
> guy.  But we have no standard symbolic name for him.  It's possible to
> access via hw:0,0,1.  It's however ugly, cryptic and even bare.  We
> need to provide a more understandable symbolic PCM definition with the
> decoration of plugins.  This is what is missing so far.  Thus it's
> basically not a driver issue but an alsa-lib issue.
> 
> 
> thanks,
> 
> Takashi
> 


Hi,

	Thanks for reply, 
I already started doing the above things, it feels easy to me, soon I will send a patch series 
that fixed/add features that I told here about.

Best regards,
	Maxim levitsky
