From: Manuel Jander <mjander@embedded.cl>
Subject: Re: Audigy1 MIDI input, wavetable support?
Date: Sat, 08 Mar 2003 00:25:35 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E6970BF.60103@embedded.cl>
References: <20030307154402.GA338@znex> <1047065951.3136.55.camel@sprekhole>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1047065951.3136.55.camel@sprekhole>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I would like to comment something about that Software / Hardware 
wavetable issue:

-Most today soundboards use software wavetable anyway. So having one generic
wavetable engine should work for all of them. The idea is to share the 
effort; one for all.

-Some soundcards if not all of them use multiple PCM channels using a 
hardware mixer
and sometimes some hardware efects (modulation on the trident for 
example). I think,
a good approach would be a software wavetable engine that makes use of 
as many hardware
PCM channels as avaiable, and allows some kind of hardware effects 
through callbacks to set
hardware effect parameters. If the driver developer lets them empty, 
just nothing happens
or a software fallback is used.

Best Regards

Manuel Jander.

Josh Green wrote:

>On Fri, 2003-03-07 at 07:44, Mark J Roberts wrote:
>  
>
>>I am trying to load a soundfont into my Audigy1's wavetable and play
>>it with a MIDI keyboard. I am using kernel 2.5.64.
>>
>>MIDI output verifiably works. However, MIDI input does not. The
>>cable and keyboard are not the problem--I've tried them with an
>>es1371, and I easily got MIDI input working.
>>
>>My procedure with the Audigy1:
>>
>>	cat /dev/snd/midiC0D0
>>	watch /proc/interrupts
>>	watch /proc/asound/Audigy/midi0
>>
>>No interrupts occur and no bytes are read. I have also tried using
>>aconnect to connect the inputs. Does anyone else see this behavior?
>>
>>I've got one more question. What program should I use to configure
>>the wavetable and load the soundfonts? I found a couple versions of
>>"awesfx", neither of which was compatible with my ALSA.
>>
>>
>>    
>>
>
>I know that ALSA contains support for the wavetable of the EMU8k and
>EMU10k series of cards (AWE 32/64 and Live! respectively). I'm not
>absolutely sure whether the wavetable on the Audigy is also supported,
>but chances are it is. The SoundFont loading API is OSS based, but ALSA
>uses it so awesfx (sfxload utility, etc) should work (provided the API
>is actually there for the Audigy).
>I'm convinced that software synthesis is the way to go. It allows for
>easier routing of the synthesized data (via Jack for example) and
>supports any sound card. This is the approach I have gone with with
>Swami (http://swami.sourceforge.net) the successor to the Smurf
>SoundFont Editor which was based on the OSS awesfx API. Swami uses
>FluidSynth (http://www.fluid-synth.org - was previously called
>iiwusynth) to do software synthesis of SoundFont files. Using software
>synthesis gives us these additional features over current Linux
>supported hardware solutions:
>
>- Modulator support, allowing for real time modulation of effects with
>MIDI controllers (or with GUI controls from Swami)
>- Customizable Reverb/Chorus (EMU10k doesn't have support for these
>effects in Linux)
>- Routing of audio via Jack, opening up a whole world of audio
>processing, effects, etc.
>
>The downside is of course the CPU usage, so in the future I will likely
>be re-adding support to Swami for the hardware wavetable OSS API.
>
>If you want to check these projects out, you can either wait a few days
>for FluidSynth 1.0 to be released which a release of Swami will follow
>shortly after, or you can get Swami CVS and FluidSynth CVS. Cheers.
>	Josh Green
>
>
>
>-------------------------------------------------------
>This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
>for complex code. Debugging C/C++ programs can leave you feeling lost and 
>disoriented. TotalView can help you find your way. Available on major UNIX 
>and Linux platforms. Try it free. www.etnus.com
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel
>
>.
>
>  
>




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
