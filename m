From: Andrei Boros <andrei@srr.ro>
Subject: Re: Opti92x-ad1848 won't take Opti924 card
Date: Tue, 23 Sep 2003 09:53:34 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F6FEDEE.9E5D3FF8@srr.ro>
References: <Pine.HPX.4.33n.0309221153001.8132-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Clemens Ladisch wrote:
> 
> Andrei Boros wrote:
> > options snd-cs46xx              mmap_valid=1 index=0 id="Fortissimo-II"
> > enable=1
> > options snd-opti-92x-ad1848     index=1 isapnp=1 id="Opti924" port=0x220
> > irq=5 dma1=0 fm_port=0x38
> 
> I hope these lines aren't wrapped in the original.
> Shouldn't fm_port be 0x388?

Ah, sorry, the complete line is : 
options snd-opti-92x-ad1848     index=1 isapnp=1 id="Opti924" port=0x220
irq=5 d
ma1=0 fm_port=0x380 mpu_port=0x300 mpu_irq=7

(wrap...)

-- 
ing. Andrei Boros
mailto:andrei@srr.ro / +40-21-303-1870
Centrul pt. Tehnologia Informatiei
Societatea Romana de Radiodifuziune


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
