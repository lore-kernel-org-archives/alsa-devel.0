From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: [PATCH] sst: Intel SST audio driver
Date: Mon, 18 Oct 2010 09:49:58 +0200
Message-ID: <4CBBFC26.1060204@ivitera.com>
References: <20101003112244.488282fd@linux.intel.com>	<20101003201943.GA31764@opensource.wolfsonmicro.com>	<20101004100424.4e5cf40c@linux.intel.com>	<s5hr5fpur7u.wl%tiwai@suse.de>	<20101017103626.GB6311@opensource.wolfsonmicro.com>	<s5hk4lhul3j.wl%tiwai@suse.de>	<20101017161808.GA4437@opensource.wolfsonmicro.com>	<s5h39s4v6wi.wl%tiwai@suse.de>	<20101017221126.GA11666@opensource.wolfsonmicro.com>	<s5hwrpgt4cn.wl%tiwai@suse.de>
	<20101018072017.GA25031@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (upc-plzen.insite.cz [84.242.100.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 89ED6103858
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Oct 2010 09:50:03 +0200 (CEST)
In-Reply-To: <20101018072017.GA25031@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, greg@kroah.com, alsa-devel@alsa-project.org, Alan Cox <alan@linux.intel.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hi,

Building a linux audio driver is like putting lego blocks together. That
is the major convenience in driver development and other non-opensource
systems cannot offer such luxury to driver developers. I am in no
position to make any statements but please keep this luxury alive and
thriving and do not let it be ruined by vendor-specific ways if there is
a standardized framework to employ, if the framework is suitable for the
task, and if modifying the existing driver is not overly complicated.

Thanks for the great work you are doing.

Pavel.

Mark Brown napsal(a):
> On Mon, Oct 18, 2010 at 08:14:16AM +0200, Takashi Iwai wrote:
>> Mark Brown wrote:
> 
>>> I do have some qualms about staging but given Greg's active policing of
>>> it and work to push things into the actual trees the warnings about its
>>> quality and general mainlineness are much more meaningful than those for
>>> experimental.  There's also the tainting of kernels, which is really
>>> useful.
> 
>> But who of the end user would care about it?  It's distributor and
>> developer who care.
> 
> End users I'm not so worried about in the immediate instance, it's
> mostly developers and in the embedded space there's way more of them
> than end users.  A lot of the time end users don't get sufficent access
> to the hardware to worry about kernels (though in this case that's less
> likely to be the case).
> 
>> And, is the code quality is in question, which is supposed to be
>> fixable there?  Your argument against this driver doesn't sound like
>> fixable.
> 
> What makes you think these problems are unfixable?  It should be fairly
> straightforward to pull out the CODEC and board parts of the driver and
> factor them out - as I said last night the ASoC CPU side support is a
> very thin wrapper around vanilla ALSA.  The code and board sections of
> the code look fairly basic and straightforward to redo within the ASoC
> APIs.  I don't think this is an unreasonably difficult thing to do and
> it's certainly nowhere near starting from scratch.
> 
>> So then why you do you think keeping that stuff in staging tree is OK
>> while sound tree is not?  It's a question to be or not to be.
>> End-users never hesitate using the staging if it works.  They don't
>> notice the difference; they don't notice kernel taint either.
> 
> Like I say, I have some qualms about staging but they're pretty minor.
> The idea of accepting embedded drivers which don't use ASoC seems like a
> massive step back compared to where what we've got right now, and is
> going down the path of accepting drivers that don't even sit within
> ALSA.
> 
> Currently with Linux we're able to say that if a CPU is supported and a
> CODEC is supported then we can use the two together.  That's great, and
> it's good for all concerned.  If we're going to start accepting vendor
> specific audio stacks we'll no longer be in a position to say that.  We
> will be back to having to talk about specific combinations of devices
> working together.
> 
>> The staging driver is also in upstream; distribution enables it almost
>> always, no matter how the quality of each driver is.  For developers,
>> the distinction is clear, of course.  But for the rest, it's not.
> 
> The biggest issues here surround developers.
> 
>> So, if you really don't want this style of implementation, you'll have
>> to take an action for getting rid of the driver from staging tree.
>> Otherwise others will submit the similar drivers, and they'll land
>> there, too.  Then we can keep the stuff in sound or other git tree
>> in another branch until the things gets sorted out.
> 
> One of the nice things about staging (indeed the key thing from my point
> of view) is that Greg does from time to time remove drivers from staging
> which look like they're not making any progress towards leaving staging.
> In contrast drivers in the main tree generally sit there indefinitely
> with minimal impetus to improve them.
> 
>>> I'm sorry I don't really understand what you're saying here.  The
>>> encoder offload stuff is all totally orthogonal to the issue of using
>>> the ASoC APIs.  On the CPU side the ASoC API is mostly a thin wrapper
>>> around the standard ALSA API so anything that works in ALSA should slot
>>> fairly readily into ASoC.  What I'd expect to see happen is that the
>>> CODEC and board stuff would get pulled out and everything else would
>>> stay pretty much as-is, including the DSP.
> 
>>> CPUs like OMAP (which are obviously already in the ASoC framework) also
>>> support this sort of stuff, the issues with mainline for them have been
>>> around the API to the DSP, though it looks like the TI stuff in staging
>>> is getting sorted out now.
> 
>> Well, what I don't understand in your argument is why we must stop it
>> being deployed.
> 
> Because it's not using the relevant framework at all, it's gone and
> reinvented the wheel without a pressing reason to do so and this will
> be very likely to create problems if the part is at all successful.  It
> will also set a really bad precedent for other vendors which is even
> more worrying than the specific driver.
> 
> Throughout the kernel we regularly have to push back on embedded vendors
> (not just CPU vendors) who produce drivers outside the standard
> frameworks and get them converted to the standard frameworks so that
> they can be deployed without having to go into driver specific APIs all
> the time.  Due to the fact that everything gets merged into one mainline
> tree Linux has much higher standards all round with this sort of thing
> than most other OSs but it takes work to enforce that.
> 
> This does include a bunch of the recently posted Intel drivers,
> including this one, but there's nothing particularly unusual here.
> 
>>                  Because it doesn't match with the current design of
>> the framework?  If so, a straight question must come next: can't the
>> framework itself be extended to suit with such hardware?
> 
> As I wrote several times I can see no problem supporting this hardware
> with current ASoC.  I'm not sure how I can be any clearer on this point.
> 
>>> I'm saying I see nothing about this hardware which should prevent it
>>> working with ASoC right now.  As I have said in terms of the overall
>>> structure of the device it's not really doing anything that hasn't been
>>> done elsewhere.  There's stuff we'd have to bodge in the short term, but
>>> only fairly small bits that can be handled fairly straightforwardly.
> 
>> OK, then we should fix this first.
> 
> This is all driver specific stuff, there's nothing that needs doing
> here immediately outside of the driver that I can spot right now.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
