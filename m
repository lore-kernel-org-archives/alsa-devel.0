From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: memory management
Date: Tue, 14 Dec 2004 12:06:59 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0412141125390.15302-100000@studcom.urz.uni-halle.de>
References: <20041214045217.56186.qmail@web51905.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041214045217.56186.qmail@web51905.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Michael Geis <michaelgeis11@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Michael Geis wrote:
> I am not really familiar with memory mangement and would like to
> ensure I am getting memory leaks in my ALSA app.

This is easy, just avoid any _free() calls.  SCNR.  ;-)

> There are snd_seq_...._free functions for most of the data types I
> am using.

Those are for datatypes that are internal alsa-lib types and that can
only be accessed through wrapper functions.  The three ways to use
such types are:
* use ..._alloc and ..._free;
* use ..._alloca to be freed when the current function exits;
* use ..._sizeof and use your own (de)allocation functions.

> For a few of them, however, I could not find a function
> that frees the structure and wanted to ask whether they require to
> be freed and I just missed the appropriate function when looking
> through the header files.
>
> The data types in question are: snd_seq_real_time_t ,
> snd_seq_tick_time_t, snd_seq_addr_t, snd_seq_port_subscribe_t

These types are defined in the header files (and will never change).

> Could someone comment on whether the memory of variables of these
> data types needs to be freed?

There is no cleanup function.  Use them like any other POD type.


HTH
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
