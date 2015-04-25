From: Mike Ood <jh1ood@gmail.com>
Subject: Re: snd-bebob and PrismSound Orpheus fails with
	snd_pcm_hw_params_set_channels
Date: Sat, 25 Apr 2015 20:53:59 +0900
Message-ID: <CAJ0eYfV59Oruz3mX+5qORaLOFPRY+oHEarZK42ozO7tCZzHgew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vn0-f53.google.com (mail-vn0-f53.google.com
 [209.85.216.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 729BC2614FF
 for <alsa-devel@alsa-project.org>; Sat, 25 Apr 2015 13:54:04 +0200 (CEST)
Received: by vnbf190 with SMTP id f190so6554017vnb.1
 for <alsa-devel@alsa-project.org>; Sat, 25 Apr 2015 04:54:01 -0700 (PDT)
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

Mike Ood wrote:


> As for me, clock source settings, etc.,
> which is written into its EEPROM when powered off,
> can be occasionally set via the control program
> by PrismSound either on Windows/OS X,
> only when it becomes necessary.
>

I think I was at least partially wrong.

The manual says:
http://www.prismsound.com/music_recording/products_subs/orpheus/online_manual/index.html
 (Contents -> Orpheus hardware -> Stand-alone operation):

---------------------------------
 Stand-alone operation
 ---------------------------------

It is possible to operate Orpheus without a FireWire connection to a host
computer.
This is done by setting up the unit as required using the Orpheus Control
Panel applet
whilst it is connected to a host computer via its FireWire interface,
then placing the unit in standby by pressing the standby button,
before disconnecting the unit from the host and power source.

When the unit is re-powered,
and detects that no FireWire connection is active,  <========== I missed
this part!
it reloads the settings which were previously stored.

As Takashi Sakamoto mentioned:

> Currently, libffado has a bug to fail to switch clock
> source for usual BeBoB driver.
> So we have no way to set the source of clock correctly.
> I've tried to fix it but get stuck deeply into
> ffado's fault and given up.

this could be a problem for me, too.

Anyway, the functionality I expect snd-bebob to have is
no more than what is offered by juju+libffado+jack.

Mike Ood
