From: Jaroslaw Sobierski <fycio@gucio.com>
Subject: Re: S/PDIF on AD1980 patch
Date: Mon, 17 Feb 2003 08:01:27 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1045497687.3e5107575caeb@webmail3.namezero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: tiwai@suse.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


>> 
>> Here's the patch I promised. I had some trouble compiling the CVS version
>> (not the drivers but libs, still don't know why), but I supplemented with
>[...]
>
>Send us unified diff, please. It's more readable to verify the contents.
>

Will do. Once I get home :-). 
I thought since I'm only adding lines anyway it's more compact, but you're
right, it's easier to see it in context.

Another question though. I still cannot get the AC3 pass-through to work.
I assume the spdif source must be set to AC-Link (which is hw-reset default 
anyway), and I figure all other stuff should be set by alsa (like Category
Code, etc.). I have no problem with AC3 on emu10k1, so I guess mplayer is
requesting correct stream params from alsa. Yet on AC97 I can't get it to 
work (amp keeps indicating a PCM stream). Any suggestions what to look for?

--------------
Fycio (J.Sobierski)
 fycio@gucio.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
