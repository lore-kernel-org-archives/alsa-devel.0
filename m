From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: signal loss recovery
Date: Sun, 30 Nov 2003 11:17:57 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0311301117190.21602@pnote.perex-int.cz>
References: <D7AA4A37-21F8-11D8-8A08-00039393D25E@gigagig.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <D7AA4A37-21F8-11D8-8A08-00039393D25E@gigagig.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Burris Ewell <dalsa@gigagig.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 28 Nov 2003, Burris Ewell wrote:

> I am writing a simple capture program using 0.9.8 and a PDAudioCF card. 
>   I want to recover gracefully when the A/D converter stops and starts 
> sending signal during capture.   When signal is lost, I call 
> snd_pcm_start periodically until the signal returns  and continue 
> capture.  On odd numbered starts (first, third, fifth stop/start of A/D 
> converter) everything recovers normally and I continue to capture the 
> output of the converter.  However, on even numbered starts (second, 
> fourth, sixth stop/start of A/D converter) I capture full scale white 
> noise.
> 
> I'm probably not doing something right.  Any pointers or suggestions 
> will be greatly appreciated.

Can you send me your code? I'll try give a look to this problem.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
