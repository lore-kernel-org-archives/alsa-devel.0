From: Matt Flax <flatmax@ieee.org>
Subject: Re: ozone : 763/2808/100
Date: Wed, 22 Oct 2003 20:18:30 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031022101830.GB13384@mffm.ee.unsw.edu.au>
References: <20031022055332.GA12533@mffm.ee.unsw.edu.au>
Reply-To: Matt Flax <flatmax@pgb.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp3.unsw.edu.au (smtp3.unsw.EDU.AU [149.171.96.70])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA13061
	for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2003 11:02:04 +0200
Content-Disposition: inline
In-Reply-To: <20031022055332.GA12533@mffm.ee.unsw.edu.au>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Matt Flax <flatmax@pgb.unsw.edu.au>
Cc: core sound <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This question was answered by Clemens... here is the reply (and the ID 
does change, I ttested it, however my version still doesn't run with 
snd usb audio)...

Clemens wrote :
No, 0x2808 is the ID for an Ozone without firmware. After the firmware
has been downloaded, the ID changes to 0x2008.

Unfortunately, there isn't a firmware loader for linux. I tried to
write one, but it doesn't work (because of what I think is an
unidentified bug in at least the 2.4 kernels).

It may work if you let the Windows driver initialize the Ozone, and
then reboot into Linux.


On Wed, Oct 22, 2003 at 03:53:32PM +1000, Matt Flax wrote:
> Hi ALSA devs,
> 
> I just got an Ozone ... nice external card.... good for live use ...
> 
> I get the following error in my /var/log/messages
> Oct 21 22:39:45 localhost usb.agent[781]: ... no modules for USB product
> 763/2808/100
> 
> referring to this fix:
> http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg09026.html
> 
> should this be added too ? :
> 
> {
>         USB_DEVICE_VENDOR_SPEC(0x0763, 0x2808),
>         .driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
>                 .vendor_name = "M-Audio",
>                 .product_name = "Ozone",
>                 .ifnum = 3,
>                 .type = QUIRK_MIDI_MIDIMAN,
>                 .data = & (const snd_usb_midi_endpoint_info_t) {
>                         .out_cables = 0x0001,
>                         .in_cables  = 0x0001
>                 }
>         }
> },
> 
> Matt
> 
> 
> -- 
> http://flatmax.org
> 
> WSOLA TimeScale Audio Mod  : http://mffmtimescale.sourceforge.net/
> FFTw C++                   : http://mffmfftwrapper.sourceforge.net/
> Vector Bass                : http://mffmvectorbass.sourceforge.net/
> Multimedia Time Code       : http://mffmtimecode.sourceforge.net/
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by OSDN developer relations
> Here's your chance to show off your extensive product knowledge
> We want to know what you know. Tell us and you have a chance to win $100
> http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 
http://flatmax.org

WSOLA TimeScale Audio Mod  : http://mffmtimescale.sourceforge.net/
FFTw C++                   : http://mffmfftwrapper.sourceforge.net/
Vector Bass                : http://mffmvectorbass.sourceforge.net/
Multimedia Time Code       : http://mffmtimecode.sourceforge.net/


-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
