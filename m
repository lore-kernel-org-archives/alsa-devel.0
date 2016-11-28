From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH] hiface: Fix sample rate changes
Date: Mon, 28 Nov 2016 10:51:34 +0100
Message-ID: <CAOf5uw=YOqJQpLbLE7RhMVE=kzHxR6jhEvEAm8n4dWfPVFWPWg@mail.gmail.com>
References: <ee24b066-41d2-ad24-8598-f15a26a743a8@sonarnerd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f174.google.com (mail-io0-f174.google.com
 [209.85.223.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 38C95266D36
 for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2016 10:51:38 +0100 (CET)
Received: by mail-io0-f174.google.com with SMTP id c21so215467969ioj.1
 for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2016 01:51:38 -0800 (PST)
In-Reply-To: <ee24b066-41d2-ad24-8598-f15a26a743a8@sonarnerd.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jussi Laako <jussi@sonarnerd.net>, Antonio Ospite <ao2@ao2.it>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi

On Mon, Nov 28, 2016 at 10:27 AM, Jussi Laako <jussi@sonarnerd.net> wrote:
> When attempting to change sample rate for the interface after first set-play
> cycle, the change is not reflected to the hardware, while from user space
> everything seems to go fine.
>
> This patch fixes the issue and the driver now behaves the same way as for
> example the USB Audio Class driver.
>

Can you please sent it inline? Not having access at the hardware now
but Antonio should have it

Michael


>



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
