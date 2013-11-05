From: nb <nb@dagami.org>
Subject: Re:
	=?utf-8?q?snd-hda-intel_with_ALC880_on_a_ASUS_W5A_si?=
	=?utf-8?q?nce_patch=0967b6ec3196da235317ff1b9474f17379b78f3294?=
Date: Tue, 05 Nov 2013 21:49:19 +0100
Message-ID: <2d8829451cfac9190d2eba9152ed690b@webmail.dagami.org>
References: <49f961629c875a3a72b8528a9c967b66@webmail.dagami.org>
 <s5hli13vvwh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dagami.org (colibri.dagami.org [82.226.230.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 94AB6261615
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 21:49:22 +0100 (CET)
In-Reply-To: <s5hli13vvwh.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> Looking at alsa-info.sh outputs, all pins have invalid configurations
> (0x0).  It means BIOS doesn't set up pins at all properly, thus you
> have to define the pin configurations manually.

Im not surprised, the laptop is 8 years old. But it still works 
perfectly

> For that, we need to identify which pin corresponds to which I/O.
> The first thing to know is: what I/Os does your machine have?
> List up all I/Os, e.g. a green headphone output at front side, a red
> mic jack at left side, an internal mic, a built-in speaker, etc.

I'm not sure this is what you are asking for. Trying to draw it.

                        +--------+
                        |        |
                        |       *| <- internal mic (it's a hole)
                        |       *| <- button for muting internal mic
                        |        |
                        |        |
    internal speaker -> | *    * | <- internal speaker
                        ----------
                       /         /
                      /         / <- jack 3.5 (headphone) black
                     /         / <- jack 3.5 (mic) black
                    /_________/ <- volume button (black)

   There is also a s-video connector at the rear of the dock

> The jacks are usually detectable, and hda-jack-retask or hda_analyzer
> would be your help.  See Documentation/sound/alsa/HD-Audio.txt.

I'm not comfortable with this. I've tried to do the best, but I must 
admit that I don't understand really what it does.

But the fact is that after reading many docs and doing the following, it 
worked:
- run hda-jack-retask, select "Headphone" for pin ID 0x14, then quit
- run alsamixer, choose via F6 "0 HDA Intel" card, unmute every control, 
then quit
- run hda_analyser with the alsa-info output of the non working kernel, 
and for NODE 0x14 PIN check "OUT" in widget control, and uncheck "IN" 
and "HP"

After that headphone output and HP worked.

I know that saying this I'm not clear at all, but I don't understand 
what's happening.

I hope this will "talk" more to you.

> Next, check of each I/O whether it worked with 3.2 kernel.  If yes, in
> which mixer setup.  Then we can guess the internal pins like mic or
> speaker.
