From: Carlo Wood <carlo@alinoe.com>
Subject: Re: ALSA (CVS) doesn't compile on recent linux (alsa-driver)
Date: Fri, 18 Jul 2003 17:16:10 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030718151610.GD9756@alinoe.com>
References: <20030718123133.GB9756@alinoe.com> <s5hhe5jkiwx.wl@alsa2.suse.de> <20030718145558.GC9756@alinoe.com> <s5hel0nkh77.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hel0nkh77.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 18, 2003 at 05:06:20PM +0200, Takashi Iwai wrote:
> and run make on the top of kernel-source tree.
> you don't need any files in alsa-drivers tree.
> 
> (well, i know this bug must be fixed because some experimental drivers
>  only exist in alsa-driver tree.)

Now I am confused... you are saying that
I don't need the alsa-driver directory that
is checked out with CVS?

As in:

rm -rf alsa-driver

?

New attempt:

/usr/src/alsa>tar -C alsa-kernel -cf - --exclude CVS --exclude Documentation --exclude include . | tar -C /lib/modules/2.5.74-debug/build/sound -xf -
/usr/src/alsa>tar -C alsa-kernel/include -cf - --exclude CVS . | tar -C /lib/modules/2.5.74-debug/build/include/sound -xf -
/usr/src/alsa>rm -rf alsa-conf alsa-driver
/usr/src/alsa>make
/usr/src/alsa>make
rm -rf /usr/doc/packages/alsa
mkdir -p /usr/doc/packages/alsa
for i in driver utils; do                               \
        cp alsa-$i*/README /usr/doc/packages/alsa/README.$i;    \
done
cp: cannot stat `alsa-driver*/README': No such file or directory
for i in FAQ INSTALL doc/SOUNDCARDS; do                 \
        cp alsa-driver*/$i /usr/doc/packages/alsa;                      \
done
cp: cannot stat `alsa-driver*/FAQ': No such file or directory
cp: cannot stat `alsa-driver*/INSTALL': No such file or directory
cp: cannot stat `alsa-driver*/doc/SOUNDCARDS': No such file or directory
make: *** [install-doc] Error 1


Ok - so you can't run 'make' at all in the CVS root.

Then do I understand correctly that:

1) alsa-conf and alsa-driver can be deleted.
2) alsa-kernel needs to be copied to /lib/modules/*/build/sound
   and alsa-kernel/include to /lib/modules/*/build/include/sound
   and then run 'make modules' in /lib/modules/*/build
3) One needs to run 'make; make install' as root in
   alsa-lib and alsa-utils seperately.
4) The rest can't be built ('make' doesn't work).
5) Again: alsa-drivers is not needed at all for me.

Thanks for the clarification.

-- 
Carlo Wood <carlo@alinoe.com>


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
