From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001724]: au88x0 PCM configuration
	problem - buffer_size constraint
Date: Tue, 30 May 2006 18:31:19 +0200
Message-ID: <6562d79a349e2e13a88360ebfa68fa75@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 22535150
	for <alsa-devel@alsa-project.org>;
	Tue, 30 May 2006 18:31:20 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1724> 
======================================================================
Reported By:                Raymond
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   1724
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-07-2006 05:10 CET
Last Modified:              05-30-2006 18:31 CEST
======================================================================
Summary:                    au88x0 PCM configuration problem - buffer_size
constraint
Description: 
/cvs/alsa-lib/test/pcm_min

ALSA lib pcm.c:7127:(snd_pcm_set_params) Unable to set buffer time
(latency) 500000 for PLAYBACK: Invalid argument
Playback open error: Invalid argument

sound card is au8830, the au88x0 driver only accept period size in power
of 2.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001766 jackd : ALSA: cannot set period size to...
======================================================================

----------------------------------------------------------------------
 Raymond - 05-30-06 09:38 
----------------------------------------------------------------------
/* IRQ flags */
#define IRQ_ERR_MASK	0x00ff
#define IRQ_FATAL	0x0001
#define IRQ_PARITY	0x0002
#define IRQ_REG		0x0004
#define IRQ_FIFO	0x0008
#define IRQ_DMA		0x0010
#define IRQ_PCMOUT	0x0020	/* PCM OUT page crossing */
#define IRQ_TIMER	0x1000
#define IRQ_MIDI	0x2000
#define IRQ_MODEM	0x4000

snd_pcm_period_elapsed() is called only when IRQ_PCMOUT is generated,
however IRQ_ERR_MASK should not contain IRQ_PCMOUT bit. It just wasting
CPU to perform those unnecssary check 

IRQ_ERR_MASK should be 0x1f instead of 0xff

	if (unlikely(source & IRQ_ERR_MASK)) {
		if (source & IRQ_FATAL) {
			printk(KERN_ERR "vortex: IRQ fatal error\n");
		}
		if (source & IRQ_PARITY) {
			printk(KERN_ERR "vortex: IRQ parity error\n");
		}
		if (source & IRQ_REG) {
			printk(KERN_ERR "vortex: IRQ reg error\n");
		}
		if (source & IRQ_FIFO) {
			printk(KERN_ERR "vortex: IRQ fifo error\n");
		}
		if (source & IRQ_DMA) {
			printk(KERN_ERR "vortex: IRQ dma error\n");
		}
		handled = 1;
	}

This may explain why au8820 score low mark in recent linux audio
comparsion FC5



----------------------------------------------------------------------
 rlrevell - 05-30-06 18:31 
----------------------------------------------------------------------
What does this IRQ issue have to do with the buffer size constraint?

Raymond, PLEASE stop using this bug tracker as your private IRC channel. 
One bug report per bug.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-07-06 05:10 Raymond        New Issue                                    
01-09-06 15:19 Raymond        Note Added: 0007537                          
01-19-06 15:04 Raymond        Note Deleted: 0007537                        
01-19-06 15:36 Raymond        Note Added: 0007721                          
01-28-06 07:58 Raymond        Note Added: 0007828                          
01-28-06 07:58 Raymond        Note Deleted: 0007721                        
01-30-06 18:46 Raymond        Note Added: 0007840                          
01-31-06 03:15 Raymond        Note Added: 0007844                          
01-31-06 06:41 Raymond        Note Edited: 0007840                         
01-31-06 07:03 Raymond        Note Edited: 0007840                         
01-31-06 07:08 Raymond        Note Edited: 0007840                         
01-31-06 07:11 Raymond        Note Edited: 0007840                         
01-31-06 08:31 Raymond        Note Edited: 0007840                         
01-31-06 09:48 Raymond        Note Edited: 0007844                         
01-31-06 10:19 perex          Note Added: 0007845                          
01-31-06 10:26 perex          Note Added: 0007847                          
01-31-06 10:26 perex          Note Edited: 0007847                         
01-31-06 10:48 perex          Project                  ALSA - lib => ALSA -
driver
01-31-06 10:49 perex          Category                 0_general => PCI - au88x0
01-31-06 10:49 perex          Summary                  simple PCM helper
function => au88x0 PCM configuration problem - buffer_size constraint
01-31-06 11:06 Raymond        Note Added: 0007848                          
01-31-06 13:48 perex          Status                   new => assigned     
01-31-06 13:48 perex          Assigned To               => mjander         
01-31-06 13:49 perex          Relationship added       related to 0001766  
01-31-06 15:59 Raymond        Note Added: 0007852                          
02-01-06 07:35 perex          Note Added: 0007857                          
02-01-06 10:32 Raymond        Note Added: 0007858                          
02-01-06 10:37 Raymond        Note Edited: 0007848                         
02-01-06 17:15 Raymond        Note Edited: 0007844                         
02-01-06 17:20 Raymond        Note Added: 0007860                          
02-02-06 10:23 Raymond        Note Added: 0007874                          
02-02-06 11:10 Raymond        Note Edited: 0007874                         
02-02-06 15:48 Raymond        Note Edited: 0007874                         
02-03-06 14:26 Raymond        Note Added: 0007897                          
02-04-06 02:46 Raymond        Note Edited: 0007874                         
02-04-06 02:52 Raymond        Note Edited: 0007858                         
02-04-06 02:56 Raymond        Note Edited: 0007858                         
02-05-06 16:39 Raymond        Note Added: 0007939                          
02-05-06 16:48 Raymond        Note Added: 0007940                          
02-06-06 04:40 Raymond        Note Deleted: 0007939                        
02-06-06 06:15 Raymond        Note Edited: 0007940                         
02-07-06 07:35 Raymond        Note Added: 0007954                          
02-13-06 03:11 Raymond        Note Added: 0008036                          
02-13-06 08:52 mjander        Note Added: 0008039                          
02-13-06 16:57 Raymond        Note Added: 0008055                          
02-13-06 17:02 Raymond        Note Edited: 0008055                         
02-13-06 17:02 Raymond        Note Edited: 0008055                         
02-16-06 04:01 Raymond        Note Added: 0008083                          
02-19-06 06:31 Raymond        Note Added: 0008130                          
02-19-06 06:39 Raymond        Note Edited: 0008130                         
03-07-06 11:08 Raymond        Note Added: 0008362                          
03-07-06 14:18 Raymond        Note Edited: 0007844                         
03-24-06 10:51 Raymond        File Added: snd_pcm_set_params.patch              
     
03-30-06 18:35 Raymond        Note Added: 0009036                          
05-22-06 15:11 Raymond        Note Deleted: 0008055                        
05-22-06 15:12 Raymond        Note Deleted: 0008362                        
05-22-06 15:13 Raymond        Note Deleted: 0008130                        
05-22-06 15:14 Raymond        Note Deleted: 0008083                        
05-22-06 15:15 Raymond        Note Deleted: 0009036                        
05-22-06 15:16 Raymond        Note Deleted: 0007860                        
05-22-06 15:17 Raymond        Note Deleted: 0007848                        
05-22-06 15:20 Raymond        Note Deleted: 0007940                        
05-22-06 15:24 Raymond        Note Deleted: 0007954                        
05-22-06 15:48 Raymond        Note Added: 0009912                          
05-30-06 09:36 Raymond        Note Added: 0010017                          
05-30-06 09:38 Raymond        Note Edited: 0010017                         
05-30-06 18:31 rlrevell       Note Added: 0010020                          
======================================================================
