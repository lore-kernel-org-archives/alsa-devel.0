From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: [PATCH] control, hw,
	rawmidi: accept control	device node as card identifier when opening
Date: Tue, 12 May 2009 14:32:30 +0200
Message-ID: <20090512123229.GB29607@tango.0pointer.de>
References: <20090511224130.GA10955@omega>
	<alpine.LNX.2.00.0905120744260.25064@eeebox2.perex-int.cz>
	<alpine.LNX.2.00.0905121336130.25064@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id A95EC103840
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 14:32:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0905121336130.25064@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 12.05.09 13:40, Jaroslav Kysela (perex@perex.cz) wrote:

> 
> On Tue, 12 May 2009, Jaroslav Kysela wrote:
> 
> > On Tue, 12 May 2009, Lennart Poettering wrote:
> >
> >> Heya!
> >> 
> >> Traditionally low-level ALSA devices are opened with device strings like
> >> 'hw:CARD' where CARD is either a numeric index or a card name. This
> >> patch introduces a third syntax that allows you to specify the file name
> >> of the control device node. The purpose for this is to make ALSA a bit
> >> more like other Linux devices and allow implementaiton of udev device
> >> symlinks similar to how disks are currently handled, with
> >> /dev/disk/by-path/xxxx /dev/disk/by-id/xxxx and so on.
> >> 
> >> With this patch this line:
> >>
> >>  aplay -f CD -D hw:/dev/snd/controlC0 < /dev/urandom
> >> 
> >> becomes equivalent to this line:
> >>
> >>  aplay -f CD -D hw:0 < /dev/urandom
> >> 
> >> A more useful example is this:
> >>
> >>  aplay -f CD -D hw:/dev/snd/by-path/pci-0000:00:1a.7-usb-0:2:1.2
> >> 
> >> (this line requires a a few additional udev rules)
> >> 
> >> This only works for control devices nodes, not for PCM or any other
> >> device nodes. Since the control device node is used as 'entry point'
> >> when opening PCM devices this is no limitation.
> >
> > NAK. Passing control device to open() functions is not a good idea. The 
> > snd_card_get_index() function might be extended to allow /dev style argument. 
> > Returned card index can be used as argument for hw: devices without this 
> > massive change.
> >
> > http://git.alsa-project.org/?p=alsa-lib.git;a=commit;h=33ab0b5381c87e151e87e5000964edd868484886
> 
> I just noticed that snd_card_get_index() is used to parse "card" 
> configuration item when it's string, so control device name can be passed 
> instead card identification to all open() functions in alsa-lib with my 
> above patch, too. But it's preferred to use direct card index to reduce
> control device open/close sequences.

With my original patch there are no superfluous opens.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
