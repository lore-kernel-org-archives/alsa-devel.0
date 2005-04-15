From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH]usx2y: prevent oops & dead keyboard on hot
 usb unplugging
Date: Fri, 15 Apr 2005 09:07:46 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0504150905420.6313-100000@studcom.urz.uni-halle.de>
References: <20050414185930.36889.qmail@web26505.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050414185930.36889.qmail@web26505.mail.ukl.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: karsten wiese <annabellesgarden@yahoo.de>
Cc: Takashi Iwai <tiwai@suse.de>, Devel Alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

karsten wiese wrote:
> Please commit the patch.
>
> - snd_card_free_in_thread((snd_card_t*)ptr);
> + snd_card_free((snd_card_t*)ptr);

What happens when you unplug the device while it's still playing?

> Whats the use of:
> 	chip->num_interfaces--;
> 	if (chip->num_interfaces <= 0) {
> in snd_usb_audio_disconnect() ?
> is snd_usb_audio_disconnect() called for each usb
> interface?

Yes, the kernel interface treats each interface as a separate device.


Regards,
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
