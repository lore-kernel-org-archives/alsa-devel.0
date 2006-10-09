From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Surround sound and volume control question
Date: Mon, 09 Oct 2006 09:55:23 -0400
Message-ID: <1160402124.629.16.camel@mindpipe>
References: <20061008222726.GA23855@nevyn.them.org>
	<s5hiritr4nm.wl%tiwai@suse.de> <20061009134539.GA13343@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061009134539.GA13343@nevyn.them.org>
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

On Mon, 2006-10-09 at 09:45 -0400, Daniel Jacobowitz wrote:
> > alsactl save & restore should work for softvol.
> > The softvol mixer element doesn't exist only at the very fresh state.
> 
> I see, I just tried it and alsactl will create a user control just
> fine.  That's great.
> 
> I will give the softvol solution a try, and post the patches if it
> works.
> 

Isn't it inefficient to force all audio to go through a software volume
control just to have a master volume?  Wouldn't it be better to make a
ganged control in the driver (until the alsa-lib abstract mixer layer is
ready)?

Lee


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
