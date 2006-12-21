From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Two USB audio devices, kobject_add failed
Date: Thu, 21 Dec 2006 09:23:55 -0800
Message-ID: <20061221092355.75207a9f.zaitcev__48671.7700413012$1166721953$gmane$org@redhat.com>
References: <9e4733910612200834g14804e44xafb5b0f434e87ba4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3191E28A
	for <alsa-devel@alsa-project.org>; Thu, 21 Dec 2006 18:25:35 +0100 (MET)
In-Reply-To: <9e4733910612200834g14804e44xafb5b0f434e87ba4@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jon Smirl <jonsmirl@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux-usb-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 20 Dec 2006 11:34:48 -0500, "Jon Smirl" <jonsmirl@gmail.com> wrote:

Adding list to cc:

> My new WebCam is a USB audio device and so is my sound system, PSC805.
> When I boot sound doesn't initially work. If I unplug the PSC805 and
> plug it back in again I get this. I don't get this using  only one
> device at a time.
> 
> [  176.243298] usb 2-2: configuration #1 chosen from 1 choice
> [  176.298092] kobject_add failed for card1 with -EEXIST, don't try to register things with the same name in the same directory.
> [  176.298125]  [<c01e690f>] kobject_add+0x10f/0x190
> [  176.298156]  [<c023d1b7>] device_add+0xb7/0x530
> [  176.298177]  [<c01e65df>] kobject_get+0xf/0x20
> [  176.298184]  [<c01e69eb>] kobject_init+0x2b/0x40
> [  176.298201]  [<c023d6c8>] device_create+0x88/0xc0
> [  176.298220]  [<f8a21b87>] snd_card_register+0x2b7/0x320 [snd]
> [  176.298253]  [<f8867c74>] usb_driver_claim_interface+0x84/0xb0 [usbcore]

Jon, sorry for the finger-pointing, but you better take it up with ALSA
people. It seems that snd_usb_audio_create calls snd_card_new incorrectly,
but I have no idea what the constrains on the ID are, so I won't try to
make a patch here.

-- Pete

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
