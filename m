From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: PCM format restrict dilema
Date: Tue, 16 Sep 2003 14:47:20 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200309161847.h8GIlKtn014678@oud>
References: <3F675208.8090409@superbug.demon.co.uk>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 16 Sep 2003 19:10:16 BST."
             <3F675208.8090409@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, manuel.jander@mat.utfsm.cl, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I want to try and aim at 8 periods per buffer.
>Common sense would tell me that one should be able to set the buffer 
>size first, and then try to set the period size to buffer_size/8. But I 

why don't you set the sizes based on frame counts, not time? i suspect
you're more likely to get better results.

>should be able to use the set_period_size_near call so that it selects 
>the next closest value, so that I achieve a result as close as possible 
>to what I want. This seems to fail with the current setup on some sound 
>cards, but works with other sound cards.

i hope you handle the failure to get buffer_size/8 properly ... you
need to be willing to go all the way to buffer_size/2 before
concluding that you can't configure the device.

--p



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
