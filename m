From: Adam Tla/lka <atlka@pg.gda.pl>
Subject: Re: Re: The obsolence of OSS, Was: big smile
Date: Wed, 25 Feb 2004 14:37:59 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040225133759.GH8820@sunrise.pg.gda.pl>
References: <Pine.LNX.4.58.0402241536450.1883@pnote.perex-int.cz> <403BC832.4080404@gardena.net> <20040225112021.GE8820@sunrise.pg.gda.pl> <Pine.LNX.4.58.0402251401030.10484@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402251401030.10484@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 25, 2004 at 02:09:43PM +0100, Jaroslav Kysela wrote:
> It has nothing to do if the code is in user space or in kernel space.
> You have a limited amount of CPU time. You cannot go beyond and we 
> continuously fix and improve our code. Doing mixing in interrupt is
> very bad. The latency used with our lock-free algorithm is same as
> with mixing in interrupt.
I don't think so. If an sound app is swapped out or another app is doing
intensive disk IO we could observe - hear - the difference.
aoss app can even stop and crash, some native ALSA apps too.
Maybe they are badly designed. Generally if the kernel know about time
critical app it can schedule them at appropriate time.
And this could be done only by kernel. Some apps colud run slower
and it should be acceptable - compilation or file copying for example.
 
> Personally, I am very satisfied with the dmix performance with recent 
> fixes. We need only a nice GUI tool to mantain the .asoundrc configuration 
> files so users can benefit with using of all extended functions.
I am raher satisfied too, with minor exceptions.

> Nope. It has nothing to do with all above. With well-tuned system, you 
> will have same performance with both implementations.
I have low latency option on and some disk io optimiztions turned on too
but can easily observe buffer underrun and ALSA aoss app failure
by doing high CPU and disk IO operation - opening 500MB tar.gz file
for example.

Regards

-- 
Adam Tla/lka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group           ~~~~~~
Computer Center,  Gdansk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
