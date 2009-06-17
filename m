From: ZeroCluo <Zero.CLuo@gmail.com>
Subject: trace PCM data from usb bus to alsa lib
Date: Wed, 17 Jun 2009 07:25:25 +0000 (UTC)
Message-ID: <loom.20090617T071323-969@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 8CFEB24503
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Jun 2009 09:30:03 +0200 (CEST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1MGpas-0003I1-9R
	for alsa-devel@alsa-project.org; Wed, 17 Jun 2009 07:30:03 +0000
Received: from mail.sernet.com.cn ([202.102.106.2])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2009 07:30:02 +0000
Received: from Zero.CLuo by mail.sernet.com.cn with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2009 07:30:02 +0000
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
List-Id: alsa-devel@alsa-project.org

Hi 

  I am trying to trace the Audio data from usb bus.
in kernel: 
dump data in retire_capture_urb() ,found data format is like:
AABB 0000 CCDD 0000 ;

but in alsa library ,
dump data in snd_pcm_mmap_begin(),the "0000" is cut,only "AABB CCDD",

Do you know when and where those "0000" is cut?

btw,use mmap method map dma_area to user space; and use snd_pcm_readi to get 
audio data;

Thank you very very much.

Best Regards,
Zero
