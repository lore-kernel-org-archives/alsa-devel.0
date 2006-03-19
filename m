From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Re: How can I deal with this?
Date: Sun, 19 Mar 2006 19:49:14 +0000
Message-ID: <1142797755.9700.12.camel@localhost.localdomain>
References: <1142794869.9700.7.camel@localhost.localdomain>
	 <1142795520.4532.32.camel@mindpipe>
	 <1142795771.9700.9.camel@localhost.localdomain>
	 <1142796695.4532.34.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1142796695.4532.34.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 2006-03-19 at 14:31 -0500, Lee Revell wrote:
> On Sun, 2006-03-19 at 19:16 +0000, Adrian McMenamin wrote:
> > On Sun, 2006-03-19 at 14:11 -0500, Lee Revell wrote:
> > > On Sun, 2006-03-19 at 19:01 +0000, Adrian McMenamin wrote:
> > > > when I play mono my device has one hardware buffer of size 0x8000, when
> > > > I play stereo it has two of size 0x8000
> > > > 
> > > > I have .buffer_bytes_max  and _min set to 0x8000
> > > 
> > > Then .buffer_bytes_max should be 0x10000.  The buffer and period sizes
> > > in your hw_info structure are for the entire buffer, not per channel.
> > > 
> > > 
> > And double period max too I assume?
> > 
> > 
> 
> If the hardware can do that, yes.
> 
> The hw_info structure should merely specify the hardware characteristics
> - you are not trying to change the behavior if the middle layer.
> 

Doing any of this doesn't fix the problem in any way :(


I still get the bug reports when the play position extends beyond the
0x2000 frames point. I think I am going to have to mess about with the
firmware




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
