From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Metering on record
Date: Mon, 29 Sep 2003 10:37:56 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0309291033310.1362@pnote.perex-int.cz>
References: <20030928121741.45922701.erikd-alsa@mega-nerd.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030928121741.45922701.erikd-alsa@mega-nerd.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Erik de Castro Lopo <erikd-alsa@mega-nerd.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 28 Sep 2003, Erik de Castro Lopo wrote:

> Hi all,
>
> I was hoping someone might be able to shine some light on the
> following issue. I am currently opening an ALSA device for
> record say 44.1 kHz and reading 32k frames of data at a time.
>
> Now with the above setup, if I want to do a meter, I can only
> only update the meter every 32k frames or a little more than
> once a second which makes for a very poor display.
>
> So, looking at /usr/include/alsa/pcm.h I find some function
> definitions which seem like they are meant for metering purposes.
> Unfortunalety I can't seem to find any documentation on the ALSA
> site nor can I find example code showing how this stuff is
> used.
>
> Am I missing something or does this stuff just not exist? Do
> these snd_pcm_meter_* functions work? Anybody have working code
> that uses these things?

The examples are in alsa-lib/src/pcm/scopes directory, but don't expect
a better response times, because the meter plugin is also activated
when an application reads or writes data to device.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
