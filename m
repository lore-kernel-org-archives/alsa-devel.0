From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Thu, 09 Sep 2004 08:59:51 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409091259.i89CxpQM019899@localhost.localdomain>
References: <20040909055206.GD4584@sunrise.pg.gda.pl>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from out014.verizon.net (out014pub.verizon.net [206.46.170.46])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7D2472B4
	for <alsa-devel@alsa-project.org>; Thu,  9 Sep 2004 14:59:55 +0200 (MEST)
In-reply-to: Your message of "Thu, 09 Sep 2004 07:52:07 +0200."
             <20040909055206.GD4584@sunrise.pg.gda.pl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adam Tla/lka <atlka@pg.gda.pl>
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>OK, that's correct if you need this for plugins in ALSA lib, but from
>app point of view it should be as simple as possible. An app working in
>mmapped mode should only use function which gets hw_ptr and not push any
>pointers forward. If I need load huge data into an app I just fill ring

if you don't "push pointers forward", there is no way for ALSA to
determine whether there has been an xrun. ALSA can automatically track
the h/w pointer (most of the time), but if it doesn't know how much
data the application has written (and where), it cannot compare the
two values to check for xruns.

>update_sound() {
>	hw_ptr = get_driver_hw_ptr();
>	avail = hw_ptr - old_hw_ptr;
>	old_hw_ptr = hw_ptr;
>	appl_ofs = hw_ofs = hw_ptr % buffer_size;
>	
>	if (avail < 0)
>		avail += buffer_boundary;
>	if (avail > buffer_size)
>		avail = buffer_size;
>	else {
>		appl_ofs -= avail;
>		if (appl_ofs < 0)
>			appl_ofs += buffer_size;
>	}
>	fill_buffer(appl_ofs, avail);
>}

>Clear and simple. I can modify also the data previously written in
>case of game events. I think ALSA API overcomplicates the case from
>application point of view.

the problem with this approach is that it doesn't take into account
several possibilities:

	a) there is no actual mmap-able buffer; ALSA may be providing
	     this via emulation (for certain hardware or certain kinds
	     of virtual devices), and therefore needs to know how much
	     data you actually wrote.
	b) the accessible region of the buffer may not be contiguous.
	c) the h/w pointer may have already wrapped around to the
	     start of the buffer because of scheduling delays - your code
	     will fail miserably in this case.
	d) the "previously written" data may not be physically
	     accessible - there are a few audio interfaces that
	     are not bus masters, and require the CPU to transfer
	     data to them. the "old" part of the buffer will
	     never be resent.
        e) if the PCM device is "virtual", the stride distances
	     within the buffer will vary.

The simplicity of the OSS approach is appealing, very appealing. But
it fails to handle some very important situations, and thats why
ALSA's mmap API is a bit more complex.

--p


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
