From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: Creative MP3+ or Hercules Muse Pocket
Date: Wed, 05 May 2004 00:06:05 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <yw1xr7tzj19u.fsf@kth.se>
References: <1083645143.18667.22.camel@pheuri> <20040504215346.GD20897@fliwatut.scifi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Frank Barknecht <fbar@footils.org> writes:

> Hallo,
> Robin Cook hat gesagt: // Robin Cook wrote:
>
>> Trying to find out if either or both of the Creative Soundblaster MP3+
>> or the Hercules Muse Pocket usb sound cards are supported by the usb
>> driver in ALSA?
>> 
>> If so are is there anything special that needs to be done to get them
>> setup under alsa?
>
> Normally these cards just all use the snd-usb-audio driver. If you run
> kernel 2.6 you can just "modprobe snd-usb-audio" to get sound. I never
> hear of the Hercules card, but it looks very cool with that knob,
> which might even work as an input device on Linux. This would then
> maybe require the hid/event interface of the USB system in the kernel,
> which is not part of ALSA.

Isn't the knob just a volume control?  It wouldn't need to send
anything to the computer.

-- 
Måns Rullgård
mru@kth.se



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
