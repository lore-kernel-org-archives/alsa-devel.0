From: "Tom Browne" <tbrowne@tbrowne.demon.co.uk>
Subject: Re: snd_pcm_writei not returning (?!?)
Date: Mon, 5 Apr 2004 15:25:39 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000a01c41b19$deed1bf0$0100a8c0@burpxp>
References: <200403311238.i2VCcD33015334@dhin.linuxaudiosystems.com> <02a601c41735$801cc090$f93ca851@burpxp>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Despite the indifference to this issue, I thought it only fair to say that
switching to mmap seems to have stopped the problem from occuring.

- Tom.


Tom Browne wrote:
> Hi all,
>
> I am having serious trouble with ALSA using the poll method as shown
> in the pcm.c test app...
>
> Under certain conditions (yet to be established properly - it doesn't
> happen every single time) with this ICE1712 card (DSP24),
> snd_pcm_writei doesn't just block... it never comes back.  I thought
> it may be a bug in the old version of ALSA (0.9.8) so updated the
> drivers and libs to latest, which had no effect on the problem at all.
>
> A bit more thorough checking reveals that the problem only happens at
> 88200 and 96000 sampling rates... not at 22050, 24000, 44100 or
> 48000.  That's a bit worrying...
>
> It's only started to happen regularly (used to be _very_ rare) since I
> upgraded the development machine from an Intel 815, Celeron 1.0G to a
> SiS651, Celeron 2.0G setup.
>
> The kernel is 2.4.22+ll+supermount if that offers any clues... APIC is
> turned off, as in the past I couldn't get any sound at all in Linux
> with it enabled...
>
> Cheers,
>
> Tom Browne.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
