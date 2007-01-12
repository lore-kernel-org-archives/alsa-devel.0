From: Daniel Jacobowitz <drow@false.org>
Subject: Re: vt1617a build ops
Date: Fri, 12 Jan 2007 12:43:39 -0500
Message-ID: <20070112174339.GA29732@nevyn.them.org>
References: <20070112163629.GA27902@nevyn.them.org>
	<s5hfyaggp1c.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hfyaggp1c.wl%tiwai@suse.de>
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

On Fri, Jan 12, 2007 at 05:58:39PM +0100, Takashi Iwai wrote:
> At Fri, 12 Jan 2007 11:36:29 -0500,
> Daniel Jacobowitz wrote:
> > 
> > This patch connects the extra vt1616 controls for the vt1617a, which
> > is necessary to control the rear speakers on e.g. a Shuttle SN25P.
> > 
> > Signed-off-by: Daniel Jacobowitz <drow@false.org>
> 
> Can this be applied independently from your ganged controls patch,
> right?

Yes, it just adds the new controls (Alternate Level to Surround Out,
Downmix LFE and Center to Front, Downmix Surround to Front).  Then
you can fix them; the default power-on settings are wrong for 5.1.

-- 
Daniel Jacobowitz
CodeSourcery

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
