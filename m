From: Karim Yaghmour <karim@opersys.com>
Subject: Re: USB Audio problems
Date: Thu, 20 Nov 2003 15:28:25 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FBD23E9.1060609@opersys.com>
References: <3FBBC461.1020006@opersys.com>	<3FBC560B.7040104@opersys.com> <s5hoev7ywfw.wl@alsa2.suse.de>
Reply-To: karim@opersys.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hoev7ywfw.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Takashi Iwai wrote:
> it'd be better to clean unlink_mask in the complete callback for the
> case you use async unlink mode (see below).
> and, the check of active_mask should be done in prepare callback, not
> in the trigger callback.  the trigger callback must be as short as
> possible.  we can put deactivate_urbs() in prepre callback so that the
> urbs become clean before starting streams.

Sounds right.

> (but still we have a problem of async unlink because prepare callback
>  is also in the spinlocked context.)

Would it be fair to say that this driver requires some major rework?

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 514-812-4145



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
