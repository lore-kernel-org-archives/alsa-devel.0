From: Liam Girdwood <lrg@ti.com>
Subject: Re: UCM representation questions
Date: Sat, 21 May 2011 17:20:20 +0100
Message-ID: <4DD7E644.4010301@ti.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0498A47E52@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id AF901103833
	for <alsa-devel@alsa-project.org>;
	Sat, 21 May 2011 18:20:26 +0200 (CEST)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0498A47E52@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Mark Brown (broonie@opensource.wolfsonmicro.com)" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 20/05/11 22:48, Stephen Warren wrote:
> Liam,
> 
> I have a few more questions how to represent things in UCM.
> 
> The Tegra boards I'm dealing with are set up like this:
> 
> hw:0,0 >--wm8903--> headphones
>               \---> speakers
> hw:0,1 >----------> hdmi
> 
> The WM8903 allows the audio stream to be routed to neither, one, or both
> of headphones and speakers.
> 
> hw:0,0 <--wm8903--< Analog Mic (AMIC)
>              \----< Digital Mic (DMIC)
> 
> The WM8903 can capture from one or the other or AMIC/DMIC, but not both.
> 
> 1)
> 
> How to indicate when certain devices can be used together, or are
> mutually exclusive?
> 

Atm, I don't think we can do this with devices. We can do it with modifiers though (i.e. a modifier can list it's supported devices). It does sound like a useful feature and probably could be based on the modifier supported device code.

> Note that Headphone/Speakers/HDMI can be used in any combination, but
> AMIC/DMIC are mutually exclusive.
> 
> use_case.h indicates that neither Devices nor Modifiers are mutually
> exclusive, so neither alone can be used to represent this.
> 
> I suppose you could just create a separate use-case for each legal set
> of combinations. Taking a capture-only case, we'd end up with separate
> "Capture AMIC" and "Capture DMIC" cases. However, a "HiFi" or "Music"
> case could simply list all 3 devices in a single case since they all
> can operate at once.
> 

You could, but it may be nicer to eventually add the ability to UCM so we can represent this relationship. 

> 2)
> 
> Let's then consider a "VoIP" use-case that wants to both play and
> capture audio. If we represent the exclusivity in the same way, we'd
> end up with 2 more cases "VoIP AMIC" and "VoIP DMIC", each listing 3
> devices for playback, and 1 device for capture.
> 

The intention for UCM here is to have a single use case verb for your VOIP use case with UCM AMIC, DMIC, Headphone and Speaker UCM devices. So your VOIP app would know about the available devices, but not that the AMIC and DMIC were mutually exclusive without the UCM "supported device" feature discussed above.

> It seems like switching between these two cases while a call was active
> would be problematic. In particular, in my current UCM files, there is
> e.g.:
> 
> SectionDevice."Speakers".0 {
>     Comment "Internal Speakers"
> 
>     EnableSequence [
>         cdev "hw:0"
>         cset "name='Speaker Switch' on,on"
>         cset "name='Int Spk Switch' on"
>     ]
> 
>     DisableSequence [
>         cdev "hw:0"
>         cset "name='Speaker Switch' off,off"
>         cset "name='Int Spk Switch' off"
>     ]
> ...
> 
> Wouldn't the DisableSequence get run for this device when leaving the
> "VoIP AMIC" case, and the EnableSequence get run when entering the
> "VoIP DMIC" case; that would cause a glitch in the receive side of the
> call even though we were just switching the transmission side between
> mics.
> 

I don't see why the speaker disable sequence would be run when switching between AMIC/DMIC. If it is, then it sounds like a bug. 


> Perhaps the UCM library is intelligent enough to realize that the same
> device is active in both the old and new case, and then doesn't execute
> the Enable/DisableSequence in that case. But, that seems dangerous; the
> sequences might have required effects in some case.
> 

There is limited intelligence in UCM core, it merely executes the application requests (if the current UCM data permits it to).

> I can't omit the DisableSequence to make this work, or disabling the
> Speakers device (e.g. to switch to just headphones) wouldn't actually
> disable anything. I suppose I could put the Speaker disable logic in
> the Headphone EnableSequence, but then I wouldn't be able to use both
> together. Perhaps the answer is a "virtual" Device "Speakers and
> Headphones" which enables both. I couldn't correctly represent the
> device-specific volume controls or PCMs then. Plus, this approach would
> quickly lead to an explosion of Devices; 8 SectionDevices in my the
> case of my 3 physical IOs.
> 

> 3)
> 
> It seems like there's a lot of potential for duplication in the UCM
> file content. If I have "VoIP Low Quality", "VoIP High Quality", and
> "Hifi" cases, the latter with a modifier to allow capture of voice e.g.
> for voice commands, and each somehow supporting capture from either
> AMIC or DMIC (ignoring how to represent mutual exclusivity) then the
> UCM file for each case has to include the cset actions to switch
> between AMIC and DMIC:
> 
> SectionDevice."Capture AMIC".0 {
>     Comment "Analog Microphone Jack"
> 
>     EnableSequence [
>         cdev "hw:0"
>         cset "name='ADC Input' 'ADC'"
>         cset "name='Left Capture Mux' 'Right'"
>         cset "name='Right Capture Mux' 'Right'"
>     ]
> ...
> 
> SectionDevice."Capture DMIC".0 {
>     Comment "Internal Digital Microphone"
> 
>     EnableSequence [
>         cdev "hw:0"
>         cset "name='ADC Input' 'DMIC'"
>         cset "name='Left Capture Mux' 'Left'"
>         cset "name='Right Capture Mux' 'Right'"
>     ]
> ...
> 
> Is there any way to avoid this cut/paste?

Not atm, the UCM parser is quite simple and doesn't yet understand the concept of #include ;)

> 
> I initially expected the UCM file format defining Devices outside of
> Verbs, and Verbs to list which devices were associated with the verb by
> reference rather than inclusion, and perhaps also configuring some
> additional properties of those devices, but not duplicating the raw
> "how to route this device to the PCM" instructions.

This was one of my original assumptions too, but it turned out that some audio devices have several different routes to each device (and this route could depend on use case), hence this had to be simply represented in the file format.  

> 
> 4)
> 
> Is listing multiple CaptureVolumes in a single Device's Value section
> legal. For example, for a stereo analog mic:
> 
> SectionModifier."Capture AMIC".0 {
>     Comment "Analog Microphone Jack"
> 
>  
>    Value {
>       CaptureVolume "Left Input PGA Volume"
>       CaptureVolume "Right Input PGA Volume"
>     }
> }
>

Oh, not atm. We should be able to express thing like Left and Right wrt to Volume and Mark did mention the need for improvement in the Volume aliasing at the conference. I do have a note against my name to look at it, but I cant give any time scales atm.

 
> ... since the WM8903 exposes separate controls for the L/R channels,
> and I'd expect applications would want to expose a single control to
> users, and set them both to the same value all the time.
> 
> Thanks again for any answers.
> 

Regards

Liam
