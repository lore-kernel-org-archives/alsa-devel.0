From: John Rigg <aldev@sound-man.co.uk>
Subject: Re: Need help: My .asoundrc no longer works.
Date: Sat, 20 Jan 2007 14:01:07 +0000
Message-ID: <20070120140107.GC3067@localhost.localdomain>
References: <loom.20070120T001557-202@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <loom.20070120T001557-202@post.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Tim <terminator356@users.sourceforge.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, Jan 20, 2007 at 12:39:20AM +0000, Tim wrote:
> Note the single use of a plug converter. This is the only way
>  I can make them work, converting the emu but not the ice gives 
>  'no playback configs avail', and converting both emu and ice gives
>  ALSA: could not complete read of 0 frames: error = -32
>  cycle execution failure, exiting
>  DRIVER NT: could not run driver cycle.
> 
> At first I though maybe a pcm multi problem. 
> I looked at changes to pcm_multi.c, not much change there, but I 'reverted'
>  a couple of things back to 1.0.9 state, but it didn't fix the problem.
> 
> Anyway, since the problem is always with the 'b' slave,
>  and since the 'b' slave always needs a converter, I'm wondering
>  if there's a problem with the 'plug' converter itself (or my plug sections).

You shouldn't need the plug converter if you specify the slaves channels
correctly. The ice1712 has 12 inputs and 10 outputs (regardless of how
many physical inputs/outputs your card has) and this needs to be
set explicitly in .asoundrc using separate playback and capture device
definitions. See here for explanation:

http://www.sound-man.co.uk/linuxaudio/ice1712multi.html

John

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
