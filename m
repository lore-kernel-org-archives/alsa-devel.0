From: "Lonnie Mendez" <lmendez19@austin.rr.com>
Subject: Re: Problem with snd-usb-audio (usbmixer)
Date: Wed, 18 Aug 2004 00:59:02 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <001801c484e8$7640e4e0$0200a8c0@jedi>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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


----- Original Message ----- 
From: "Matt Flax" <flatmax@Matt.Flax>
To: "Lonnie Mendez" <lmendez19@austin.rr.com>
Sent: Wednesday, August 18, 2004 2:26 AM
Subject: Re: [Alsa-devel] Problem with snd-usb-audio (usbmixer)


> What hardware are you trying to use specificly ?

USB-Audio - Burr-Brown Japan PCM2702

    It is pretty much a usb speaker application, which transmitts on
specific fm frequences.  LineX sells these units.  I know it works, as I've
used it standalone with the linux kernel usb audio driver for usb-audio
speakers and other devices... I'm trying to have it run from the alsa
snd-usb-audio driver now.  I've had some luck with configuring a mixer map
for it, if I add entries for VID/PID and set the "ignore get/set error"
variable to 1... however no dsp device seems to exist so I can not test my
progress.  I'm guessing this is going to require not only the custom mixer
map, but an entry in the usbquirks file.  If you need more information from
me, please refer to the info provided in my last few messages... there
should be more than enough to diagnose this one.


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
