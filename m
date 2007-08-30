From: "John Utz" <john.utz@dmx.com>
Subject: Re: Dealing with 'siamesed' DAC sample rates
Date: Thu, 30 Aug 2007 12:42:10 -0700
Message-ID: <20070830124210.7b8411c0@jutz-gnto64>
References: <20070830115112.02820301@jutz-gnto64>
	<Pine.LNX.4.58.0708301212410.18152@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 702F224348
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Aug 2007 21:42:14 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.58.0708301212410.18152@shell4.speakeasy.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <xyzzy@speakeasy.org>
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Trent;

tnx for your input!

On Thu, 30 Aug 2007 12:28:10 -0700 (PDT)
"Trent Piepho" <xyzzy@speakeasy.org> wrote:

> On Thu, 30 Aug 2007, John Utz wrote:
> > The thrice cursed vt1618 has the DAC sample rates regs for the
> > Surround and Center/LFE DAC's (0x2E, 0x30) set to RO and locked to
> > whatever rate that the Front DAC is set to.
> >
> > So, i *think* that i want to change my driver code to poke the value
> > for setting hw:0,1 (should be reg 0x2e) into 0x2c instead? or am i
> > barking up the wrong tree?
> 
> Wouldn't that mean if you are using hw:0,0 at 48kHz and then tried to
> use hw:0,1 at 44.1kHz, that hw:0,0 would switch sample rates too, in
> the middle of playback?

Yes, absolutely true, i wondered if somebody would notice that
detail :-)

> Of course, this would go the other way too.  If you're using hw:0,1
> at 48k and then start hw:0,0 at 44.1k, the sample rate of hw:0,1 gets
> changed.

mmhmm

> It seems like the right thing to do would be to check if any other
> DACs are in use.

perhaps, but i dont think that there is a 'DAC IN USE' function. Are
you aware of one?

>  If any are, the sample rate is locked to whatever
> it is set at. If they aren't, then you can change all the sample
> rates by writing to the 0x2e register.

*How* would i do that? that's the nub of my problem, unlike volume and
jack settings, the 'build_ops' structure doesnt present a place to put
a 'sample rate change' callback.

So my problem is that i cant figure out *where* to do this in a way to
do this in patch_vt1618(), i only see ways to hack it in to the
generic portions of the driver and that's a pretty terrible idea. 

> When the device is opened, you check if any other DACs are in use
> too.  If any are, the hw constraints are set to the current sample
> rate.  If none are, then the sample rate constraint can be any
> supported rate.
> 

Same problem holds.

tnx for your suggestions tho, if you have any further thoughts i'd be
interested in hearing them from  you or anybody else because this issue
is going to wreck my chances of taking the last us summer holiday
weekend off :-(

tnx!

johnu
