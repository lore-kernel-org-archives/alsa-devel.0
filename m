From: Adam Goode <agoode@chromium.org>
Subject: seq module loading issue
Date: Wed, 8 Oct 2014 18:00:41 -0400
Message-ID: <CAOf41NnCESt3PEGhp3yKgZhScG1H0+qrhz8h3+vjBUfGzfhsyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f175.google.com (mail-ig0-f175.google.com
 [209.85.213.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E9172604CF
 for <alsa-devel@alsa-project.org>; Thu,  9 Oct 2014 00:01:04 +0200 (CEST)
Received: by mail-ig0-f175.google.com with SMTP id uq10so9083846igb.8
 for <alsa-devel@alsa-project.org>; Wed, 08 Oct 2014 15:01:02 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I've observed a scenario in ALSA that I would like some feedback on
solving. On Linux, Chrome uses seq for WebMIDI. Eventually, there will be
hotplug detection code in Chrome that looks like this:

1. Connect to announce port
2. Listen for any announcements for client/port start/end
3. Send MIDIConnectionEvent events to JavaScript clients (
http://webaudio.github.io/web-midi-api/#midiconnectionevent-interface)

Here is the scenario where this fails:

1. Cold boot a machine with no MIDI devices plugged in
2. Start client, subscribe on the seq announce port
3. Insert USB MIDI device
4. snd_rawmidi module is loaded, triggered by insertion of MIDI device
5. snd_seq_midi is NOT loaded, but marked for loading later

At this point, there is no client start event sent to the announce port.
This is because of the deferred module loading, which won't trigger except
for a handful of operations (snd_seq_client_info_get_client is an example).

This is easily replicated with looking at aseqdump -p 0:1.


My question is: how to solve this? There are a few options:

1. Periodically poll for new clients. This is fairly ugly, but will work to
trigger module loading and won't result in latency once any device has been
plugged in, since announce will again work.

2. Somehow trigger module loading if there are any clients listening on the
announce port. This seems pretty tricky and requires keeping track of some
new state.

3. Do away with deferred module loading in seq. This is pretty invasive and
would increase the number of modules loaded, but would result in a lot of
deleted code in the kernel and a clean fix.

Number 3 is my preferred solution, but I wanted to see if these sorts of
patches would be acceptable, since it is invasive and would result in more
modules loaded.


Thanks for any comments.


Adam
