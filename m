From: "fmoraes74@netzero.net" <fmoraes74@netzero.net>
Subject: Re: Sigmatel STAC9708/011
Date: Fri, 18 Jun 2004 14:08:44 GMT
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040618.070852.28484.27682@webmail27.nyc.untd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de
Cc: fmoraes74@netzero.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Well, for some reason I don't see the control anymore on gnome-alsamixer or alsa-mixer. It used to be the last one displayed and it is not there anymore.

How can I debug this? I will take a look at the ac97 document but I was pretty sure about this.

Also, do you have any idea of why I am hearing noise/cracks when I record at 8Khz instead of 48Khz?

Francisco

-- Takashi Iwai <tiwai@suse.de> wrote:
At Fri, 18 Jun 2004 02:43:55 GMT,
fmoraes74@netzero.net wrote:
> 
> 
> On ALSA 1.0.4, there was a control called Sigmatel on the mixer for
> the emu10k1x STAC9708/011 mixer. 
> 
> Now, on ALSA 1.0.5a, the control is gone even though I could use it
> to control the volume of one of the hardware buffers. 
> 
> Any reason for the removal? If the removal is needed, should I add it back?

Hmm?  It's still there.

In pci/ac97/ac97_codec.c:

static const ac97_codec_id_t snd_ac97_codec_ids[] = {
...
{ 0x83847608, 0xffffffff, "STAC9708/11",	patch_sigmatel_stac9708,	NULL },


Takashi


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel


________________________________________________________________
The best thing to hit the Internet in years - NetZero HiSpeed!
Surf the Web up to FIVE TIMES FASTER!
Only $14.95/ month -visit www.netzero.com to sign up today!


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
