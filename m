From: Martin Langer <martin-langer@gmx.de>
Subject: Re: trident driver bug
Date: Wed, 19 Mar 2003 21:18:50 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030319201849.GA14297@tuba.home>
References: <200303191810.h2JIA2o01270@linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200303191810.h2JIA2o01270@linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 19, 2003 at 01:10:02PM -0500, Paul Davis wrote:
> there still appears to be a bug in the trident driver. i have been
> running jack with a period size of 1024, and it works fine. when i
> change that to 4096 frames, the kernel does a hard oops, with the oops
> occuring in enable_hlt(). the rest of the trace doesn't make much
> sense, and i cannot feed it to ksymoops because the machine locks
> hard.  what can i do to make it eas(y|ier) to debug?
> 

... just having a short view to the sourcecode, I saw that the maxbuffer for
playback is bigger than the rest (spdif, capture,..). Maybe this is a bug,
but I don't have either the hardware nor the documentation for the trident.
So it's possible that I'm totally wrong here...

... it's just an idea to change that buffersize to the smaller buffersize 
like capture/spdif (128*1024) instead of original size (256*1024).


good luck!
martin


-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
