From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: (no subject)
Date: Tue, 10 Jan 2006 20:12:01 +0100
Message-ID: <1136920321.43c4070136910@webmail.uni-halle.de>
References: <5C7B81E1-2824-427D-A874-A2504CE695EA@caiaq.de>
 <s5hk6d8f1uv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5hk6d8f1uv.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Daniel Mack <daniel@caiaq.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Daniel Mack wrote:
> > I'm about to write an ALSA driver for a sound hardware we developed
> > and I'm wondering about how to tackle it. It's a USB2.0 hardware
> > which has sound input and output but also some controller elements
> > and MIDI jacks. I'd like to make the controllers accessible by linux'
> > input device interface.
> >
> > The audio part is - for good reasons - not USB class compliant,
> > and assuming that the usb folder in the driver tree only addresses
> > such devices, I pretty much guess this is not the point to start,
> > right?
>
> If it's not USB class compliant, you'll likely need to write a driver
> from scratch.

All PCM devices have to use isochronous transfers, so it might work if you
just hard code the sample format, like, e.g., for the UA-1000.

The synchronization of the PCM output sample rate might be a problem -- if the
device doesn't use a standard USB synchronization mechanism (synchronous/
asynchronous/adaptive), the driver would have to be hacked some more.
(Playback on the UA-1000 doesn't work because the driver doesn't (yet) support
synchronizing the output PCM stream to the input PCM stream.)

The driver currently assumes that each (output/input) PCM endpoint has its
own interface (where it can select alternate settings independently).
Is this the case?


Regards,
Clemens


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
