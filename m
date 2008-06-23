From: "Jin-Young Park" <mcjin02@gmail.com>
Subject: Re: wrong print debugging message code
Date: Tue, 24 Jun 2008 03:18:49 +0900
Message-ID: <280b69ac0806231118n2349bedbl1b9462ecd5f1ecf3@mail.gmail.com>
References: <280b69ac0806202244s11e74363l4de3f020fed849be@mail.gmail.com>
	<s5habhc4dz6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.158])
	by alsa0.perex.cz (Postfix) with ESMTP id A242824902
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Jun 2008 20:18:52 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 36so340274yxh.2
	for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2008 11:18:51 -0700 (PDT)
In-Reply-To: <s5habhc4dz6.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lg@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hello.

I tested the code that "#define XXXX_DEBUG 0" on our company EVB with
WM8960.
I defined "#define XXXX_DEBUG 0" and dbg() put into mute
function(wm8960_digital_mute()).
After linux boot, played audio file.
My test dbg() message was not print terminal, but I find dbg() code was
working exactly.
Excuted dmesg command, then it was print that logged dbg() messages.
I think, it maybe potential that reduce performance before one knows.

Thanks.
Jinyoung Park.
