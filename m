From: Rene Herman <rene.herman@gmail.com>
Subject: Re: Can someone verify support for "AzTech Sound
 Galaxy Nova 16 Extra II-3D - using AZT-2316/R Chipset - FCC-ID:I38-MMSN846"
 ?
Date: Thu, 10 May 2007 23:06:20 +0200
Message-ID: <4643894C.2000409@gmail.com>
References: <20070510205706.8B5B11CE303@ws1-6.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by alsa0.perex.cz (Postfix) with ESMTP id BBC8D2440B
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2007 23:08:49 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id j3so498881ugf
	for <alsa-devel@alsa-project.org>; Thu, 10 May 2007 14:08:49 -0700 (PDT)
In-Reply-To: <20070510205706.8B5B11CE303@ws1-6.us4.outblaze.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ramkromberg@mail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 05/10/2007 10:57 PM, ramkromberg@mail.com wrote:

> Just a recap: I verifyed using dos the settings
> (hwset and volset - default and save), and used the bios
> to set "IRQ 5" as "ISA Legacy".
> 
> I didn't use the jumper as I see no need since the epprom
> already does the job.

I don't understand what you mean here. You need to set the JMPCFG jumper to 
the EEPROM setting so that the card will configure itself at poweron using 
the values stored in its EEPROM and not wait for a driver to configure and 
enable it (which the Linux driver does not do).

Rene.
