From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Surround sound and volume control question
Date: Mon, 09 Oct 2006 10:42:56 -0400
Message-ID: <1160404977.629.22.camel@mindpipe>
References: <20061008222726.GA23855@nevyn.them.org>
	<s5hiritr4nm.wl%tiwai@suse.de> <20061009134539.GA13343@nevyn.them.org>
	<1160402124.629.16.camel@mindpipe>
	<20061009143814.GA14827@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061009143814.GA14827@nevyn.them.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Daniel Jacobowitz <drow@false.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-10-09 at 10:38 -0400, Daniel Jacobowitz wrote:
> I did consider doing it this way over the weekend.  However, being
> able to adjust the relative volumes of the different channels still
> seems useful to me.  If you have a single unified control, then you
> mess up trying to move the others.
> 
> What do you think?  Should I just slave them all together and remove
> the other volume controls?  It's probably easier; it just seems
> somehow lacking.
> 

How do other OSes do it?  Do they also force everything through a
software volume control?

Is a ganged master control fundamentally incompatible with individual
channel volumes?  If so, doesn't it mean that this problem can never be
solved by an abstract mixer layer?

Lee


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
