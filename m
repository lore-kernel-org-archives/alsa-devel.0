From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Oops in snd_emu10k1_efx_playback_prepare
Date: Wed, 23 Mar 2005 15:41:09 -0500
Message-ID: <1111610469.4848.15.camel@mindpipe>
References: <1110347780.7123.21.camel@mindpipe>
	 <s5hbr9t5efx.wl@alsa2.suse.de> <s5h8y4x5btl.wl@alsa2.suse.de>
	 <s5his40wx9t.wl@alsa2.suse.de> <1110490545.14297.9.camel@mindpipe>
	 <s5hll8uup1p.wl@alsa2.suse.de> <1111203050.12740.7.camel@mindpipe>
	 <1111203432.12740.13.camel@mindpipe>  <s5hsm2m1tnn.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <s5hsm2m1tnn.wl@alsa2.suse.de>
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
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2005-03-23 at 12:35 +0100, Takashi Iwai wrote:
> The calculation of mix pointer seems wrong when the voices are
> allocated from the tail of voice table and back to 0 (e.g. voice 30,
> 31, 0, 1, 2, ...)
> 
> Could you try the patch below?
> 

Takashi-san,

It seems to work.

Thank you very much for cleaning up this code.  This was my first
serious attempt at hacking a Linux driver, and it would not have been
possible without help from you and everyone else on this list.

Lee



-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
