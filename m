From: Martin Soto <soto@informatik.uni-kl.de>
Subject: Re: plug:iec958 problems
Date: Wed, 21 Apr 2004 20:57:37 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1082573856.1244.11.camel@masoft>
References: <1082235536.1243.47.camel@masoft> <s5hfzazq6li.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hfzazq6li.wl@alsa2.suse.de>
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

Hello Takashi!

On Tue, 2004-04-20 at 12:36, Takashi Iwai wrote:
> At Sat, 17 Apr 2004 22:58:57 +0200,
> Martin Soto wrote:
> > As an additional note, this only seems to happen when using plug:iec958.
> > Software decoding the AC3 sound and plying through ALSA, works
> > flawlessly, despite of the fact that the machine load is higher.
> 
> is there any different if you get rid of plug: ?
> as long as the h/w support 16bit LE data, AC3 should work without
> plug.

I just tested. There seems to be no difference. I tried with iec958: and
spdif: instead of plug:iec958:. The problem persists. 

As I said, putting the process in SCHED_FIFO mode doesn't make any
difference at all. Almost any machine activity (any process being active
for more than a fraction of a second) is enough to interrupt the sound.
Does the library use some auxiliary process to play through spdif?

M. S.
-- 
Martin Soto <soto@informatik.uni-kl.de>



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
