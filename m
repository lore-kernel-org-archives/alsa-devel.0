From: Guy Rutenberg <guyrutenberg@gmail.com>
Subject: Re: Exclusive access to capture device
Date: Sun, 24 Jun 2012 23:48:59 +0300
Message-ID: <CADfV-LFEoFa7moFiR7AiJBGwJkTPpVbh=uV0KpwG8PjqTG46Qw@mail.gmail.com>
References: <CADfV-LHztneYAZJusarOSTv3qXuECWqrQajqLEKCsJC82yvULA@mail.gmail.com>
	<CADfV-LGfSwGU6fdBeWqtW4-4rpux0NeneV=7uEe4dFbyBs9NGA@mail.gmail.com>
	<CAPAActe9s54_8BiwiR+wrWUTfOtzAEJ6ycAhWaeK2h9EgoLBDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5BA59243FF
	for <alsa-devel@alsa-project.org>;
	Sun, 24 Jun 2012 22:49:20 +0200 (CEST)
Received: by obbeh20 with SMTP id eh20so5254936obb.38
	for <alsa-devel@alsa-project.org>; Sun, 24 Jun 2012 13:49:19 -0700 (PDT)
In-Reply-To: <CAPAActe9s54_8BiwiR+wrWUTfOtzAEJ6ycAhWaeK2h9EgoLBDQ@mail.gmail.com>
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

Hi Sean,

On Sun, Jun 24, 2012 at 11:31 PM, Sean McNamara <smcnam@gmail.com> wrote:
>
>
> Hopefully you aren't writing a desktop application, because distros
> and users generally abhor the notion of an application "hogging" the
> sound device for any reason, and would prefer that all access be
> non-exclusive. But if you're coding for an embedded device, then I can
> understand this approach.
>
> I'm actually writing a desktop application. The idea is to extract random
bits from microphone in order to create a true random number generator
(after being extracted the bits go through an unbiasing phase and
compression by a hash function to increase entropy). So I intentionally
want to hog the sound device, as to be sure that nobody else is recording
at the same time I'm gathering entropy.

So basically I want to temporarily disable any hardware/software mixing on
the mixing device. Is it possible given user privileges? Assuming
root privileges?

Thanks,

Guy
