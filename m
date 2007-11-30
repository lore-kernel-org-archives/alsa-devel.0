From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Some drivers don't create all necessary
	sysfs	symlinks
Date: Fri, 30 Nov 2007 01:24:09 +0100
Message-ID: <20071130002409.GA21364@tango.0pointer.de>
References: <20071125210832.GD17108@tango.0pointer.de>
	<s5hd4txpin4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A6C82438C
	for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2007 01:24:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hd4txpin4.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 26.11.07 08:31, Takashi Iwai (tiwai@suse.de) wrote:

> > Hi!
> > 
> > Apparently not all ALSA drivers set the "device" symlink
> > properly. This creates problems with HAL which then is unable to
> > manage permissions to those files properly. One example of such a
> > driver is EMU10K1X.
> 
> Fixed for emu10k1x now.  I thought I had fixed all drivers but this
> one seems forgotten.

Hmm, is it possible that sb16 has similar issues?

There have been some reports that HAL doesn't discover sb16 devices
correctly either:

https://bugzilla.redhat.com/show_bug.cgi?id=389681

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
