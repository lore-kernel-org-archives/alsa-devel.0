From: Sean McNamara <smcnam@gmail.com>
Subject: Re: Exclusive access to capture device
Date: Sun, 24 Jun 2012 16:31:19 -0400
Message-ID: <CAPAActe9s54_8BiwiR+wrWUTfOtzAEJ6ycAhWaeK2h9EgoLBDQ@mail.gmail.com>
References: <CADfV-LHztneYAZJusarOSTv3qXuECWqrQajqLEKCsJC82yvULA@mail.gmail.com>
	<CADfV-LGfSwGU6fdBeWqtW4-4rpux0NeneV=7uEe4dFbyBs9NGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
	[209.85.212.169])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F697243D1
	for <alsa-devel@alsa-project.org>;
	Sun, 24 Jun 2012 22:31:20 +0200 (CEST)
Received: by wibhn14 with SMTP id hn14so2298688wib.2
	for <alsa-devel@alsa-project.org>; Sun, 24 Jun 2012 13:31:20 -0700 (PDT)
In-Reply-To: <CADfV-LGfSwGU6fdBeWqtW4-4rpux0NeneV=7uEe4dFbyBs9NGA@mail.gmail.com>
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

If you open a hardware device that doesn't have hardware mixing, it's
*always* exclusive access. But the driver can support hardware mixing
for sound cards that supply it, which makes it non-exclusive.

Also, if you open a soft device that has software mixing, such as the
pulseaudio plugin or dsnoop, it won't be exclusive.

Hopefully you aren't writing a desktop application, because distros
and users generally abhor the notion of an application "hogging" the
sound device for any reason, and would prefer that all access be
non-exclusive. But if you're coding for an embedded device, then I can
understand this approach.

Then again, if you're working in the embedded space, you have full
control over the entire software and hardware stack, right? So make
sure that the device you open, e.g. hw:0 or whatever, is a driver that
doesn't support hardware mixing. Problem solved; your access is
"exclusive".

HTH,

Sean



On Sun, Jun 24, 2012 at 4:17 PM, Guy Rutenberg <guyrutenberg@gmail.com> wrote:
> Hi,
>
> Is there a way to open a capture device exclusively? E.g. I want to capture
> audio and be sure no other application can capture from that device at the
> same time.
>
> I've went through the API and searched the mailing list and haven't found a
> way to do so.
>
> Thanks a lot,
>
> Guy
>
> ----
> http://www.guyrutenberg.com/
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
