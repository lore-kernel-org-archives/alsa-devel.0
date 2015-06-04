From: Marcus Bannerman <m.bannerman@gmail.com>
Subject: Re: writing an alsa driver
Date: Thu, 4 Jun 2015 07:09:59 +0000 (UTC)
Message-ID: <loom.20150604T085739-771@post.gmane.org>
References: <20150523163221.GA936@asus> <s5h7fruecx4.wl-tiwai@suse.de>
 <20150527085440.GA4445@dellaz> <1432752116.8235.25.camel@loki>
 <20150527201320.GA309@asus> <1432812668.2726.18.camel@loki>
 <20150528125325.GA418@asus> <1432819294.2726.33.camel@loki>
 <20150528191721.GA608@asus> <1432892521.2732.14.camel@loki>
 <20150529131753.GA339@asus> <1433156768.2642.21.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E73A2605C0
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 09:25:08 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Z0PWS-0003EB-G4
 for alsa-devel@alsa-project.org; Thu, 04 Jun 2015 09:25:04 +0200
Received: from oa-edu-188-169.wireless.abdn.ac.uk ([137.50.188.169])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Thu, 04 Jun 2015 09:25:04 +0200
Received: from m.bannerman by oa-edu-188-169.wireless.abdn.ac.uk with local
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Thu, 04 Jun 2015 09:25:04 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> Jarkko thinks the IRQ may be incorrectly reported by ACPI and that it
> could be using another ACPI index. This could probably be checked by
> decompiling the ACPi data and searching for the audio DSP.

Hi,
Interested x205ta user here and I want to try to help out where I can. Is the 
patch file somewhere publicly available and which version are you working 
off?

I'm not sure exactly what you're looking for and there's a lot of tables and 
I'm not sure which to decompile. I've attached the acpi dmesg data here for 
determining what the decompiler is for each file:
http://pastebin.com/yNryrakS

And I've uploaded the contents of /sys/firmware/acpi/tables here:
http://dynamomd.org/acpi_tables.tar
I'll trawl through them if you can let me know what you're looking for.

Marcus
