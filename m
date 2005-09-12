From: Raymond <rayau@netvigator.com>
Subject: Re: Re : CVS: alsa-kernel/pci/au88x0 au88x0.c,1.18,1.19
Date: Tue, 13 Sep 2005 01:26:58 +0800
Message-ID: <4325BA62.1010208@netvigator.com>
References: <43226AE6.3060502@netvigator.com> <4af2d03a05091000577d5ed477@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4af2d03a05091000577d5ed477@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: jirislaby@gmail.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jiri Slaby wrote:
> On 9/10/05, Raymond <rayau@netvigator.com> wrote:
> 
>>Refer to the recent change in CVS
>>
>>http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/pci/au88x0/au88x0.c?r1=1.18&r2=1.19
>>
>>The au88x0 chips have known conflict with the following PCI devices
>>
>>1) PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8365_1
>>2) PCI_VENDOR_ID_VIA, PCI_EVICE_ID_VIA_82C598_1
>>3) PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_FE_GATE_7007
> 
> Maybe, this is the problem of the driver, I only want to get rid of
> pci_find_device from the tree, because it's old and deprecated.
> 

The description of the "Loss of Sound" in Windows driver

http://www.dayc.vispa.com/guides/vortex.htm


>>The function of snd_vortex_workaround() is to detect the presence of
>>these devices and  perform vortex_fix_latency() and
>>vortex_fix_agp_bridge() automatically.
>>
>>http://sourceforge.net/mailarchive/forum.php?thread_id=8137444&forum_id=33141
>>
>>What is the difference between pci_find_device() and pci_get_device() ?
> 
> pci_find returns structure of device, that couldn't exist, when
> returned, so pci_get_device uses ref. counts to avoid this.


Is the result fatal if pci_dev_put() some how can not decrease the ref.
count ?


> 
>>What is the purpose of adding pci_dev_put(via); at the end of
>>snd_vortex_workaround() ?
> 
> pci_dev_put decrements ref. count, when is no longer needed.
> 

Does this means every vortex_fix_agp_bridge(via) will be followed by 
pci_dev_put(via) ?










-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
