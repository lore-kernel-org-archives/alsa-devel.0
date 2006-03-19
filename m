From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: How can I deal with this?
Date: Sun, 19 Mar 2006 15:43:21 -0500
Message-ID: <1142801002.4532.39.camel@mindpipe>
References: <1142794869.9700.7.camel@localhost.localdomain>
	 <1142795520.4532.32.camel@mindpipe>
	 <1142795771.9700.9.camel@localhost.localdomain>
	 <1142796695.4532.34.camel@mindpipe>
	 <1142797755.9700.12.camel@localhost.localdomain>
	 <1142800418.9700.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1142800418.9700.15.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 2006-03-19 at 20:33 +0000, Adrian McMenamin wrote:
> On Sun, 2006-03-19 at 19:49 +0000, Adrian McMenamin wrote:
> 
> > 
> > 
> > I still get the bug reports when the play position extends beyond the
> > 0x2000 frames point. I think I am going to have to mess about with the
> > firmware
> > 
> That seems to have fixed the problem :)
> 
> Though it poses an issue if I try to use any more of the 64 channels
> this thing has - I'll have to keep shrinking the play back buffers per
> channel!
> 

Yep, exactly - most hardware has fixed buffer size and variable number
of channels so more channels requires smaller period sizes.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
