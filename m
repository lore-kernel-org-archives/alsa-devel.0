From: Daniel Jacobowitz <drow@false.org>
Subject: Re: Ganged volume
Date: Fri, 12 Jan 2007 11:34:12 -0500
Message-ID: <20070112163412.GA27450@nevyn.them.org>
References: <20061014203737.GA22315@nevyn.them.org>
	<20070102035118.GA30626@nevyn.them.org>
	<s5hirfcgqrm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hirfcgqrm.wl%tiwai@suse.de>
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

On Fri, Jan 12, 2007 at 05:21:17PM +0100, Takashi Iwai wrote:
> Thanks for the patch (and sorry for the delayed review).  The code
> looks good now.
> 
> One remaining concern is how we can integrate this with the existing
> ac97_quirk stuff.  For example, if a quirk tweaking the master
> volume/switch is applied, this may conflict with the ganged volumes.
> In other words, the ganged controls should be applied _after_ the
> quirks.
> 
> Then I'm considering whether it might be rather easier to implement
> the virtual master element from the beginning.  Basically, the virtual
> master is required for almost all codec chips with the surround
> support, not only for VT161x.  So, featuring this as default isn't bad
> in the end.
> 
> Oh, also, TLV support is another thing to do.
> This should be relatively easy, though.

I agree on both points, but I don't think I can do it myself without
breaking lots of other cards.  At this point, maybe someone else
is interested in picking up this patch?

Oh, and in that case, I will post the minimal bits for VT1617A
surround separately.

-- 
Daniel Jacobowitz
CodeSourcery

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
