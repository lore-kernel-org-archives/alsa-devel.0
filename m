From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: _test_channels() / plug:surround51 /
	Hardware	Mixing And dmix / SW or HW Resampling / Volume Control
Date: Thu, 28 Sep 2006 10:40:59 -0400
Message-ID: <1159454460.7086.23.camel@mindpipe>
References: <6.2.1.2.2.20060928013552.16a4b928@mailone.real.com>
	<s5hhcys2kr2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hhcys2kr2.wl%tiwai@suse.de>
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
Cc: Alsa Developement <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-09-28 at 15:17 +0200, Takashi Iwai wrote:
> > ALSA library version 1.0.9rc2 and later is using dmix by default.
> > In the case of the sound card supporting hardware mixing, should a
> > demanding media application prefers another device name because
> > "default" is now configured with dmix?
> 
> Yes.
> 

Really?  I thought the "default" device was supposed to do the right
thing, hardware mixing or not.

Lee


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
