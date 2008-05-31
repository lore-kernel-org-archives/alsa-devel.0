From: "Brett Andrews" <bandrews@broadcom.com>
Subject: FW: [Alsa-user] raw spdif frame capture
Date: Fri, 30 May 2008 20:35:54 -0700
Message-ID: <49DB790369A9994C9FFDBE788541873D057BD166@NT-IRVA-0750.brcm.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mms1.broadcom.com (mms1.broadcom.com [216.31.210.17])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C26E244AF
	for <alsa-devel@alsa-project.org>;
	Sat, 31 May 2008 05:36:26 +0200 (CEST)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.11.18.52]) by
	mail-irva-10.broadcom.com (Postfix) with ESMTP id C863F2B0 for
	<alsa-devel@alsa-project.org>; Fri, 30 May 2008 20:36:06 -0700 (PDT)
Received: from NT-IRVA-0750.brcm.ad.broadcom.com (nt-irva-0750
	[10.8.194.64]) by mail-irva-13.broadcom.com (Postfix) with ESMTP id
	6875374CFF for <alsa-devel@alsa-project.org>; Fri, 30 May 2008 20:36:02
	-0700 (PDT)
Content-class: urn:content-classes:message
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

Hi:

Anyone have any ideas about the following?  As a side note, when I saw
raw I don't mean 61937 raw (just preambles and payload), I mean 60958
raw (block sync, payload, VUCP).

Thanks,
Brett 

-----Original Message-----
From: stan [mailto:ghjeold_i_mwee@cox.net]
Sent: Friday, May 30, 2008 18:31
To: Brett Andrews
Cc: alsa-user@lists.sourceforge.net
Subject: Re: [Alsa-user] raw spdif frame capture

Brett Andrews wrote:
> Hi:
>
> I would like to perform raw spdif frame capture (all 64-bits, in 2 
> 32-bit subframes) using an EMU 1212M under ALSA.  Can this be done?
> If so, has anyone else already done it?  If not, does anyone have any 
> idea how to do it?  EMU has claimed that it is possible with the 
> hardware, but that the driver would need to support it (windows driver

> does not, they didn't know about the ALSA driver).  Does the current
> emu10k1 driver support this?  How would I enter this mode?
>
> Thanks,
>
> Brett Andrews
> Software Engineer
> BSE Reference Software
>   
I haven't got a lot of help for you as I'm not knowledgeable about this
but I can give you some suggestions.

You could ask you question on alsa-devel mailing list as they know the
internals and might be able to answer your question directly.

You could look at the alsa driver code.  Go to
ftp://ftp.alsa-project.org/pub/driver/ and download
File:alsa-driver-1.0.16.tar.bz2. 
<ftp://ftp.alsa-project.org/pub/driver/alsa-driver-1.0.16.tar.bz2>
This is the latest official alsa version.  Unpack it and then look in
"top level"/alsa-kernel/pci/emu10k1.  That has the C source.
