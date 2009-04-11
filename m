From: "Carlos R. Mafra" <crmafra2@gmail.com>
Subject: Re: General protection fault when unloading
	snd_hda_intel on	2.6.30-rc1+
Date: Sat, 11 Apr 2009 23:03:36 +0200
Message-ID: <20090411210336.GA15272__45743.5310505845$1239518210$gmane$org@Pilar.aei.mpg.de>
References: <20090411193630.GA16968@Pilar.aei.mpg.de>
	<20090411132033.003c581c@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20090411132033.003c581c@infradead.org>
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
Cc: tiwai@suse.de, linux-kernel@vger.kernel.org, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat 11.Apr'09 at 13:20:33 -0700, Arjan van de Ven wrote:
> 
> if you happen to have CONFIG_DEBUG_INFO enabled, then you can run the
> oops through scripts/markup_oops.pl to get the source code of the exact
> line that is oopsing.. makes diagnosing it even easier!

I did not have CONFIG_DEBUG_INFO enabled back then, but now I have.

The script gives me this output:

No vmlinux specified, assuming /lib/modules/2.6.30-rc1-00191-gd848223/build/vmlinux
 		add_input_randomness(type, code, value); 
 		input_handle_event(dev, type, code, value); 
 		spin_unlock_irqrestore(&dev->event_lock, flags); 
 	} 
 } 
 ffffffff8044bf7a:	48 8b 5d d8          	mov    -0x28(%rbp),%rbx |  %ebx => 3 
 ffffffff8044bf7e:	4c 8b 65 e0          	mov    -0x20(%rbp),%r12 |  %r12 => ffffffff805bb97c 
 ffffffff8044bf82:	4c 8b 6d e8          	mov    -0x18(%rbp),%r13 |  %r13 => 5 
 ffffffff8044bf86:	4c 8b 75 f0          	mov    -0x10(%rbp),%r14 |  %r14 => 697665646632785c 
 ffffffff8044bf8a:	4c 8b 7d f8          	mov    -0x8(%rbp),%r15 |  %r15 => 0 
 ffffffff8044bf8e:	c9                   	leaveq  
 ffffffff8044bf8f:	c3                   	retq    
  
 static inline int variable_test_bit(int nr, volatile const unsigned long *addr) 
 { 
 	int oldbit; 
  
 	asm volatile("bt %2,%1\n\t" 
*ffffffff8044bf90:	0f a3 77 20          	bt     %esi,0x20(%rdi) |  %edi = 697665646632785c  %esi = 5 <--- faulting instruction
 ffffffff8044bf94:	19 c0                	sbb    %eax,%eax 
 static struct input_handler *input_table[8]; 
  
 static inline int is_event_supported(unsigned int code, 
 				     unsigned long *bm, unsigned int max) 
 { 
 	return code <= max && test_bit(code, bm); 
 ffffffff8044bf96:	85 c0                	test   %eax,%eax 
 ffffffff8044bf98:	74 e0                	je     ffffffff8044bf7a <input_event+0x2a> 
 { 
 	unsigned long flags; 
  
 	if (is_event_supported(type, dev->evbit, EV_MAX)) { 

