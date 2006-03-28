From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Changes over dmix: 1.0.11rc4 and future
Date: Wed, 29 Mar 2006 00:00:42 +0100
Message-ID: <4429C01A.7040608@superbug.co.uk>
References: <s5h64lzalr0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h64lzalr0.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Hi,
> 
> it looks like the 1.0.11rc4 announcement isn't sent out, so here I'd
> like to explain what has been changed over dmix recently.
> 
> As of 1.0.11rc4, dmix accepts more flexible buffer sizes than the
> earlier versions did.  The buffer size is basically arbitrary.  The
> only restriction is that it's aligned to the period size, and the
> minimal periods are two.
> 
> With this change, some applications have positive influences, and some
> have negative.  The regression, for example with speaker-test, happens
> because there was no upper limit of buffer size.  It's already fixed
> in the CVS version (by setting max periods = 1024).
> 
> If you have a problem with dmix what didn't happen ago, try to define
> 
> 	defaults.pcm.dmix_variable_buffer false
> 
> in ~/.asoundrc.
> 
> Also, you can try ALSA CVS version.  It includes more fixes about the
> dmix.  Or wait for ALSA 1.0.11-final, which (hopefully) will be
> released soon.
> 
> 
> So far so good.  Now, about the future changes.
> 
> Currently, dmix forks a resource server to share the opened file
> descriptor.  (Don't misunderstand, it's not a mixing server but just
> manages the file descriptor.)  This behavior seems causing troubles in
> some applications.  I've been trying to reduce this mess.
> 
> The below (first one) is a patch to add O_APPEND support to PCM.  If a
> PCM is opened with O_APPEND, it shares the alreay opened stream.
> And the second patch is to alsa-lib to use this new O_APPEND feature.
> Since the resource can be shared via O_APPEND, we don't need dmix
> server.
> 
> I'm not sure whether it's a 2.6.17 material or a post-2.6.17.  Maybe
> we need a bit discussion whether this O_APPEND hack is right or not.
> 
> Beware that the patch is against the very latest CVS version.  The
> anon tree doesn't have it yet right now.
> 
> Any comments or test reports are appreciated.
> 
> 
> For further implementation, we could get rid of shared memory by a
> small addition to the kernel, too.  At least, two different things
> would be needed:
> 
> - Missing GET_HW_PARAMS and GET_SW_PARAMS ioctls
>   (Why don't we have them?)
> - Anonymous mmap for the shared sum area of dmix
> 
> This requires more detailed discussion, I think.
> 
> 
> Takashi

This all sounds good. I will test the dmix buffer size improvement.
I remember asking for this some time ago.
This might fix problems people are having with Doom3 and the like.

James


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
