From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: [RFC] Echoaudio driver
Date: Tue, 09 Nov 2004 09:48:27 +0100 (CET)
Message-ID: <XFMail.20041109094827.pochini@shiny.it>
References: <Pine.HPX.4.33n.0411081906090.16893-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0411081906090.16893-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 08-Nov-2004 Clemens Ladisch wrote:
> Giuliano Pochini wrote:
>> I don't see anything obviously wrong in the driver now.
>
> AFAICS the MODULE_LICENSE is really "Dual BSD/GPL", apart from the
> non-GPL (?) firmware which would belong into the alsa-firmware
> package.

Ah, no, the new code from Echoaudio is now fully GPL'd, except
the firmware. I've not updated the licence notice at the beginning
of each file yet. Furthermore, I'll not freeze the dev status
because I have to do far less changes than I though at first
glance. Darla20, Gina20 and Gina24 are already supported with
the new firmware (tested only on the Gina24) and the other cards
will be supported in a few days.


> Does it compile on 2.4.x kernels?  On 2.2.x kernels?  >;-)

It does on 2.4 (but I don't test it for a long time). I don't
think it compiles on 2.2... never tried anyway.


> (I guess we can deactivate it if it's compiled on kernels without
> request_firmware().)

I kept the possibility to use compiled-in firmware.


>> What have I to do to include it in alsa-driver yet ?
>
> Make a big patch, then yell loudly until somebody includes it.

The tarball has a small patch (Kconfig and Makefile) and all
the code is in /pci/echoaudio/


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
