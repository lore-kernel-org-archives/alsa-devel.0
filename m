From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: PCM hw mixing with volume
Date: Thu, 11 Mar 2004 10:24:27 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20040311102427.pochini@shiny.it>
References: <1078937796.18056.355.camel@renegade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1078937796.18056.355.camel@renegade>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ove Kaaven <ovek@transgaming.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 10-Mar-2004 Ove Kaaven wrote:

>> Uhm... I think first of all we need a way to know how many
>> virtual channels are available (hw and sw)
>
> For the EMU10K1, snd_pcm_info_get_subdevices_count() and
> snd_pcm_info_get_subdevices_avail() works for me. But I suppose you're
> right that this isn't a good abstraction.

It isn't good because the app wants a virtually unlimited
number of channels. I was thinking of something like this:

sndhandler=PrepareToPlay(sound);
SetVolume(sndhandler, -10);
SetPan(sndhandler, 0);
or SetPosition(sndhandler, x, y, z);
SetEffect(sndhandler, foo, bar);
Start(sndhandler);

The application shouldn't have to take care of the actual
number of virtual channels the card provides other than at
initialization, eg.:

AllocSfx("hw:0,0,2", 8); /* alloc 8 vchannels starting from subdev 2 */

Then Start() will play the sound using the allocated channels
in a LRU way of something similar.


>> set_volume() should be something more generic. Think about 5.1 .
>
> I think 3D position controls or pan controls would be more appropriate
> than a more flexible volume control. Or perhaps the stream might just be
> 6-channel in the first place...

It should be possible to mix them, SFX and background music.


>> Also, the API should lay above the PCM API because, if the
>> card hasn't the required capabilities, that layer will emulate
>> it using the PCM API. Also, in some cases (eg. the Echoaudio
>> Mia and probably hdsp), that mixing feature is already
>> supported by the driver through the normal PCM and control APIs.
>
> Good point, but I wonder how 3D effects could be applied to sounds
> loaded into the card's onboard memory (via the suggested wavetable API).
> Perhaps that won't be a very important feature though.

PrepareToPlay() loads the sample and Start() plays it. It's pretty
indipendent on how the sound will be actually played (through the
PCM API of the sequencer API or whatever). As you just reminded me
some cards have onboard memory that holds MIDI instruments. It can
be used for generic sound effects as well.


>> We can define a small set of standard effects, or we can do something
>> like the control API.
>
> As far as I'm concerned, as long as the API can do what I need, it
> doesn't matter much what it looks like. DirectSound does allow
> individual drivers to implement custom device-specific effects, but I
> don't expect to really want that. Standard effects are good enough.

Stardard effects are simple, but a more generic interface is
expandable. It's like OSS control interface vs ALSA control interface.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
