From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: seq module loading issue
Date: Thu, 09 Oct 2014 09:29:03 +0200
Message-ID: <5436393F.6020309@ladisch.de>
References: <CAOf41NnCESt3PEGhp3yKgZhScG1H0+qrhz8h3+vjBUfGzfhsyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 4D81B260539
 for <alsa-devel@alsa-project.org>; Thu,  9 Oct 2014 09:29:05 +0200 (CEST)
In-Reply-To: <CAOf41NnCESt3PEGhp3yKgZhScG1H0+qrhz8h3+vjBUfGzfhsyA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Goode <agoode@chromium.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adam Goode wrote:
> I've observed a scenario in ALSA that I would like some feedback on
> solving. On Linux, Chrome uses seq for WebMIDI. Eventually, there will be
> hotplug detection code in Chrome that looks like this:
>
> 1. Connect to announce port
> 2. Listen for any announcements for client/port start/end
> 3. Send MIDIConnectionEvent events to JavaScript clients (
> http://webaudio.github.io/web-midi-api/#midiconnectionevent-interface)
>
> Here is the scenario where this fails:
>
> 1. Cold boot a machine with no MIDI devices plugged in
> 2. Start client, subscribe on the seq announce port
> 3. Insert USB MIDI device
> 4. snd_rawmidi module is loaded, triggered by insertion of MIDI device
> 5. snd_seq_midi is NOT loaded, but marked for loading later
>
> At this point, there is no client start event sent to the announce port.

In practice, programs that listen to these announcements do so in order
to dynamically update their own list of MIDI clients/ports, and
enumerating those would have triggered autoloading.  This might be the
reason that this problem has not been reported so far.

I don't know about your implementation of the MIDIAccess interface, but
it looks as if enumeration is needed when the client accesses either the
"inputs" or "outputs" fields.  Couldn't you trigger the same enumeration
when the onconnect/ondisconnect event handlers are set?


Regards,
Clemens
