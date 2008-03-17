From: Matthew R Hurne <matt.hurne@versatile.com>
Subject: Re: no front speaker sound with ALC262
Date: Mon, 17 Mar 2008 15:04:29 -0400
Message-ID: <47DEC0BD.5090403@versatile.com>
References: <165af2360802221645p9fa6bb0y3a5573caa7bcdbd7@mail.gmail.com>	
	<47BF84BF.702@versatile.com>	<47BF8500.1050802@versatile.com>	
	<7D68F908-875D-4EDE-B25D-CCBDD4E4A339@gmail.com>	
	<s5h1w6zvrz4.wl%tiwai@suse.de> <47DEA53B.4030207@versatile.com>
	<1205778900.27317.160.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mustang.versatile.com (mustang.versatile.com [206.61.179.31])
	by alsa0.perex.cz (Postfix) with ESMTP id AD15D244E8
	for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2008 20:04:30 +0100 (CET)
In-Reply-To: <1205778900.27317.160.camel@razman.gruemaster.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tobin Davis <tdavis@dsl-only.net>
Cc: alsa-devel@alsa-project.org, "Bradley B. Steiner" <brad.steiner@versatile.com>
List-Id: alsa-devel@alsa-project.org

Tobin Davis wrote:
> I am finishing up my current course tomorrow night, and the next
> {required} course I am taking is "Linux Fundamentals" - which is to say
> I will have spare cycles to help out again on this.

I appreciate it!  Just to clear up any confusion; Tangent is a value-add reseller here.  The Tangent 8000S is *really* the MSI Crystal 945 barebones unit, with parts installed/Windows installed and re-branded.  Tangent doesn't yet resell the MSI Crystal A410.  In fact, since Tangent doesn't really touch anything we're discussing here, we're probably best off talking about the MSI Crystal 945 and MSI Crystal A410, and just leaving Tangent out of it.  :-)  Here are links to the products on MSI's website:

Crystal 945: http://www.msicomputer.com/product/p_spec.asp?model=Crystal_945&class=npc
Crystal A410: http://www.msicomputer.com/product/p_spec.asp?model=Crystal_A410&class=npc

> Going through the message thread, you mentioned a Crystal A410 system
> that works, whereas your Tangent 8000S does not.    It would be
> interesting to recompile the drivers with "--with-debug=detect" and see
> what shows up in dmesg (for alsa only, not the entire boot log).  Based
> on that, we may be able to construct a driver model.  Also, if you have
> access to the Crystal still, could you run alsa-info.sh on it as well? 
> I'd like to verify the audio subsystem ID.

I have done the --with-debug=detect and alsa-info.sh data collection you describe above, though that was a few weeks ago.  I'll do it again with the latest from hg ASAP.

> In reviewing an earlier alsa-info posting, it shows your mixer as all
> channels muted.  I'm assuming you tried changing the volume levels in
> alsamixer?

Yes, definitely.  I probably failed to do so when I ran alsa-info, however.  In fact, I've tried loading the module with every possible value for the model parameter, and then raising all playback mixer levels each time before running aplay /usr/share/sounds/alsa/Front_Center.wav .
 
> At any rate, they list a 30 day trial unit.  I'll see if I can get one
> for driver development.  Nothing ventured, nothing gained.

If you can get a 30-day eval. Crystal 945 from Tangent, great!  Hopefully you'll actually get the Crystal 945, but Tangent is unfortunately vague about their model names, so it won't surprise me if they start sending out A410s instead of 945s labeled as model "8000S".  Probably not anytime soon, from what we can tell.  You'll know you have the Crystal 945 if it has an Intel chipset (the A410 uses an ATI chipset).  Both use the ALC262.  The *real* way (IMHO) to know which one you have is to look at the model number printed on the mainboard inside the unit; in the U.S., the Crystal 945's mainboard is labeled MS-7290, while the Crystal A410's mainboard is labeled MS-7341.

If you *can't* get an eval. unit, let me know.  I strongly suspect we could loan you one.

Matt
