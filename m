From: Jiang zhe <zhe.jiang@intel.com>
Subject: Re: intel-hd on an intel G33 motherboard
Date: Wed, 16 Jan 2008 13:49:43 +0800
Message-ID: <1200462584.27102.9.camel@localhost.localdomain>
References: <BAY109-W349DC1598B9440E7A647CEA9470@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C6F92441E
	for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2008 06:48:45 +0100 (CET)
In-Reply-To: <BAY109-W349DC1598B9440E7A647CEA9470@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: De Fuuss <fuuss@hotmail.com>
Cc: Claudio Matsuoka <cmatsuoka@gmail.com>, ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2008-01-16 at 02:22 +0800, De Fuuss wrote:
> 
> Hi,
> 
> I have recompiled the driver with --with-debug=detect. Dmesg output is
> attached to this mail. ALSA specificities seem to be present this
> time.
Hi,

>From the dmesg, there is "hda_codec: Unknown model for ALC883, trying
auto-probe from BIOS"
It looks like that no "model=" is assigned.
Did you assign model for the driver?

Can you play some music?
Then there will be some info in the dmesg like
"hda_codec_setup_stream:NID=  ". 
Please paste such info and give the result of
"cat /proc/asound/card0/codec#0".

BTW, how did you do the testing?
You run speaker-test or by other way?

>From the codec info, it seems that there are paths from DAC to Jack.
So it's a little weird that all other jacks are silent.

Thanks!

> Hope this helps.
> 
> Best regards,
> 
> Patrick
> 
> > From: zhe.jiang@intel.com
> > To: fuuss@hotmail.com
> > Date: Tue, 15 Jan 2008 09:32:35 +0800
> > CC: cmatsuoka@gmail.com; alsa-devel@alsa-project.org
> > Subject: Re: [alsa-devel] intel-hd on an intel G33 motherboard
> >
> > On Mon, 2008-01-14 at 17:11 +0000, De Fuuss wrote:
> >> The jumper is now set to enable onboard (Intel HDA) audio.
> >> At the back of the barebone there are 5 jacks (4 channels for 7.1
> and 1 line in channel) + 1 spdif out.
> >> From these, using 6stack-hp, only the "Front L/R" jack works, none
> of the others
> >> On the front, there are 2 jacks (1 headphones and 1 microphone).
> The headphone jack works.
> >>
> > Can you tell us how you did the testing?
> >>From the driver code, it's not likely that all other jacks don't
> work.
> >
> > Because the driver support up-mixing, you can play a 2-channel music
> and
> > get sound from 4 jacks on the back panel.
> >
> > I read the dmesg output that you sent to me.
> > But there is no alsa debug info in it.
> > Did you really configure the driver with the option
> > "--with-debug=detect"?
> > If not, please try it and paste the dmesg info, it is helpful to
> trace
> > the issue.
> >
> > Best regards!
> > Jiang,zhe
> >> All the channels have been set to 100% in alsamixer.
> >>
> >> Considering that a week ago I had 0.0 and today I'm at 2.0, it's
> already a improvement. ;-)
> >>
> >> Patrick
> >>
> >>> Subject: Re: [alsa-devel] intel-hd on an intel G33 motherboard
> >>> From: zhe.jiang@intel.com
> >>> To: fuuss@hotmail.com
> >>> CC: cmatsuoka@gmail.com; alsa-devel@alsa-project.org
> >>> Date: Mon, 14 Jan 2008 16:43:00 +0800
> >>>
> >>> On Mon, 2008-01-14 at 02:06 +0800, De Fuuss wrote:
> >>>>
> >>>> Following your advice, I tested per channel output. Using either
> >>>> 6stack-dig or 6stack-hp, I get noise from Front Left and Right
> jacks,
> >>>> using speaker-test (X=1 and 2) but not on any other channels.
> >>>
> >>> Hi,
> >>> Did you mean that after you changed the 'Jumper',
> >>> you could get the sound from the Front jack on the back channel?
> >>>
> >>>> Patrick
> >>>>
> >>>>> Date: Sun, 13 Jan 2008 01:01:50 -0200
> >>>>> From: cmatsuoka@gmail.com
> >>>>> To: fuuss@hotmail.com
> >>>>> CC: zhe.jiang@intel.com; alsa-devel@alsa-project.org
> >>>>> Subject: Re: [alsa-devel] intel-hd on an intel G33 motherboard
> >>>>>
> >>>>> 2008/1/12 De Fuuss :
> >>>>>
> >>>>>> I get the uneasy feeling that something is messed up with this
> >>>> board. Anyway, for completeness' sake, I attached the results of
> >>>> amixer contents, cat /proc/asound/card0/codec#0 and dmesg for the
> >>>> module loaded as 6stack-dig. I have to try 6stack-hp again to
> confirm
> >>>> if I get something there.
> >>>>>
> >>>>> I fixed the Inspiron output, and I'm adding the SG33G5M codec to
> the
> >>>>> codecgraph codecs collection (git repository at
> >>>>> http://helllabs.org/git/codecgraph.git). If nodes 0x14, 0x15,
> 0x16
> >>>> and
> >>>>> 0x17 are the front, rear, clfe and side connectors in the back
> >>>> panel,
> >>>>> 6stack-hp should work (at least for the outputs). You can test
> the
> >>>>> outputs using "speaker-test -Dplug:surround71 -c8 -sX" (where X
> >>>> varies
> >>>>> from 1 to 8) and a pair of headphones.
> >>>>> _______________________________________________
> >>>>> Alsa-devel mailing list
> >>>>> Alsa-devel@alsa-project.org
> >>>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >>>>
> >>>> _________________________________________________________________
> >>>> Express yourself instantly with MSN Messenger! Download today
> it's
> >>>> FREE!
> >>>> http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
> >>>> _______________________________________________
> >>>> Alsa-devel mailing list
> >>>> Alsa-devel@alsa-project.org
> >>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >>>>
> >>>>
> >>>
> >>
> >> _________________________________________________________________
> >> Express yourself instantly with MSN Messenger! Download today it's
> FREE!
> >> http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
> >
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
> _________________________________________________________________
> Express yourself instantly with MSN Messenger! Download today it's
> FREE!
> http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
> 
> 
