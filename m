From: Juan Linietsky <coding@reduz.com.ar>
Subject: Re: Alsa MIDI device description extension proposa
Date: Sat, 23 Mar 2002 21:34:45 -0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020323213445.179dd295.coding@reduz.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from john.anime.com.ar ([64.113.39.216])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id BAA02336
	for <alsa-devel@alsa-project.org>; Sun, 24 Mar 2002 01:33:04 +0100
Received: from server (c00lius@OL16-140.fibertel.com.ar [24.232.140.16])
	by john.anime.com.ar (8.9.3/8.9.3) with SMTP id UAA22953
	for <alsa-devel@alsa-project.org>; Sat, 23 Mar 2002 20:32:46 -0400
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, 23 Mar 2002 01:26:03 -0700
Michael Ashton <data@ieee.org> wrote:

> On Friday 22 March 2002 06:16 pm, you wrote:
> > I have a proposal in mind, which should make much easier for programs to
> > use the devices in a less-blind way, and standarize patch naming and device
> > descriptions. I think it would be great if authors of existing apps have
> > the chance to modify their programs to take advantage of this, saving us
> > both users and programmers a lot of effort.
> 
> Could be a good idea; but it's a very difficult thing to do properly.

It's not that dificult, i'm just limiting the scope of this implementation to:

-patch names
-bank names and bank select methods


> 
> > I really think this is a very important issue that hasnt been addressed,
> > And, if no one is interested in workig on this, I'd like to work on this
> > myself, so i'll have the chance to learn.
> 
> Well, I think some form of this was considered by Frank van de Pol in the 
> original sequencer design, but I think it was (wisely) decided to stick to 
> the basics for the first versions.


And this is exactly why i think it can be done, it does stick to the basics and standards.


> > To avoid this instrument naming madness, i propose to add an extension
> > to both the alsa user interface, driver interface, and sequencer client
> > inerface which could work this way:
> 
> OK. I almost never use software synths or soundcard synth engines; I only use 
> external MIDI modules. So my comments are from that perspective.
> 

Ah, well, from that perspective, as I said before, there is a standard way of doing this, which should apply to most synths (or all synths worth supporting). 

This is the standard bank selection method (using controllers 0 and 32 for msb/lsb of the bank index), using this and patch names should support
any patch-based synth made from any company. Of course i dont think this takes in consideration machines such as analogue synths or synths that dont use patches but parametric presets. But those are out of the scope of this implementation, or as you said before, something about these could be tried once alsa is mainstream, since it would probably take a lot more work.

> > from the program side:
> >
> > -ability to poll the midi port for amount of banks and their parameters (or
> > default bank if no banks).
> 
> OK .. but not all synthesisers have the concept of a 'bank'; and certainly 
> not all synthesisers treat of 'banks' in the same way.
> 

Exactly, thats what i've said before, synthethizers that are not patch/bank based should be left out of this, since such methods
are not standard. Other than that, bank/patch selection IS a standard.
If the case is that your synth doesnt switch banks the standard way (controllers 0/32) soemthing could be added such as "midi string to send to set bank". But personally i dont know any synth (at least post-90's) that doesnt use that.


> > -ability to poll for patch names in a bank
> 
> This would potentially be useful.

Yes! that is the main idea of this proposal, It would work for 99% of the things out there, it would make patch naming of our synths easier, it would make driver/softsynth programming easier, and it would make users
much happier since they wont need to either enter patchs by hand, or at least they wont need to create propertary patch definition files for every prorgram they use. Or in any case, it would be much easier to just share the definition files for external devices whose patch/bank names cant be retrieved.


> 
> > -ability to poll the midi port for rynth channels/patches (default is
> > channel 10, i know, but some synths use channel 16 or more than one rynth
> > channel), or to poll if a certain patch number is a rythm patch (some
> > synths use a certain patch number for the drums)
> 
> Sometimes you can't tell. For example, how can a sampler tell that a patch 
> you made is a drum patch? Many of them nowadays let you assign categories to 
> patches, but many of them don't do this. You'd have to supply the information 
> separately in that case.

This is easy, if the it is a drum patch, then it will sound on drums
channel, or you can just tell "patch 25 is a drum set" and then you can
poll the individual note names of that patch.



> 
> > -ability to poll for
> > changes in the devices (or a callback manybe?) so they can be retrieved and
> > updated
> 
> This would be nice, maybe, but you don't want this happening sometimes; for 
> example, if you try to do sys-ex reads while a sequence is playing, some 
> synths will cease responding to notes while they process the sys-ex, causing, 
> at best, an interruption in playback.
>

Yes, but i suppose this should be an issue of the software app, where you could switch from manual/auto.

 
> > -ability to poll DEFAULT VALUES of patches (such as controller
> > values, poly/mono, portamento, sustain, expression, volume etc) which the
> > patch sets to when selected. This is extremely useful in external synth
> > modules/keyboards.
> 
> Could be, yes.

Just basic things here, this is not supposed to poll your whole algorithm/operator configuration on your synth, only some default
controls to find out default values after you send a midi reset string.


> 
> > from driver/synth client side:
> >
> > -if the driver supports it (such as, for exampe, a sblive or sbawe, opl3
> > (sbi loading), or alike, or a sequencer client which can hold the patch
> > names itself, such as timidity, saturno, iiwusynth, smurf, etc then the
> > driver itself will take care of answering the client request.
> 
> OK, good.

This would apply mostly to soundcard synths or software synths, and should
work perfectly with _all_ of them since it's just adapting the app/driver.
And will make stuff such as using soundfonts a lot easier.


> 
> > -if the
> > driver doesnt support this, (for example, an external midi uart) then it
> > should be possible to create a STANDARD instrument definition file for this
> > device, which alsa-lib will take care of, like for example:
> [...]
> 
> Why not XML?

Well, I'm certainly not a lover of XML for configuration files where the user has to fill up values by hand.


> 
> > This should basically avoid us users and programmers to do all this work
> > from the sequencer program side, and also ending up with a hundred of
> > incompatible formats.
> 
> Not if the data organisation isn't flexible enough to accommodate 99% of all 
> situations flexibly. If a programmer finds that your system doesn't meet his 
> needs, and can't be extended to meet his needs, he'll roll his own.
> 

It does accomodate 100% of the situations, we're talking about using a standard. Any app should perfectly be able to accomodate to this, and if not, then the app is not in the scope of this.


> This is an interesting, but IMO a very difficult design problem. I've been 
> trying to design instrument systems like this off and on for the past few 
> years, and I _still_ haven't come up with a system I really like. In scouting 
> the 'net for the past several years, I've yet to find a non-proprietary data 
> structure general enough to handle any synthesiser or set of synthesisers. 


Ahhhh, but this is not what i'm proposing. I'm strictly speaking about patch/bank naming and polling, no more.

> 
> - Programmable synthesisers don't have static patch sets; patches can be 
> moved to different locations, and their entire memory can be reloaded with 
> different data. A good patch librarian must deal with this fact.

you load a library, then you just put a new patch definiton file.
or if the sample supports info polling, this should not be an issue.

> 
> - Drums, percussion, and other non-tonal sounds present an interesting 
> problem. For drum patches, the MIDI 'note' ceases to indicate pitch, and 
> instead indicates timbre. Each 'note number' then corresponds to a different 
> sound, and it is useful sometimes to name these. Should each note number then 
> be assigned a name? 

Yes, this is how it works, and how it allways did, when you have patch name definitions, they can be for patches or drums.


Should this be the case for all patches, or should we 
> distinguish 'normal' patches, like pianos, where we don't want to give each 
> key a name beyond C2, D4, etc., and 'drum' patches, where each note has a 
> special name? What about 'splits' where different regions of the keyboard 
> play different sounds?

normal patches shouldnt be note-distinguished, if you have a split,
you just name your patch: "sax&piano split"


> 
> - There are almost as many ways to organise patches in memory as there are 
> synthesisers. Synths don't always have just 'patches'; some have 
> 'performances' as well, which, when selected, configure the synthesiser's 
> overall MIDI response, assigning patches to one or more channels. Usually 
> this includes effects and other ancillary selections. Performances are 
> sometimes selected by program changes, and other times only from the front 
> panel or by sys-ex messages. Some synthesisers do not have performances as 
> such, but instead respond to program changes on each MIDI channel.
> 

Performances are just default layouts, they dont involve patch naming,
or bank selection, and they are well beyond the scope of this.



> I could go on, but this should be enough to chew on for now ;-)
> 
> It may be best to simply focus on patch management solely for the purposes of 
> naming and availability of patches; 


yes! that's exactly what i'm talking about :) ONLY patch naming!
and maybe controller naming too.


> 
> But I do not know whether it really belongs in ALSA; and I am pretty certain 
> a complete patch librarian and editing system belongs elsewhere. However, 
> making it strongly connected with the ALSA project might not be a bad thing.

It does belong to ALSA, there is no other way to do this if it's not from the sound api.



regards

Juan Linietsky

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
