From: Uros Bizjak <uros@kss-loka.si>
Subject: Re: sb16 gets wedged when doing overlapped i/o (full
 duplex)
Date: Thu, 5 Dec 2002 13:07:15 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.05.10212051304370.3576-100000@pulsar.kss-loka.si>
References: <3DEF2ED7.7000808@monmouth.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DEF2ED7.7000808@monmouth.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "John S. Denker" <jsd@monmouth.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello!

  Did you try to set 16bit DMA allocation flag to Playback or Capture?

  Also, there are problems if your ISA bus is overclocked to more
than 8MHz.

	Uros.

On Thu, 5 Dec 2002, John S. Denker wrote:

> 	==== This is a slightly-updated clone of item
> 	#648232 on the sourceforge bug/patch reporting
> 	system.  I'm moving it to here (the alsa-devel
> 	mailing list) at the request of Jaroslav. ====
> 
> Things run OK for a few minutes (sometimes 30 seconds,
> sometimes 5+ minutes) then ALSA gets wedged.  Every read or
> write results in an error.  This only happens when I'm doing
> overlapped i/o; pure input runs happily for hours, and
> although I haven't tried it I assume pure output works fine.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
