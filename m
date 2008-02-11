From: "Daniele (Mastro)" <daniele.bilug@gmail.com>
Subject: Re: Notebook Toshiba satellite x200-21g with realtek
 snd-hda-intel audio device still not supported (codec ALC268)
Date: Mon, 11 Feb 2008 23:58:33 +0100
Message-ID: <47B0D319.2000702@gmail.com>
References: <47672BCB.9080608@gmail.com>	<476912F3.8090609@gmail.com>	<476A2BCC.4060109@gmail.com>	<s5h1w9h4g5d.wl%tiwai@suse.de>	<47727C6C.6080401@gmail.com>	<1198815321.3732.229.camel@razman.gruemaster.com>	<47B06DEF.4070609@gmail.com>
	<s5htzkfv5jp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 983CE2441E
	for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2008 23:58:38 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id l27so3875511fgb.44
	for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2008 14:58:38 -0800 (PST)
In-Reply-To: <s5htzkfv5jp.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai ha scritto:
> Note that these are no errors but just debug information.

ok.. so, are they useful?

> Try the patch below.  This should fix the capture source problem on
> ALC268.

ok i'll try as soon as i can..
with what "model" param should i create the alsa-info.sh log? test? default?

> The modem is a different problem.  There are only certain model chips
> that can work with slmodemd.  Non si3054-compatible (typically
> conexant ones) don't work.

i think i was not very clear about this...
i can't see anywhere something like a modem on lspci or lsusb... i think 
the modem is "inside" the audio card and for some reason it is ignored...
this is why i think it's alsa-related

have i explained myself now?

-- 
Iscritto alla ML del BiLUG da Lun 27 Mar 2006 21:39:26 CEST
Utilizzatore di Linux dal Luglio 2006

blog: http://natonelbronx.wordpress.com/
Daniele
