From: Pietro <pxpert@gmail.com>
Subject: Re: Applied "ASoC: Intel: add bytct-rt5651 machine
	driver" to the asoc tree
Date: Tue, 31 May 2016 22:56:15 +0200
Message-ID: <2387755.MGqpljUrLg@wks-pdc-gentoo>
References: <1851514.XmzcdsvJt0@wks-pdc-gentoo>
 <1680237.irs5HCh7f7@wks-pdc-gentoo>
 <b0014ea7-1f78-1a6c-0202-fde9c35ba356@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id F1E322651D1
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 22:56:17 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id a136so893518wme.0
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 13:56:17 -0700 (PDT)
In-Reply-To: <b0014ea7-1f78-1a6c-0202-fde9c35ba356@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
Here are the answers:

- tracing to make sure you are actually on a CHT device
  The device should be CHT (The processor is an Atom X3-Z8300). Can it be that the processor is an X3 series, but the platform is BT and not a CHT? I know many manifacturers simply upgraded their notebooks series from BT to CHT by changing the CPU and mantaining all the other components the same (For example the Audio codec).
  How can I trace this?

- pastebin dmesg somewhere
  Here is it: http://pastebin.com/FnpAD1kg

- sudo cat /sys/bus/acpi/devices/10EC5651:01/status
  Here are the results:
  /sys/bus/acpi/devices/10EC5651:00/status 
    Returns 15

  /sys/bus/acpi/devices/10EC5651:01/status 
    Returns 0

- enabling DSP loopbacks to see if the DSP consumes data at the right  rate. look at the UCM file and change cset "name='pcm1_out mix 0 pcm0_in Switch' off" to on if you record and loopback on USB output this should play at the right speed.
  I've changed the value in the HiFi file, but no changes.
  How can i enable DSP loopbacks? I'm not an alsa developer so I need some help here :)

Please let me know if you need other informations.

On Tuesday 31 May 2016 15:27:45 Pierre-Louis Bossart wrote:
> the changes look ok
> >
> > But I still have the same problem: Audio plays slowly.
> >
> >
> >
> > It seems the DSP is clocked at 19.2, but the system is still clocked for
> > 25, and these changes doesn't seem to have effects...
> 
> no, CHT doesn't have a 25 MHz clock at all so that's just not physically 
> possible.
> 
> Can you try:
> - tracing to make sure you are actually on a CHT device
> - pastebin dmesg somewhere
> - sudo cat /sys/bus/acpi/devices/10EC5651:01/status
> - enabling DSP loopbacks to see if the DSP consumes data at the right 
> rate. look at the UCM file and change
> cset "name='pcm1_out mix 0 pcm0_in Switch' off" to on
> if you record and loopback on USB output this should play at the right 
> speed.
> 
> 
> 
