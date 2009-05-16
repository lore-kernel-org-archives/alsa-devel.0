From: Karthik Ramgopal <applefreakpeeps@gmail.com>
Subject: Re: Regarding Sound on Acer Aspire 6935G
Date: Sat, 16 May 2009 11:51:36 +0800
Message-ID: <4b8c423b0905152051w7443e1b4u4080514a560fbb6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.247])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A1C0243ED
	for <alsa-devel@alsa-project.org>;
	Sat, 16 May 2009 05:51:37 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id k29so1060760rvb.32
	for <alsa-devel@alsa-project.org>; Fri, 15 May 2009 20:51:36 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
       Even after enabling DEBUG using --with-debug option with configure
when compiling the alsa-driver snapshot leaves no more error messages in the
dmesg logs. The only message relating to HDA is:

[   41.104817] hda-intel: IRQ timing workaround is activated for card #0.
Suggest a bigger bdl_pos_adj.

I just got the line-out output to work by toggling the surround volume. I
still think it's a mapping problem. The headphone switch is turning the
subwoofer on and off, and the surround volume is controlling the line-out
volume. None of the line-in devices function and all of the amp-ins 0x0b to
0x0f are muted. Cannot find any verb to unmute them. hda-verb with
SET_EAPD_BTLENABLE 2 at 0x15 is still needed at startup to fire up the amps.


Please help.

Regards,
Karthik
