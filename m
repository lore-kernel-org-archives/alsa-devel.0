From: Giuliano Pochini <pochini@shiny.it>
Subject: RE: Upgrade driver to 1.0.6, memory allocation?
Date: Thu, 19 Aug 2004 09:49:52 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20040819094952.pochini@shiny.it>
References: <505401c48598$4a891ec0$72cb010a@mail2world.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <505401c48598$4a891ec0$72cb010a@mail2world.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Eliot Blennerhassett <bigblen@icqmail.com>
Cc: linux@blennerhassett.gen.nz, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 19-Aug-2004 Eliot Blennerhassett wrote:

> with the upgrade to 1.0.6, my alsa driver broke. (asihpi)
> Now I'm trying to put it together again, and could do with some tips...
> Mostly it still contained lots of easy to fix snd_magic_cast() but
> Can anybody confirm that the following update is the 'correct' thing to
> do?
> 
> (My) old code:
> call snd_malloc_pages_fallback in the open callback.
> 
> New code:
> call snd_pcm_lib_malloc_pages() in the hw_params callback
> 
> and call snd_pcm_lib_preallocate_pages_for_all() in the sound card pcm
> init function (in my case snd_card_asihpi_pcm()
> ================================
> By default according to pcm_memory.c, only a maximum of 4 substreams are
> allowed.

By default it preallocates memory for the first 4
substreams only. _malloc_pages() will allocate memory on
demand for the other substreams. You can do your own
preallocation routine if you think this default is not good.
If you want to "prepare" the substrem for use with
snd_pcm_lib_malloc_pages() without actually allocating
memory call _preallocate_pages() with size==0.
You can change the size of preallocated memory from
userspace via /proc interface.

Btw I would move the check for (substream->number < 4)
from snd_pcm_lib_preallocate_pages1() to
snd_pcm_lib_preallocate_pages_for_all() in order to allow
the driver to preallocate memory for any ss it wishes.


--
Giuliano.


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
