From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: tascam us-122 midi in does not work
Date: Tue, 15 Jun 2004 01:10:31 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200406150110.31355.annabellesgarden@yahoo.de>
References: <200406131307.21072.ws@seh.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200406131307.21072.ws@seh.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Werner Schweer <ws@seh.de>
List-Id: alsa-devel@alsa-project.org

Am Sonntag 13 Juni 2004 13:07 schrieb Werner Schweer:
> Hello,
>
> Some strange effect occurs on my tascam us-122 audio/midi usb
> device:
>    After starting JACK the midi input does not work anymore. Not even
> the midi in led on the us-122 flashes. Midi output is always fine.
> After stopping JACK midi input still does not work. Midi input works
> again after disconnect/reconnect the usb cable.
> I'm using current ALSA cvs and kernel 2.6.7rc3.
>
Didn't try that kernel yet.

To see more, you can change snd_usbmidi_urb_error() in alsa-kernel:141 to look 
like that:
>>>>>>
static int snd_usbmidi_urb_error(int status)
{
	snd_printk(KERN_ERR "urb status %d\n", status);
	if (status == -ENOENT)
		return status; /* killed */
	if (status == -EILSEQ ||
	    status == -ECONNRESET ||
	    status == -ETIMEDOUT)
		return -ENODEV; /* device removed/shutdown */
	return 0; /* continue */
}
<<<<<<

If this shows a status that causes a negativ return value when you start jack, 
change snd_usbmidi_urb_error() further more so it returns 0 in that case.
that can crash the machine or help......

regards,
Karsten


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
