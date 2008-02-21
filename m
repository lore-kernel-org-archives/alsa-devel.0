From: Eliot Blennerhassett <linux@audioscience.com>
Subject: asihpi: Need help converting volatile to memory
	barriers
Date: Fri, 22 Feb 2008 12:18:18 +1300
Message-ID: <200802221218.18249.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id D5D3D243CF
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 00:14:52 +0100 (CET)
Received: from zaphod (121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JWM00JZ038N9E00@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Fri, 22 Feb 2008 12:14:48 +1300 (NZDT)
Content-disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, greg@kroah.com
List-Id: alsa-devel@alsa-project.org

Greetings,

first, the meta-help request:
Is there another place that I should be making this request? (lkml, kernel 
newbies, linux driver project etc)?

Theres quite a bit written about barriers, but most seems to be assuming SMP 
situation or memory mapped devices. Not much about devices doing DMA.
I.e I have read Documentation/memory-barriers.txt

Now the actual question:
Currently I have a driver that uses "volatile" - heres the relevant source.
http://hg.alsa-project.org/alsa-driver/file/89222d702376/pci/asihpi/hpi6205.c

The "volatile" is applied to structures that are either read or written by 
device DMA.  Certainly the driver in its current state doesn't work without 
volatile qualifier. (BTW the device doesn't use host interrupts)

Structures ("interface") used for dma are allocated with dma_alloc_coherent()

In the following, am I using the barriers correctly?

1) Reading something updated by DMA

volatile struct bus_master_interface *interface;
while (interface->ack != OK) { 
	sleep(a while)  	
	[ device changes interface->ack by dma ]
};
=== after conversion
struct bus_master_interface *interface;
while (interface->ack != OK) { 
	sleep(a while);
	rmb(); 
};

Here the volatile or rmb is needed or the loop gets optimised away.

2) Writing to memory, interrupt device

volatile struct bus_master_interface *interface;
interface->cmd = command;
iowrite(device_interrupt, 1);

=== after conversion ===
struct bus_master_interface *interface;
interface->cmd = command;
wmb();
iowrite(device_interrupt, 1);
[device reads interface->cmd by dma]

Is the wmb() a guarantee that the command will be in memory visible to the 
device when the driver informs it of a new command?


3) 

One assumption I am making is that the compiler is not going to optimise 
across functions 
E.g. in the following scenario, is the compiler going to optimise the loop 
away without a rmb()?  If not, is this because of something inherent in the C 
standard, or just because the optimiser isn't yet smart enough to see it? 
I.e. it might work now, but when whole-file-optimisation is introduced, it 
will fail?

int get_ack(interface) { return interface->ack }
...
while (get_ack(interface) != OK) {
	sleep(a while);
}


regards

--
Eliot Blennerhassett
www.audioscience.com
