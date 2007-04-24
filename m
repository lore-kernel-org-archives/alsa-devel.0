From: Daniel James <daniel@64studio.com>
Subject: Re: crash/reboot with rawmidi on ice1712 dual opteron
Date: Tue, 24 Apr 2007 16:03:56 +0100
Message-ID: <462E1C5C.8070304@64studio.com>
References: <461FD727.8080400@bome.com>	<s5hfy6zcmtc.wl%tiwai@suse.de>	<4626361D.3080801@bome.com>	<s5hmz0y0w6m.wl%tiwai@suse.de>	<462E12F8.3090005@64studio.com>
	<s5hwt01zvuj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pythagoras.zen.co.uk (pythagoras.zen.co.uk [212.23.3.140])
	by alsa0.perex.cz (Postfix) with ESMTP id C803224906
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Apr 2007 17:04:30 +0200 (CEST)
In-Reply-To: <s5hwt01zvuj.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Florian <alsa@bome.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

> The most important thing is to find out what triggers which result.
> As far as I understand from Florian's analysis, the io-port access
> results in a machine reboot, not a kernel panic or so.

In my case, I saw a hard lock-up as soon as I typed the name of any MIDI 
program, even 'aconnect'. There was no panic or log information, just a 
complete freeze.

Cheers!

Daniel
