From: Rusty Phillips <rustyp@freeshell.org>
Subject: Re: Omnistudio USB
Date: Fri, 14 Jan 2005 12:01:10 -0500
Message-ID: <1105722071.1897.9.camel@localhost.localdomain>
References: <Pine.HPX.4.33n.0501141230020.25187-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0501141230020.25187-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Using the current CVS I can apply most of that patch at fuzziness level
3 (which could still cause problems), but not the last hunk.  I can
probably figure it out and patch manually.

But if it's easy for you to do, could you tell me what you're actually
patching if not the current CVS (at cvs.alsa-project.org)?

Thanks!

Rusty Phillips
			
On Fri, 2005-01-14 at 12:34 +0100, Clemens Ladisch wrote:
> Rusty Phillips wrote:
> > Okay, I've been trying most of my testing with the first two channels.
> >
> > However, I just figured out that recording and playback works on
> > channels #3 and #4 at 96000.
> 
> The first two channels use an additional 16-bit interface, probably
> for compatibility with the Windows USB Audio driver.
> 
> Please try the patch below.
> 
> 
> HTH
> Clemens
> 




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
