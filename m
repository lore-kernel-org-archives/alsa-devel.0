From: javier Martin <javier.martin@vista-silicon.com>
Subject: DMA HW bug in MX2x platforms?
Date: Fri, 24 Jul 2009 09:37:33 +0200
Message-ID: <eedb5540907240037u2cb8fbfap84f02727621261d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f222.google.com (mail-ew0-f222.google.com
	[209.85.219.222])
	by alsa0.perex.cz (Postfix) with ESMTP id EFC8D103A51
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jul 2009 09:37:34 +0200 (CEST)
Received: by ewy22 with SMTP id 22so1556714ewy.32
	for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2009 00:37:33 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

I am currently working on an ASoC driver for mx2x platforms. I am
porting an old working ASoC driver for 2.6.22 + Freescale BSP kernel
to current 2.6.30 kernel.

Among other things, I had to translate old Freescale's DMA api to the
one provided in 2.6.30 for i.mx2x platforms.

Here I will describe the problem that I am having:
in "aplay" I am using (buffer_size/period_size=4), each
(2*period_size) samples I have some erroneous ones that should come
(buffer_size) samples later, and this relation is valid for several
values with (buffer_size/period_size=4).

I have a trace log with all details for DMA transfers that I have
compared for both 2.6.22 and new 2.6.30 and they are identical. Some
people has also told me that there could be a problem with DMA in mx2x
platforms.

Do you have knowledge of this kind of problem? Is there a new DMA
version for mx2x in any git repository?

-- 
Javier Martin
Vista Silicon S.L.
Universidad de Cantabria
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
