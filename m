From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: PCM format restrict dilema
Date: Wed, 17 Sep 2003 10:22:30 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200309171422.h8HEMUVi016116@oud>
References: <3F68663C.4050401@superbug.demon.co.uk>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 17 Sep 2003 14:48:44 BST."
             <3F68663C.4050401@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>, manuel.jander@mat.utfsm.cl, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>So, the application does the following: -
>1) I want there to be 8 periods or less, with a minimum of 2.
>2) I want the buffer to be about 500ms long or less, with a minimum or 100ms
>3) I want the period size to have a min value of x, and a max value or y.
>4) Now calculate the actual sizes based on all the above information. 
>(i.e. The buffer_size, and period_size values are not set until stage (4).
>At this point, alsa-lib would use the contrains above, and calculate the 
>best values for buffer_size and period size based on the above, and also 
>what the hardware can do.
>
>The reason I think it might help this way, is because period_size and 
>buffer_size and number of periods are all closely linked, so we should 
>not have to set them one at a time, but set them as a group.

given that buffer_size = period_size * nperiods, why try to set the
buffer size at all? i've never set the buffer size in any ALSA app - i
always set nperiods first, then the period size.

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
