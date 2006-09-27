From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Driver design question
Date: Wed, 27 Sep 2006 09:58:53 -0400
Message-ID: <1159365534.1275.8.camel@mindpipe>
References: <45095921020000C80000961F@emea1-mh.id2.novell.com>
	<1158331680.7948.156.camel@mindpipe>  <s5h64fjj3aj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h64fjj3aj.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-09-19 at 17:15 +0200, Takashi Iwai wrote:
> The workq task is a pseudo-DMA engine that runs in background.
> When it's woken up, it feeds data from intermediate buffer to hardware
> as much as possible.  The available data can be found in
> 
> If all data are fed, it sleeps again (or exit
> the task).  The timer wakes up or schedule the new workq task. 

I think something is missing - the available data can be found where?

Lee


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
