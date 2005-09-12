From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] add a symlink to module in /sys/pci/drivers/*
Date: Mon, 12 Sep 2005 09:31:56 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0509120929320.27286-100000@studcom.urz.uni-halle.de>
References: <s5hacilqb2t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hacilqb2t.wl%tiwai@suse.de>
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
Cc: Laurent Riffard <laurent.riffard@free.fr>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Laurent Riffard wrote:
> >
> > Following a thread on LKML
> > (http://marc.theaimsgroup.com/?l=linux-kernel&m=112569665717371),
> > here is a patch which adds a symlink to the kernel module in the
> > /sys/pci/drivers/* directories for all the drivers located in
> > linux/sound/pci/.
>
> It's a known problem but we didn't fix it because of compatibility
> with 2.2/2.4 kernels.  We'll solve this problem later.

Solved now.


Regards,
Clemens



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
