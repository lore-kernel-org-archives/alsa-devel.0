From: Russell King <rmk+alsa@arm.linux.org.uk>
Subject: 2.6.6-rc2 build warnings
Date: Sun, 30 May 2004 11:00:08 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040530110008.A20815@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Someone may wish to look into the cause of this... CONFIG_PCI is
unselected in this case.

  CC [M]  sound/core/oss/mixer_oss.o
In file included from sound/core/oss/mixer_oss.c:26:
include/sound/core.h:215: warning: `struct pci_dev' declared inside parameter list
include/sound/core.h:215: warning: its scope is only this definition or declaration, which is probably not what you want
include/sound/core.h:216: warning: `struct pci_dev' declared inside parameter list
  CC [M]  sound/core/oss/pcm_oss.o
In file included from sound/core/oss/pcm_oss.c:35:
include/sound/core.h:215: warning: `struct pci_dev' declared inside parameter list
include/sound/core.h:215: warning: its scope is only this definition or declaration, which is probably not what you want
include/sound/core.h:216: warning: `struct pci_dev' declared inside parameter list
...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
