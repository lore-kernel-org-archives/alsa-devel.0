From: "Sam Revitch" <sam.revitch@gmail.com>
Subject: Re: stateful reconnect with snd-usb-audio
Date: Wed, 21 Jun 2006 23:20:29 -0700
Message-ID: <8d4807d50606212320t29d03c02sdee19658527b013a@mail.gmail.com>
References: <8d4807d50606121405n51edef2au3de163b01029aaf5@mail.gmail.com>
	<Pine.LNX.4.61.0606141543260.10637@tm8103.perex-int.cz>
	<s5hodwv961d.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0606141645450.10637@tm8103.perex-int.cz>
	<8d4807d50606141020w8e29a50t6b97528d7e82a0c5@mail.gmail.com>
	<8d4807d50606150304o5ae2ccd0xf7af2f4ccf38ec4c@mail.gmail.com>
	<s5hver1777i.wl%tiwai@suse.de>
	<8d4807d50606170123k51bf2db5ma673b071c8e18d4b@mail.gmail.com>
	<8d4807d50606170201t4922fd68x9fed2694657ae594@mail.gmail.com>
	<s5h1wtkhva7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h1wtkhva7.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

On 6/20/06, Takashi Iwai <tiwai@suse.de> wrote:
> The patch still has a problem with ac97_codec.c that has also own
> lowlevel device.  opl3 and opl4 have to be fixed.
>
> Looking through the patch, I found that unregister callback can be
> replaced simply with disconnect + free.  This will remove the
> complexity a bit.  I'll try to make another patch based on yours.

Thanks for looking at this and fixing it, and sorry to take so long to
get back to ya.  I tried out the patch that you sent out earlier and
it definitely behaves correctly when pulling cables with my USB card
and also seems to pass the alsasound restart loop test.  Eliminating
dev_unregister seems appropriate, as dev_disconnect was being called
every time anyway and the former certainly became redundant.  IMHO the
patch you sent is complete or very close.

-Sam Revitch

All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
