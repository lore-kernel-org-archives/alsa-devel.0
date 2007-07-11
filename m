From: "Gao, Jonathan" <Jonathan.Gao@spansion.com>
Subject: [Alsa-devel] xrun problem
Date: Wed, 11 Jul 2007 09:45:29 +0800
Message-ID: <D66A5610D809884EA3968F92900EFCAA0189EEC9@cnsuzexmbpf1.spansion.com>
References: <D66A5610D809884EA3968F92900EFCAA0189EEB3@cnsuzexmbpf1.spansion.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from usspausgw01.spansion.com (usspausgw01.spansion.com
	[12.110.209.204])
	by alsa0.perex.cz (Postfix) with ESMTP id CE6D5103835
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jul 2007 03:45:39 +0200 (CEST)
Received: from USAUSEXBH1.spansion.com (usausexbh1.spansion.com [10.248.26.58])
	by usspausgw01.spansion.com (Tumbleweed MailGate) with ESMTP id
	3BB72483099F5
	for <alsa-devel@alsa-project.org>; Tue, 10 Jul 2007 20:47:57 -0500 (CDT)
Content-class: urn:content-classes:message
In-Reply-To: <D66A5610D809884EA3968F92900EFCAA0189EEB3@cnsuzexmbpf1.spansion.com>
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
I am writing a PCM driver on a Soc for 2.6.10 kernel.
The test code I'm using is from alsa-lib-1.0.6rc1/test/pcm.c.
The runtime log gives me like this...
-----------------------------------------------------------------
open callback: 
hw params callback: alloc result = 1, buffer bytes = 4608

/* --------- HW params ------------- */
format = 2,     rate = 44100,   channels= 2,    period_size = 288,
periods = 4,    buffer_size = 1152

prepare callback
/* --------- Runtime Info ---------- */
state = 1 (SNDRV_PCM_STATE_SETUP),      hw_ptr = 0,     appl_ptr = 0,
avail_min = 288
avail_max = 0,  hw_ptr_base = 0,        hw_ptr_interrupt = 0

trigger callback: START

Codec Do Copy:
/* --------- Runtime Info ---------- */
state = 3 (SNDRV_PCM_STATE_RUNNING),      hw_ptr = 0,     appl_ptr =
1152,        avail_min = 288
avail_max = 0,  hw_ptr_base = 0,        hw_ptr_interrupt = 0

pointer callback: hw pointer: 288 (return value of pointer callback)

Codec Do Copy:
/* --------- Runtime Info ---------- */
state = 3 (SNDRV_PCM_STATE_RUNNING),      hw_ptr = 288,   appl_ptr =
1152,        avail_min = 288
avail_max = 288,        hw_ptr_base = 0,        hw_ptr_interrupt = 288

pointer callback: hw pointer: 576 (return value of pointer callback)

Codec Do Copy: 
/* --------- Runtime Info ---------- */
state = 3 (SNDRV_PCM_STATE_RUNNING),      hw_ptr = 576,   appl_ptr =
1152,        avail_min = 288
avail_max = 576,        hw_ptr_base = 0,        hw_ptr_interrupt = 576

pointer callback: hw pointer: 864 (return value of pointer callback)

Codec Do Copy:
/* --------- Runtime Info ---------- */
state = 3 (SNDRV_PCM_STATE_RUNNING),      hw_ptr = 864,   appl_ptr =
1152,        avail_min = 288
avail_max = 864,        hw_ptr_base = 0,        hw_ptr_interrupt = 864

pointer callback: hw pointer: 0  (return value of pointer callback)

trigger callback: STOP
prepare callback
/* --------- Runtime Info ---------- */
state = 4 (SNDRV_PCM_STATE_XRUN),      hw_ptr = 1152,  appl_ptr = 1152,
avail_min = 288
avail_max = 1152,       hw_ptr_base = 1152,     hw_ptr_interrupt = 1152
-----------------------------------------------------------------

The kernel hangs after prepare callback, from  strace, I can see a
endless ioctl(4, ..., ...) repeated.
Does anyone have a few pointers on what is going wrong?

Best Regards,
Jonathan
