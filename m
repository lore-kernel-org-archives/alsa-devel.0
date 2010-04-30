From: Daniel Mack <daniel@caiaq.de>
Subject: Re: Wrote MIDIcat program,
 to connect ALSA MIDI to standard input/output
Date: Fri, 30 Apr 2010 11:42:24 +0200
Message-ID: <20100430094224.GB30801@buzzloop.caiaq.de>
References: <4BDA9A94.2080309@krellan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id AF09D243E2
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 11:42:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4BDA9A94.2080309@krellan.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Josh Lehan <alsa@krellan.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 30, 2010 at 01:53:40AM -0700, Josh Lehan wrote:
> Hi!  A few months ago, I posted about a program to send untimed MIDI
> data to the ALSA sequencer.  Using amidi(1) wasn't acceptable, since it
> only talks to "RawMIDI" devices.  Using aplaymidi(1) wasn't acceptable
> either, because it required .MID files, and I simply wanted to send
> untimed MIDI data, similar to what would be produced if you hooked up a
> hardware MIDI keyboard and just started playing.
> 
> I needed something more general, that would simply connect to the ALSA
> sequencer, and let me send arbitrary MIDI bytes to a sequencer
> destination of my choice.  Unfortunately, no program existed that would
> simply do this.
> 
> I'm pleased to announce that I've written such a program, It's called
> MIDIcat, as it works on the same principle as "cat" and other similar
> programs (Netcat, and so on).

Nice, thanks for sharing this!

Daniel


> 
> It hooks up standard input, and standard output, to the ALSA sequencer.
> 
> This makes it easy to pipe data around.
> 
> It's an ALSA sequencer client.  Any data that is received on standard
> input will be forwarded into ALSA.  You can choose another client as a
> destination, or you can just start the program passively and use ALSA's
> "subscription" mechanism to route the data later.
> 
> Similarly, any MIDI data that comes from ALSA, will be forwarded along,
> and provided on standard output.
> 
> This makes it easy to make many small "one-liner" command lines that are
> useful for testing and playing around with MIDI data in general.
> 
> As an example, this plays Middle C:
> 
> echo "90 3C 7F" | midicat --hex --port "TiMidity"
> 
> The --hex option makes things more human-readable: standard input and
> output are hex digits, separated by spaces, instead of just raw binary data.
> The --port option has the usual ALSA sequencer meaning.  Change it to
> target your synthesizer (I'm using the TiMidity softsynth).
> 
> Here's another example for output (both of these commands block, so run
> them in two separate terminal windows):
> 
> midicat --verbose --hex
> vkeybd --addr 129:0
> 
> The --verbose option prints out some more useful information at startup,
> such as the ALSA sequencer client:port number it got.  That can later be
> passed into another program, such as vkeybd.  If you play notes with
> vkeybd, you see the corresponding MIDI data appear on standard output.
> 
> Standard input and standard output can both run at the same time (it's
> multithreaded).
> 
> Here's some more elaborate examples:
> 
> MIDI "panic button", sends "All Sound Off" to each channel:
> 
> perl -e 'use bytes;for($i=0;$i<16;$i++){print
> chr(176+$i).chr(120).chr(0);}' | midicat --port "TiMidity"
> 
> Another MIDI "panic button", sends individual "Note Off" commands:
> 
> perl -e 'use bytes;for($i=0;$i<16;$i++){for($j=0;$j<128;$j++){print
> chr(128+$i).chr($j).chr(127);}}' | midicat --delay 10 --port "TiMidity"
> 
> The --delay option inserts a slight delay between each MIDI command, to
> avoid flooding ALSA with too much data at once.
> 
> Here's a fun one, sending random data into the MIDI subsystem and seeing
> what happens.  DO NOT run this on a real synthesizer, there's the risk
> of composing a random SysEx command that could mess up your settings!
> 
> It's fun to watch with aseqview(1):
> 
> aseqview &
> cat /dev/urandom | midicat --delay 500 --port "MIDI Viewer"
> 
> If you sent random data to a device that plays audio, you'll probably
> next want to use the "panic button" commands above...!
> 
> Hope this illustrates some of the examples and possibilities.  I'm
> working on writing some more documentation.
> 
> The --help option is supported, there's a help output that shows you all
> of the available options.
> 
> For now, the program is available here, on my Web server:
> 
> http://krellan.com/midicat
> 
> If you're interested, try it, and let me know what you think!
> 
> Josh Lehan
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
