From: John Rigg <ad@carbon-black.co.uk>
Subject: Re: pcm_multi poll timeout error
Date: Tue, 1 Aug 2006 23:58:15 +0100
Message-ID: <20060801225815.GB2782@localhost.localdomain>
References: <20051209171605.GA4132@localhost.localdomain>
	<200512091755.jB9HtR5i008279@sith.maoz.com>
	<20051209201502.GA3751@localhost.localdomain>
	<s5h4q5ezh4e.wl%tiwai@suse.de> <1154397867.14540.5.camel@mindpipe>
	<s5hmzao91nj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hmzao91nj.wl%tiwai@suse.de>
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
Cc: John Rigg <ad@carbon-black.co.uk>, Lee Revell <rlrevell@joe-job.com>, alsa-devel@lists.sourceforge.net, Paul Davis <paul@linuxaudiosystems.com>, Jeremy Hall <jhall@maoz.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 01, 2006 at 12:43:44PM +0200, Takashi Iwai wrote:
> It's an "undefined behavior".
> I suppose that software-linked PCM streams do right thing, but we need
> to investigate the detail.
> 
> John, could you check whether the problem still appears with the
> latest ALSA HG version, especially with alsa-lib?  I remember that
> some fixes have been done on multi plugin.

Yes, I'll check it. Might be a few days before I get time though.

John

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
