From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB Audio/Midiman - partial success
Date: Wed, 18 Sep 2002 11:25:53 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0209181111180.8479-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.31.0209172023540.4425-100000@lorien.wv.mentorg.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <Pine.LNX.4.31.0209172023540.4425-100000@lorien.wv.mentorg.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: "Pikus, Fedor" <fedor_pikus@mentorg.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Fedor G. Pikus wrote:
> > > It happens with either S16_LE or S24_3LE if the rate is 96000.
> > > It does not happen right away, but after several seconds.
>
> With raw the file length is 0. With wav is was probably just the header,
> the length is right, 44.

So it doesn't record anything, and needs several seconds to realize this.

> > > > > arecord: pcm_read:1049: read error: Input/output error
>
> Still nothing in the log, even with --with-debug=full

Please try the -v option of arecord. (But I doubt this will show anything
useful. I'm telling you this only to hide the fact that I don't have any
clue what is going on. ;-)


Regards,
Clemens



-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
