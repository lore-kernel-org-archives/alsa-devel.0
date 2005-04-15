From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH]usx2y: prevent oops & dead keyboard on hot
 usb unplugging
Date: Fri, 15 Apr 2005 17:32:16 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0504151716570.5917-100000@studcom.urz.uni-halle.de>
References: <20050415151440.53982.qmail@web26505.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050415151440.53982.qmail@web26505.mail.ukl.yahoo.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Lee Revell <rlrevell@joe-job.com>, Devel Alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

karsten wiese wrote:
> Erm, you mean the close (for snd_pcm_ops_t,snd_rawmidi_ops_t) and
> release (for snd_hwdep_ops_t) callbacks then? They should all be
> called before snd_card_free()?
> in other words: ...
> the "(card->files == NULL)" MUST be true before
> snd_card_free() can be called safely?

Yes.  The files cannot be removed while they are still opened by an
application.


To make snd_card_free_in_thread() work, We could increase the
reference count of card->dev as long as snd_card_free_in_thread() is
still being executed, but I don't know what happens to the rest of the
kernel if the device cleanup is delayed indefinitely.

Another possibility would be to just not assign the USB device to the
sound card and its files, i.e., just remove the snd_card_set_dev()
call from the USB drivers.  This shouldn't affect anything else
because card->dev isn't used except for the device files.


Regards,
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
