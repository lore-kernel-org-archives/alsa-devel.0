From: Tim Blechmann <TimBlechmann@gmx.net>
Subject: Re: USB quattro input quality
Date: Fri, 7 May 2004 14:03:21 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040507140321.28777db8@laptop>
References: <409B0D89.6090503@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <409B0D89.6090503@boosthardware.com>
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

> Just wondering if anyone has found time to look into fixing the input 
> quality of the usb quattro?
> 
> I'm not sure it has ever functioned perfectly for input quality.
> 
> Currently I get a better sound quality from my $10 cmipci than my $400
> 
> usb-quattro ;-P
> 
> There is a constant crackle in the audio stream.
there is a thread on this on the alsa bugtracking system ... there is a
patch available, but it's not fully working for me...
using kernel 2.6.6rc2 with the patch to the usb subsystem to allow the
using of the quattro, i'll only have to restart alsa about once or
twice. (probably i still had problems with the alsa patch because of
kernel 2.6.6)

cheers...

 Tim                          mailto:TimBlechmann@gmx.de
                              ICQ: 96771783
--
The only people for me are the mad ones, the ones who are mad to live,
mad to talk, mad to be saved, desirous of everything at the same time,
the ones who never yawn or say a commonplace thing, but burn, burn,
burn, like fabulous yellow roman candles exploding like spiders across
the stars and in the middle you see the blue centerlight pop and
everybody goes "Awww!"
                                                          Jack Kerouac



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
