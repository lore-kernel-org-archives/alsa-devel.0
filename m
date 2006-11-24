From: Pavel Polischouk <pavelvp@inbox.ru>
Subject: Re: [PATCH 1.0.13 1/2] M-Audio USB
Date: Fri, 24 Nov 2006 14:49:20 -0500
Message-ID: <45674CC0.3080002@inbox.ru>
References: <45667692.8090600@inbox.ru> <s5hfyc9f3i6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hfyc9f3i6.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> The patch is broken (likely due to your mailer).
> Please either fix it or use attachments if not fixable.
> Also, better to make a patch against HG tree.
>   
Resending a patch against latest HG. Will be in separate mails.
> BTW, please check kernel condig-style (Documentation/CodingStyle) and
> try to follow it.  Your patch introduces many braces for single-line
> if's.
Ah. I fixed that already 2 days ago, but lost the very latest version, 
had to re-do it from earlier debugging patch.
> Interresting, it seems to be enough to reset each interface just before
> setting it again. As far as I remember, the windows driver first reset all
> interfaces in a row before resetting the ones that correspond to the user
> mode selected.
I know this is an overkill. But it WorksForMe (TM). I can look at moving 
this reset into a place where it is called only once per interface.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
