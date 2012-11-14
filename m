From: Daniel Mack <zonque@gmail.com>
Subject: Re: HIFACE family driver
Date: Wed, 14 Nov 2012 20:44:10 +0800
Message-ID: <50A3921A.4030907@gmail.com>
References: <50A3750A.70401@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-da0-f51.google.com (mail-da0-f51.google.com
 [209.85.210.51])
 by alsa0.perex.cz (Postfix) with ESMTP id E490C2616BB
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2012 13:44:36 +0100 (CET)
Received: by mail-da0-f51.google.com with SMTP id t11so161247daj.38
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2012 04:44:35 -0800 (PST)
In-Reply-To: <50A3750A.70401@amarulasolutions.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Michael,

On 14.11.2012 18:40, Michael Trimarchi wrote:
> I have written in my spare time an alsa driver for HIFACE devices
> family. Now I'm not an alsa expert and I would like to know if you
> think that it's useful to include it in mainline
> 
> https://github.com/panicking/snd-usb-asyncaudio
> 
> The list of usb devices supported
> 
> https://github.com/panicking/snd-usb-asyncaudio/blob/master/chip.c

We've already seen this - very cool!

> The main difference is that I need to use bulk message to talk to the
> usb dongle and ofcourse there are a lot of improvement that we can do
> on it. I have already tested on several kernel version and it's
> already included in some linux distribution. Wait for some feedback
> ;)

More than welcome :) You should submit your current version of the code
in digestable pieces. Maybe the basic driver structure first, and then
put individual features into additional patches if possible. That way,
things can be reviewed in-line on the mailing list.


Thanks,
Daniel
