From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: ALSA Test suite
Date: Mon, 15 Mar 2004 19:30:01 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040315193001.4cad17ac.mista.tapas@gmx.net>
References: <20040314095115.73922.qmail@web61103.mail.yahoo.com>
	<s5hptbeiecx.wl@alsa2.suse.de>
	<4055CFA4.4040600@superbug.demon.co.uk>
	<s5h3c8ahzh4.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3c8ahzh4.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: James@superbug.demon.co.uk, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 15 Mar 2004 17:00:39 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> 
> oh thanks, it was under evaluation before getting permission ;)

Hi, i don't know if my pcm config tester is in some way braindead [it
sure is], and also it's far from complete. But if you guys feel that the
program could be of any serious use, i would "donate" it to the ALSA
project after cleaning it up and filling in the missing tests..

Just for remembering: it's a little program which browses the
configuration space of a pcm device, trying to open it with different
configurations [periodsize, periodcount, sample rates [for
capture/playback/fullduplex] ..  It doesn't actually try to play any
sound through it [cause the different access methods are already tested
by the pcm test program in alsa-lib/test]...

Flo

-- 
to sign or not to sign, that is the question



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
