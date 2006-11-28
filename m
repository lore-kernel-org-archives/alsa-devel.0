From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: SM501 driver development: problem with start of
 playback
Date: Tue, 28 Nov 2006 09:32:39 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0611280930160.29580@tm8103.perex-int.cz>
References: <20061127183451.71080@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061127183451.71080@gmx.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jonas Eymann <sm501_dev@gmx-topmail.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 27 Nov 2006, Jonas Eymann wrote:

> when I check the appl_ptr in the trigger callback, it gives me exactly 
> one period of available data. As soon as we are in the copy function 

Which tool do you use for tests? Could you try aplay and send us also 
debug output (aplay -v <xxxx>)? It might be sw_params setup problem.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
