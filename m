From: tom burkart <alsa@aussec.com>
Subject: Re: Help fix driver for YMF-744B on Toshiba Tecra 8100?
Date: Fri, 20 Feb 2004 11:35:27 +1100 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0402201128170.1173@home.aussec.com>
References: <Pine.LNX.4.58.0402181132500.19312@laptop.localdomain>
 <40350050.1040901@elf.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40350050.1040901@elf.org>
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

On Feb 19, Roger E Critchlow Jr wrote:

> In each case, I looped through 10 reloads of alsa, found the
> exact same machine state after each reload, but some of the
> reloaded states produced functional sound while others produced
> noise.
When I load the toshiba kernel module, then the alsa driver, set the mixer
settings, then I have sound most of the time (under an old version of
gnome).
The other option is to unload alsa and load the ymfpci module (kernel/oss)
and there is sound (guaranteed every time).

My intention was to compare the low level code of the kernel oss driver
with the alsa driver and see what they do differently.
My initial guess is that the initialisation is done slightly
differently...
Alas, I haven't had the chance to do so... (yet).

tom.
Consultant

AUSSEC    Phone: 61 4 1768 2202
339 Blaxland Rd., Ryde NSW 2112
Email: tom@aussec.com


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
