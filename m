From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [parisc-linux] [PATCH] Support for AD1889 PCI
 Soundchip
Date: Thu, 4 Aug 2005 15:30:45 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0508041503020.11474-100000@studcom.urz.uni-halle.de>
References: <20050729211634.566f5343@Tatooine.r3z0>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050729211634.566f5343@Tatooine.r3z0>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thibaut VARENE <T-Bone@parisc-linux.org>
Cc: alsa-devel@lists.sourceforge.net, kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org
List-Id: alsa-devel@alsa-project.org

Thibaut VARENE wrote:
> Attached is a patch against 2.6.13-rc4 providing support for Analog
> Devices AD1889 PCI Sound chip, which is especially found on some HP
> PA-RISC machines.

I don't actually have this hardware :-), but the docs don't mention
any dependency between the count registers (BC, CC) and the interrupt
count registers (IC, IB).

So wouldn't it be possible to put the ALSA buffer size into the count
registers and the ALSA period size into the interrupt count registers?

This would make the interrupt handler much simpler, as it wouldn't
have to reprogram any registers.  And it would solve the problem that
the DMA accesses for one period go beyond the buffer when the number
of periods per buffer is not an integer.


Regards,
Clemens



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
