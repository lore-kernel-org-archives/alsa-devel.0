From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] Recording AUX on ak4531 (e.g. es1370)
Date: Sat, 28 Feb 2004 11:49:25 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0402281148510.1880@pnote.perex-int.cz>
References: <20040228114133.140cfa42.r.ragusa@libero.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040228114133.140cfa42.r.ragusa@libero.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Roberto Ragusa <r.ragusa@libero.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 28 Feb 2004, Roberto Ragusa wrote:

> Hi,
> 
> after going from kernel 2.4 to 2.6 (and so switching to alsa) I noticed
> it wasn't possible to record the aux signal on my es1370 (this is TV
> audio in my case).
> 
> I had a look at the code and resolved the problem with this small patch,
> for kernel 2.6.3.
> Surprisingly enough, the fix is just related to a string, but I see
> that there are no "Input Route" in sound/* (only "Capture Route"),
> so it should be right.

Thanks for this report. Applied to CVS.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
