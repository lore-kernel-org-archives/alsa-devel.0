From: Alexey Galakhov <agalakhov@gmail.com>
Subject: Re: Samsung S5PV210 I2S DMA
Date: Mon, 22 Jul 2013 16:27:05 +0600
Message-ID: <51ED08F9.7060709@gmail.com>
References: <1365334565.5261.4.camel@localhost> <51D7EFEA.6040901@gmail.com>
 <1374478409.1874.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f49.google.com (mail-la0-f49.google.com
 [209.85.215.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FD2C261A0D
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2013 12:27:10 +0200 (CEST)
Received: by mail-la0-f49.google.com with SMTP id ea20so4991307lab.22
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2013 03:27:09 -0700 (PDT)
In-Reply-To: <1374478409.1874.2.camel@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Dyer <mike.dyer@md-soft.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 07/22/2013 01:33 PM, Mike Dyer wrote:

> In my case it turned out the TZPC hadn't been configured properly by the
> bootloader.  I had to modify to the bootloader to make sure the I2S was
> non secured (it's secure by default).

Thank you! As I'm the one who ported the bootloader (barebox) to
S5PV210, I think I should support generic TZPC configuration in the
bootloader.

Regards,
Alex
