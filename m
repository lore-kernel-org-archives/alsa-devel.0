From: stan <ghjeold_i_mwee@cox.net>
Subject: Re: ICH8 HDA not detected after upgrade from Ubuntu
 7.10 to	8.04
Date: Sun, 25 May 2008 14:50:35 -0700
Message-ID: <4839DF2B.7020501@cox.net>
References: <5ea2cfca0805250944g3705aa41jb78f3b89e43075ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <5ea2cfca0805250944g3705aa41jb78f3b89e43075ef@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Janto Schraiber <brutus.dmc@googlemail.com>
Cc: alsa-user@lists.sourceforge.net, ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Janto Schraiber wrote:
> I got the ASUS P5B mainboard with an Intel HDA compatible Soundchip 
> (Analog Devices... AD 1988B afaik but I'm not realy sure about that). 
> Under Ubunt 7.10 it works out of the box but I just recently updated 
> to the new Ubuntu 8.04 where the card is no longer detected.
>
> There are some post on the web about the problem, but most deal with 
> issues, after you get details per 'head -n 1 
> /proc/asound/card0/codec*' or the like, but sine the card is not 
> detected at all, i get no info from commands like that... see:
>
> $ cat /proc/asound/cards
> --- no soundcards ---
>
> I installed the latest drivers from source, but it doesn't help. I 
> also tried to update the kernel, etc. from the 'hardy-proposed' 
> repository, still no luck.
>
> Here's the output from the 'alsa-info.sh' script:
> http://pastebin.ca/1028944
>
> And here's my dmesg:
> http://pastebin.ca/1028967
>
> What should I do to get my card working again?
 From your dmesg here's the problem.
HDA Intel: probe of 0000:00:1b.0 failed with error -16

I'm not a developer so I don't know what that means, just that it is not 
good.

I think this is an issue for some hda-intel cards in kernel version 
2.6.25.  In the cases I have seen the card was working on the 24 version 
kernel, but when they moved to 25 it stopped working.  That is, it's a 
regression.  I don't think there is anything you can do until the 
problem is fixed there.  Using the earlier kernel is probably not 
possible with the rest of the system.  I don't know this, but suspect 
it.  You could try compiling an earlier kernel on your system. 

I'll cross post this to the alsa-devel mailing list so the developers 
become aware of the problem.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
