From: Rimas Kudelis <rq@akl.lt>
Subject: Re: Test model
Date: Mon, 20 Feb 2006 09:13:03 +0200
Message-ID: <43F96BFF.8090705@akl.lt>
References: <200602200632.k1K6WSL8016070@auster.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200602200632.k1K6WSL8016070@auster.physics.adelaide.edu.au>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,
>> BTW one of the actions I tried last weekend was recording something from
>> the microphone. And it failed too. selecting one (don't remember which,
>> though) of the capture channels for capture resulted in continuous noise
>> being recorded, and selecting the other one resulted in silence. Also,
>> selecting both resulted in sum of these, hence, noise again...
>>     
> What sort of noise - hiss I assume? 
Yes, it was hiss.

> Secondly, what do you mean by
> "selecting both"?  Do you mean that both capture sources were pointed at the
> same source?  If so you wouldn't have recorded the sum; the two ADCs are on
> separate pcms, so you would only have been recording one or the other in
> this case.
>   
I think I pointed both capture sources at MIC1 (my internal/external
microphone), then selected both channels for capture in capture mixer.

> What kind of microphone were you using?  Did you have a bias setting
> configured for the jack the mic was connected to?
>   
I tried it with the internal mic. I could clearly hear in the speakers
when I tapped the computer with my fingers, so I assumed I should be
able to record that sound too. However, all I got was the hiss from one
channel, and absolute silence from the other.

>> Also, not sure if it's alsamixer's or driver's fault, alsamixer always 
>> says "Input Source 1" is "1", even though it selects the required source.
>>     
> I'm confused by this - "1" isn't an option AFAIK.  "MIC1", "MIC2", "LINE1",
> "LINE2" etc are the options.
>   
Right. So I can select MIC1, LINE1 etc in the alsamixer, but the
indicator at the top always says "1" no matter what I select.
Just to be clear: i'm referring to the console version of the alsamixer.
OTOH, I haven't recompiled ALSA utils (I think, Im using what Ubuntu has
provided me with), so it might just be version incompatibility.

>> Jonathan, I think that maybe the "test" model should have even more 
>> controls to play with, even those that may seem like should never be 
>> used? For example, there seem to be no checkboxes or something similar 
>> to control S/PDIF NIDs
>>     
> That's because I cannot test SPDIF inputs since they are not brought out
> to the outside world on my laptop.  Therefore I can't test prospective
> controls.
>   
Well, I think you could try adding those controls. Just the fact that
S/PDIF pins are not connected to anything on your laptop won't stop the
driver from err'ing in case you implement something in a wrong way. For
example, it err'ed for me when I tried to add volume controls for pins
0x0f - 0x15, and alsamixer wouldn't even load in these cases. :) So
basically, if alsamixer loads for you after adding the mixer controls in
question, you shouldn't have done anything wrong.

>> or jack (pin) widgets and so on.
>>     
>
> With the exception of the SPDIF pins, all output pins provided by the ALC260
> are already available in the mixer controls of the test model.  In other
> words, all the *analog* outputs should be present.  Have I missed some? 
> Which NIDs in particular are you referring to?
>   
NIDs 0x0f - 0x15 don't have input/output mute checkboxes. Of course, you
may say these are useless, and I would agree with you. :) Then again,
when it comes to a situation like mine where none of the sane options
are helpfull, it's better to have insane options available too, i think. :)

>> Such controls might be useful for testing, when nothing else seems to work
>> out
>>     
> If all analog pins are already catered for there's really no other options
> left.  Again, perhaps if you could elaborate on which controls you're
> thinking about things might become clearer.  In terms of the ongoing Acer
> saga, we probably need to take a step back and recap between yourself,
> Paulo and me precisely what works, what doesn't and what's been tried.  I'll
> pick this up in a day or so after giving things a bit more thought.
>   
OK. I'll just remind again, that I don't have direct access to the lappy
in question now. However, if we come up with something interesting to
test, I wouldn't mind visiting my mother and giving her speakers one
more chance to speak. ;) She'd be happy to see me anyways.

>> In order not to clutter the default tester's mixer interface, maybe this
>> (at least partially) should go to some kind of an "extended test" model, i
>> don't know.
>>     
> No, all controls belong in the test model.  It's a *test* model, so
> cluttering of the mixer isn't really a problem.
>   
OK.

>> BTW, if I haven't misunderstood the datasheet, I think it says that 
>> S/PDIF NIDs (0x03 and 0x06, if I remember correctly) can be told to 
>> output Analog audio, along with the other channels.
>>     
> I never noticed this - what page(s) of the datasheet appear to suggest this
> to you?
>   
Page 67 (marked as 60), first table (continued from the last page):
Bit: 0
Description: DigEn (Digital Enable).
          0: OFF (S/PDIF-OUT is in Hi-Z)
          1: ON

Now again, I'm not sure if I understood it correctly.

>> Could this possibly be Acer's case? I'm asking this because these were
>> probably the only NIDs that I didn't even try to play with...
>>     
> Digital outputs are digital outputs I would have thought - I can't imagine
> why they would be retaskable to analog, and I certainly didn't notice this
> possibility myself when I went through the datasheet.  If you had a page
> number I could look at I'll investigate further.
>
> The only way I would have thought the digital outputs could come into play
> is if for some reason the internal speaker and headphone jack were driven
> off an external DAC.  As I mentioned in a previous post though this doesn't
> seem sensible from where we stand.
Well, having no sound from internal speakers in Linux, while having it
in Windows, doesn't seem sensible too... ;) It's as I said - when no
sane options are left, it's probably the time to try those that seem
insane. Just to make sure.

Regards,
Rimas



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
