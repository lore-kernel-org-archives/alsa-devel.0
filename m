From: Adam Tla/lka <atlka@pg.gda.pl>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Thu, 9 Sep 2004 07:52:07 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040909055206.GD4584@sunrise.pg.gda.pl>
References: <200408310852.i7V8qSKk023731@www4.pobox.sk> <Pine.LNX.4.58.0408311131310.1762@pnote.perex-int.cz> <20040906204559.GA4584@sunrise.pg.gda.pl> <Pine.LNX.4.58.0409071050020.1723@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sunrise.pg.gda.pl (sunrise.pg.gda.pl [153.19.40.230])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 38D6C2DB
	for <alsa-devel@alsa-project.org>; Thu,  9 Sep 2004 07:52:12 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409071050020.1723@linux.local>
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

On Tue, Sep 07, 2004 at 11:05:05AM +0200, Jaroslav Kysela wrote:
> We need the intelligent mmap transport for additional functionality 
> (conversions, resampling etc.). I think it's the proper way and nobody 
> (except OSS emulation) has the useability problem. You can still move 
> backwards (although it is problematic when you have a mixing on the path).
OK, that's correct if you need this for plugins in ALSA lib, but from
app point of view it should be as simple as possible. An app working in
mmapped mode should only use function which gets hw_ptr and not push any
pointers forward. If I need load huge data into an app I just fill ring
buffer with silence and just jump to load the data. Ring buffer is
running without my additional work. I could imagine that I can even
forget this step if driver has autosilense option - automatically fills
played periods with silence.
Remembering old_hw_ptr and comparing it with actual hw_ptr is all what
I need to calculate hw offset and avail of samples to update.
The ring buffer boundary should be properly set in driver
so buffer_boundary % buffer_size == 0 and then hw_ptr % buffer_size ==
hw_ofs in any case.

DMA mmaped mode:
init_mode();
old_hw_ptr = hw_ofs = 0;
avail = buffer_size;
fill_buffer();
start_playing();


update_sound() {
	hw_ptr = get_driver_hw_ptr();
	avail = hw_ptr - old_hw_ptr;
	old_hw_ptr = hw_ptr;
	appl_ofs = hw_ofs = hw_ptr % buffer_size;
	
	if (avail < 0)
		avail += buffer_boundary;
	if (avail > buffer_size)
		avail = buffer_size;
	else {
		appl_ofs -= avail;
		if (appl_ofs < 0)
			appl_ofs += buffer_size;
	}
	fill_buffer(appl_ofs, avail);
}

Clear and simple. I can modify also the data previously written in case of game
events. I think ALSA API overcomplicates the case from
application point of view.

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
