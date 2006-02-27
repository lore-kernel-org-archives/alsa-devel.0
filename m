From: Rimas Kudelis <rq@akl.lt>
Subject: Re: [PATCH] Add support for Acer TravelMate and similar
 laptops
Date: Mon, 27 Feb 2006 15:43:38 +0200
Message-ID: <4403020A.5030400@akl.lt>
References: <44022D35.7050909@akl.lt> <s5haccdt0ub.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5haccdt0ub.wl%tiwai@suse.de>
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
Cc: alsa-devel@lists.sourceforge.net, Paulo Matias <syscoder@gmail.com>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hello,

> I prefer removing '(?)'. In case you are not sure whether these
> controls really work, you can add a comment in the source code or
> create a document.
>   
OK, but I think I'll leave these tasks to Jonathan.

> Sure, once I got patches for Jonathan, I'll apply yours.
>   
There will be no need for that as he said he'll include my patch into
his. After his patch is applied, there will probably be another patch
from me (it should define the final CD and Beep status in mixer). But
that's in future.

> "Line" would be better since the OSS-emulation code uses this word to
> construct the mixer layer.
>   
Then we'll leave it with "Line", as it is now.

> You can set zero to subdevice to compare only subvendor.
I'll keep that in mind. But I'm not sure if that's a good practice at
all (even though I believe it should work).

Rimas



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
