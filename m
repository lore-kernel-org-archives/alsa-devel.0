From: Adam Tla/lka <atlka@pg.gda.pl>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Wed, 8 Sep 2004 19:15:37 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040908171537.GC4584@sunrise.pg.gda.pl>
References: <200408310852.i7V8qSKk023731@www4.pobox.sk> <Pine.LNX.4.58.0408311131310.1762@pnote.perex-int.cz> <20040906204559.GA4584@sunrise.pg.gda.pl> <Pine.LNX.4.58.0409071050020.1723@linux.local> <20040907103408.GB4584@sunrise.pg.gda.pl> <Pine.LNX.4.58.0409071538390.14771@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sunrise.pg.gda.pl (sunrise.pg.gda.pl [153.19.40.230])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9053D2A8
	for <alsa-devel@alsa-project.org>; Wed,  8 Sep 2004 19:15:41 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409071538390.14771@linux.local>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 07, 2004 at 03:40:04PM +0200, Jaroslav Kysela wrote:
> The forward should work for the dmix plugin. Could you send me a little 
> code which shows the error?
I must test it because after changes it doesn't shows an error.

BTW another case:

if avail = snd_pcm_available() > alsa.buffer_size then I think
that frames_to_forward = avail - alsa.buffer_size

now I do err = snd_pcm_forward(pcm, frames_to_forward)
and returned err is equal to avail

Why?
What is the correct value of frames to forward in emulated OSS buffer:
frames_to_forward or returned err value?
avail % alsa.buffer_size == (avail - alsa.buffer_size) % alsa.buffer_size
in this case which means the same ofs in ALSA ring buffer.
But OSS ring buffer size is not equal to ALSA ring buffer size
so only one value is proper for OSS appl_ptr increasing.
IMHO frames_to_forward but maybe I am wrong.

Regards
-- 
Adam Tla/lka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group           ~~~~~~
Computer Center,  Gdansk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
