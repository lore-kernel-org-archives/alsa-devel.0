From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: OpenAL - ALSA interface proposal. I request for
 comments...
Date: Mon, 15 Dec 2003 03:20:35 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FDD2883.7060106@superbug.demon.co.uk>
References: <1071455606.17638.45.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1071455606.17638.45.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: manuel.jander@mat.utfsm.cl
Cc: Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Manuel Jander wrote:
> Hi,
> 
> Since there is almost nothing else to do to support the Aureal Vortex 
> 3D processor on Linux, just as i announced some time ago i started
> designing a OpenAL interface for ALSA. The design is meant to be
> applicable to other hardware too.
> 
> I made a preliminary description, from what i have done so far, because
> i want to allow other more experienced people to comment and give input
> to this.
> 
> I posted it in plain text. I hope that is compatible enough.
> http://galadriel.mat.utfsm.cl/~mjander/aureal/alsa/OpenAL-ALSA.txt
> 
> Well, please give it a read, and tell what do you think about. Thank you
> very much.
> 
> Best Regards

It does not seem like you have read much about alsa. The interface 
between alsa-kernel and alsa-lib is liable to change at any point 
whereas the alsa-lib to application api might change, but will always 
ABI compatible.

If there are features of a sound card that you cannot access via 
alsa-lib, just find ways to add them to alsa-lib first. Everything 
needed on the hardware should be accessible via alsa-lib.

Cheers
James


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
