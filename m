From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: Tascam US-224/428 MMC: Work in progress...
Date: Wed, 28 Jul 2004 17:24:37 +0100 (WEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <63176.195.245.190.93.1091031877.squirrel@195.245.190.93>
References: <33466.195.245.190.93.1089901175.squirrel@195.245.190.93>
    <s5h1xix5ygj.wl@alsa2.suse.de>
    <14675.195.245.190.93.1090939828.squirrel@195.245.190.93>
    <200407281723.39162.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200407281723.39162.annabellesgarden@yahoo.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net, ardour-dev <ardour-dev@lists.ardour.org>
List-Id: alsa-devel@alsa-project.org

Hi Karten,

(about alsa-tools/us428control patch...)

> works fine here during a first test with us428 @ latest ardour
> 0.9beta18.4:
> Transport buttons and lights do as expected except the green PLAY light
> doesn't burn if I start playback from within ardour.

The fact is that ardour is not sending the MMC-Play command when one
starts playback in it. Don't know why, but aparently is ardour's fault.
I've been digging on ardour source but didn't reach the culprit. AFAICT,
it's supposed to send a MMC-Play (or a MMC-DeferredPlay, which
us428control reads the same) when the transport is being started.

Does anyone on ardour-devel would like to comment?

If only ardour would actually send that missed MMC-Play command, the LED
would be lit exactly as happens on the other way around: pushing the PLAY
button on the us-224/428 control surface. Actually, when you push the PLAY
button, the corresponding LED gets on and a MMC-Play command does actually
get sent out. Ardour then responds graciously by starting playback :)


>
> Position scrolling with wheel acts peculiar: first as expected, then after
> having stoped wheeling the cursor sort of repeats its last movement.
> Didn't dig, so don't know who is to blame.
>

Yep, I notice similar behaviour, with ardour playhead skipping back and
forward, now and then, if not always :)

I guess that's most likely due to something as a race condition between
ardour and us428control: by turning the jog wheel a MMC-Locate command is
sent to ardour, based on an internal absolute wheel position; then ardour
updates its playhead and sends its own MMC-Locate back to us428control,
which updates that very same wheel position accordingly.

The problem is obvious: sometimes you turn the jog wheel quite faster then
ardour's MMC-Locate feedback, causing some stumbling on the playhead
cursor behaviour.

Gotta solve this race but can't figure how right now. Any suggestion?

Of course this happens only if ardour and us428control are wired as a
MIDI-MMC closed loop, which will be perfectly normal IMO.


> Fine stuff, thanks Rui!

Thanks to you too, Karsten.

>
> P.S.: patch is CVS ready from my point of view, functionality wise.
>

Yes, I think so. Given that wheel/locate annoyance it's not being
considered a showstopper ;)

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
