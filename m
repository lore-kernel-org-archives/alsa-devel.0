From: Eliot Blennerhassett <linux@audioscience.com>
Subject: [PATCH] asihpi version 3.09.09
Date: Wed, 30 Jan 2008 20:21:16 +1300
Message-ID: <200801302021.17091.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id AFBCC10397D
	for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2008 08:19:04 +0100 (CET)
Received: from zaphod (121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JVG00IO44BOAZ00@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Wed, 30 Jan 2008 20:19:01 +1300 (NZDT)
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Howdy Takashi,

Code: 
http://audioscience.com/internet/download/beta/alsa_driver3507_asihpi30909.patch

Firmware:
http://audioscience.com/internet/download/beta/dspbins30909.tar.bz2

here is an update to the asihpi driver, please apply to alsa Hg if you see 
fit. (BTW the previous version was only meant to be commented on, not 
committed!)

Main changes in this set:
* Redo comment formatting so block comments are properly indented with code 
(bulk of changes)

hpifunc.c:
* Remove HPI_UNUSED macro from hpifunc
* Remove error->string translation, hence strcpy
hpios_linux_kernel.*
* Remove use of slab cache for DMA memory allocation tracking
hpicmn.*:
* Rename some functions to give Hpi prefix, made others static
hpimod.c
* Replace semaphore with mutex
* Make driver cleanup more 'normal'
hpi6205.c hpi6000.c hpimsgx.c
* Pull some error handling up into hpimsgx.c

Relevant DSP code changes (for alsa-firmware)
	add record format check for supported format.
	ASI6500/6500 - fix issue arising from back-to-back- adapter sample rate 
changes.
	ASI6000 - fix rare MP3 decode bug.
	ASI6585 - add support for clock source Livewire.
	ASI6416 - re-order control creation.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>

regards

--
Eliot Blennerhassett
www.audioscience.com
