From: Luke Ross <luke@lukeross.name>
Subject: Re: BROKEN: Support for non-standard rates in USB
	audio driver
Date: Mon, 18 Dec 2006 06:31:09 -0500
Message-ID: <20061218113109.GE22837@lukeross.name>
References: <em2phs$kff$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <em2phs$kff$1@sea.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Matthias Urlichs <matthias@urlichs.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Matthias,

On Sun, Dec 17, 2006 at 06:53:48AM +0000, Matthias Urlichs wrote:
> 
>     [ALSA] Support for non-standard rates in USB audio driver
> 
> ... because it caused this crash in snd_interval_list:
> 
>  EFLAGS: 00010202   (2.6.18-1.33 #10)
>   [<f0a326a4>] snd_pcm_hw_rule_list+0x22/0x29 [snd_pcm]
>   [<f0a2e8d2>] snd_pcm_hw_refine+0x260/0x3b5 [snd_pcm]

Are you running on a 64-bit machine?

I wrote the patch on i386, but since it got committed have tried it on 
an x86_64 kernel and found that it causes this problem on opening the 
sound device. I've been trying to work out why[1], but haven't been to 
figure out whether it's because the code is 64-bit unsafe (I can;t see 
antyhing obvious) or because of some other reason..

Regards,

Luke

[1] http://article.gmane.org/gmane.linux.alsa.devel/40456

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
