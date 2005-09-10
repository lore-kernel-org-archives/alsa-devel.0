From: Raymond <rayau@netvigator.com>
Subject: Re : CVS: alsa-kernel/pci/au88x0 au88x0.c,1.18,1.19
Date: Sat, 10 Sep 2005 13:11:02 +0800
Message-ID: <43226AE6.3060502@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, Manuel Jander <manuel.jander@gmail.com>, openvortex-dev@nongnu.org, xslaby@fi.muni.cz
List-Id: alsa-devel@alsa-project.org

Refer to the recent change in CVS

http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/pci/au88x0/au88x0.c?r1=1.18&r2=1.19

The au88x0 chips have known conflict with the following PCI devices

1) PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8365_1
2) PCI_VENDOR_ID_VIA, PCI_EVICE_ID_VIA_82C598_1
3) PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_FE_GATE_7007

The function of snd_vortex_workaround() is to detect the presence of
these devices and  perform vortex_fix_latency() and
vortex_fix_agp_bridge() automatically.

http://sourceforge.net/mailarchive/forum.php?thread_id=8137444&forum_id=33141

What is the difference between pci_find_device() and pci_get_device() ?

What is the purpose of adding pci_dev_put(via); at the end of
snd_vortex_workaround() ?






-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
