From: Tim Jackson <lists@timj.co.uk>
Subject: Re: alsa-firmware licensing
Date: Tue, 29 Jan 2008 18:11:35 +0000
Message-ID: <479F6C57.4030309@timj.co.uk>
References: <477F9103.9010304@timj.co.uk>
	<1199702481.16243.1229842463@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.firecluster.net (blixt.firecluster.net [89.16.161.116])
	by alsa0.perex.cz (Postfix) with ESMTP id 14516103896
	for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2008 19:11:51 +0100 (CET)
In-Reply-To: <1199702481.16243.1229842463@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:

Thanks for all your help Clemens and apologies for the slow reply.

 > Tim Jackson wrote:

[... emi firmware licensing]
> The emi firmware files are copies of linux/drivers/usb/misc/emi26_fw.h
> and emi62_fw_*.h.  emi26_fw.h contains three copies of this "license",
> but only the first one contains this paragraph which is missing in
> license.txt:
> 
> | Permission is hereby granted for the distribution of this firmware 
> | image as part of a Linux or other Open Source operating system kernel 
> | in text or binary form as required. 
> 
> I've added this paragraph to license.txt.

Thanks.

>> Does the ALSA project have special authorisation ("written consent") to 
>> distribute this?
> 
> Well, I'd guess the alsa-firmware package is part of Linux.

Unfortunately I don't think that's a "guess" that some distributors such 
as Fedora can risk to take. Although ALSA is of course part of a "Linux 
... kernel", the wording "as part of" is ambiguous and there's certainly 
an argument that a standalone ALSA firmware package (i.e. not 
distributed along with the rest of the kernel) is not "distribution...as 
part of" a kernel.

Much though I'd *like* these firmwares to be distributable, unless those 
licensing terms get changed, I think we'll have to drop those particular 
firmwares in Fedora.

> Please note that the emi26 and emi62 drivers still use the in-kernel
> copies of their firmware images; the files in alsa-firmware are as yet
> unused.

That's useful, thanks. Is the plan to drop the in-kernel ones at some 
point then? At least this means if we do drop the firmware it won't have 
any negative effect, at least at the moment.


Thanks

Tim
