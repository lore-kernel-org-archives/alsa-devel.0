From: Alex Romosan <romosan@sycorax.lbl.gov>
Subject: trident problems
Date: Mon, 12 May 2003 14:58:20 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <87addrrfnn.fsf@sycorax.lbl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

i am running kernel 2.4.21-rc2 and i think since friday after i did a
cvs update i can't get the trident module to load anymore. this is the
output from syslog:

kernel: PCI: Found IRQ 10 for device 00:0b.0
kernel: PCI: Sharing IRQ 10 with 00:05.0
kernel: ALSA ../../alsa-kernel/pci/ac97/ac97_codec.c:2048: AC'97 0:0 does not respond - RESET
kernel: Trident 4DWave PCI soundcard not found or device busy
insmod: /lib/modules/2.4.21-rc2/kernel/sound/pci/trident/snd-trident.o: init_module: No such device
insmod: Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters.       You may find more information in syslog or the output from dmesg
insmod: /lib/modules/2.4.21-rc2/kernel/sound/pci/trident/snd-trident.o: insmod snd-card-0 failed

any ideas?

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
