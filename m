From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: General protection fault when unloading
 snd_hda_intel on 2.6.30-rc1+
Date: Sat, 11 Apr 2009 14:39:50 -0700
Message-ID: <20090411143950.3429ebc0@infradead.org>
References: <20090411193630.GA16968@Pilar.aei.mpg.de>
	<20090411132033.003c581c@infradead.org>
	<20090411210336.GA15272@Pilar.aei.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090411210336.GA15272@Pilar.aei.mpg.de>
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

On Sat, 11 Apr 2009 23:03:36 +0200
"Carlos R. Mafra" <crmafra2@gmail.com> wrote:

> From: "Carlos R. Mafra" <crmafra2@gmail.com>
> To: Arjan van de Ven <arjan@infradead.org>
> Cc: linux-kernel@vger.kernel.org, tiwai@suse.de,
> alsa-devel@vger.kernel.org Subject: Re: General protection fault when
> unloading snd_hda_intel on 2.6.30-rc1+ Date: Sat, 11 Apr 2009
> 23:03:36 +0200 User-Agent: Mutt/1.5.18 (2008-05-17)
> 
> On Sat 11.Apr'09 at 13:20:33 -0700, Arjan van de Ven wrote:
>  [...]
  
  
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




so... "dev" is pointing evbit at... 697665646632785 which looks like grabage.

-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
