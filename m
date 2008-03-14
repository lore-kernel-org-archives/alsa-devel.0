From: ListsAccount <lists@s201431494.online.de>
Subject: bugfix for RME HDSPM alsa driver
Date: Fri, 14 Mar 2008 14:33:02 +0100
Message-ID: <47DA7E8E.6000008@s201431494.online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 2EF7924661
	for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2008 14:33:07 +0100 (CET)
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

I have had the following problem with the RME HDSPM alsa driver:

settings of card:
Preferred Sync Reference = Word
Sample Clock Source = AutoSync
and no input plugged in (neither madi nor optical)
playing a file (important!)

Monitoring the external rate with amixer, the value was jumping between
"None" and "48000 kHz".

The proc output showed that the sample rate on word clock was still
right at 48000 kHz
while the external rate was jumping here, too. External rate seems to
jump between
word clock and madi input select.

When "Preferred Sync Reference = Word" is selected, just the word clock
rate should be
displayed!



I fixed the problem with following patch in
alsa-driver-1.0.16/alsa-kernel/pci/rme9652/hdspm.c
in function hdspm_external_sample_rate() line 668:

There was a typo: instead of status2, status was used.

668c668
<                               (status & HDSPM_SelSyncRef0) == 0) {
---
>                               (status2 & HDSPM_SelSyncRef0) == 0) {


(same way as in snd_hdspm_proc_read_madi function line 3123)


greetings
