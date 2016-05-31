From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Applied "ASoC: Intel: add bytct-rt5651 machine
 driver" to the asoc tree
Date: Tue, 31 May 2016 15:27:45 -0500
Message-ID: <b0014ea7-1f78-1a6c-0202-fde9c35ba356@linux.intel.com>
References: <1851514.XmzcdsvJt0@wks-pdc-gentoo>
 <bd2f5937-39bf-5892-959e-ec11cf2c5dba@linux.intel.com>
 <1680237.irs5HCh7f7@wks-pdc-gentoo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 041232651D1
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 22:27:48 +0200 (CEST)
In-Reply-To: <1680237.irs5HCh7f7@wks-pdc-gentoo>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pietro <pxpert@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

the changes look ok
>
> But I still have the same problem: Audio plays slowly.
>
>
>
> It seems the DSP is clocked at 19.2, but the system is still clocked for
> 25, and these changes doesn't seem to have effects...

no, CHT doesn't have a 25 MHz clock at all so that's just not physically 
possible.

Can you try:
- tracing to make sure you are actually on a CHT device
- pastebin dmesg somewhere
- sudo cat /sys/bus/acpi/devices/10EC5651:01/status
- enabling DSP loopbacks to see if the DSP consumes data at the right 
rate. look at the UCM file and change
cset "name='pcm1_out mix 0 pcm0_in Switch' off" to on
if you record and loopback on USB output this should play at the right 
speed.
