From: "Nenad Sljivic" <nenad.sljivic@rt-rk.com>
Subject: Timer interface
Date: Fri, 29 Jul 2011 17:05:23 +0200
Message-ID: <1731E52B1A4E4804B5D5A4820E26368F@domain.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.rt-rk.com (mail.rt-rk.ftn.uns.ac.rs [147.91.177.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 09A371037EE
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Jul 2011 17:05:27 +0200 (CEST)
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

Hi,

I am extending my ALSA driver in order to support software mixing. Driver
currently supports both MMAP and RW access modes. However, I am still not
able to use dmix since it requires timer interface to be implemented.
My hardware does not generate interrupts at the period boundary but issues
timer interrupts at a fixed timer rate. 
 
Could you please point me to the document or sample driver that can help me
to fully understand timer interface concept (especially for High frequency
timer interrupts)?

Thanks,
Nenad
