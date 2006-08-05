From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] pxa2xx-i2sound
Date: Sat, 5 Aug 2006 19:53:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0608051950510.9377@tm8103.perex-int.cz>
References: <200608051937.13845.giorgio@mandarinlogiq.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200608051937.13845.giorgio@mandarinlogiq.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Giorgio Padrin <giorgio@mandarinlogiq.org>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 5 Aug 2006, Giorgio Padrin wrote:

> Hi,
> 
> This is minimal patch updating the pxa2xx-i2sound code in alsa-driver.

Applied, but please, be more verbose in future:

1) one-line patch summary is missing (what patch does)
2) explanation why this patch is required is missing
3) Signed-off-by line is missing

I know, it's really simple patch, but I don't know exactly which problems 
are with the mmap access on the pxa platform (probably DMA memory area 
coherency, right?).

					Thanks,
						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
