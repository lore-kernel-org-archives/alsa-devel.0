From: "Eliot Blennerhassett" <bigblen@icqmail.com>
Subject: (no subject)
Date: Tue, 15 Jul 2003 18:55:10 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030715185511.19935.h007.c012.wm@mail.icqmail.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

The problem I am seeking help on is not an ALSA problem per-se, but as I am
working on an ALSA driver I thought I'd start here...
any suggestions for a more appropriate forum will be gratefully accepted.


Background info:
I have a lowlevel driver that works fine when I used semaphores to prevent
conention for my hardware.  Access was soley via ioctl into my driver.

I have to change the semaphore to a spinlock now that I also call basically the
same entry point from a timer routine in my ALSA driver.

When I record from the card the data is read from the card into a userspace
buffer

    ptr,size = <Buffer pointer,size received from user application>

    fs = get_fs();
    set_fs(get_ds());
    /* Ensure that the data buffer is resident in memory.  */
    if (!access_ok (wrflag ? VERIFY_WRITE : VERIFY_READ, ptr, bytes))
    {
        set_fs(fs);
        return -EFAULT;
     }

    /* Inside here is the spinlock, and a copy to the ptr mentioned above */
    HPI_MessageF (gphHpiSubsys, &hm, &hr, file );
    
    set_fs(fs);
    
Problem:
The single change from semaphore to spinlock results in a kernel panic when I
try to record from my card:
	Unable to handle kernel paging request at virtual address ...

    
Question:
Notwithstanding bad style etc, am I doing something that is fundamentally wrong
in using a userspace buffer when I am inside a spinlock i.e. in interrupt
context?  (In the same way as I must not use a semaphore in interrupt context)

Could it be that when I try to write to the buffer it causes a page fault, which
cannot be handled in interrupt context?
But I thought that access_ok call should take care of making sure the buffer is
in memory...


TIA for any insights you may have.

Eliot Blennerhassett
AudioScience Inc.
--
Junk footer beyond this point. Read at your own risk.


-------------------------------------------------------------
Sign up for ICQmail at http://www.icq.com/icqmail/signup.html


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
