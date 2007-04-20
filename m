From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Strange code in
Date: Fri, 20 Apr 2007 15:26:38 -0700
Message-ID: <20070420152638.1834b1b5.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, zaitcev@redhat.com, linux-usb-devel@lists.sourceforge.net, j.w.r.degoede@hhs.nl
List-Id: alsa-devel@alsa-project.org

Dear Takashi:

Hans de Goede (on cc:) hits a problem when snd-usb-audio breaks with:
"USB device is in the shutdown state, cannot create a card instance".

This is how the place looks:

	chip = NULL;
	for (i = 0; i < SNDRV_CARDS; i++) {
		if (usb_chip[i] && usb_chip[i]->dev == dev) {
			if (usb_chip[i]->shutdown) {
				snd_printk(KERN_ERR "USB device is in the shutdown state, cannot create a card instance\n");
				goto __error;
			}
			chip = usb_chip[i];
			break;
		}
	}

The code looks broken to me, because dev at this time is a new device
structure, freshly allocated. You cannot compare it with an old instance,
and I don't know why you would want to.

Unfortunately (for fortunately), I have zero clue about the way ALSA
works, specifically rules for snd_device_ops.dev_free, so I am asking
you to look at this problem.

Yours,
-- Pete

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
