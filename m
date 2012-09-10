From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: snd-intel-hda: screaming IRQ with 3.5.3 kernel
	(HDMI)
Date: Mon, 10 Sep 2012 14:21:54 -0700 (PDT)
Message-ID: <1347312114.44166.YahooMailNeo@web120301.mail.ne1.yahoo.com>
References: <504B4F2D.40002@yahoo.com> <s5hligitcd0.wl%tiwai@suse.de>
 <1347272938.6237.YahooMailNeo@web120301.mail.ne1.yahoo.com>
 <s5hfw6qtbhq.wl%tiwai@suse.de>
Reply-To: Chris Rankin <rankincj@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm4-vm1.bullet.mail.ne1.yahoo.com
 (nm4-vm1.bullet.mail.ne1.yahoo.com [98.138.91.44])
 by alsa0.perex.cz (Postfix) with SMTP id 73382260744
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 23:21:56 +0200 (CEST)
In-Reply-To: <s5hfw6qtbhq.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

----- Original Message -----

>=A0 Did you try any workaround boot options such as irqpoll, pci=3Dnocrs o=
r whatever?

Actually, it turns out that booting with "irqpoll=3D1" simply means that th=
is problem takes longer to happen:

irq 17: nobody cared (try booting with the "irqpoll" option)
Pid: 3347, comm: wineserver Not tainted 3.5.3 #2
Call Trace:
=A0[<c1063806>] ? __report_bad_irq+0x11/0x94
=A0[<c1063a2d>] ? note_interrupt+0x120/0x19b
=A0[<c1062325>] ? handle_irq_event_percpu+0xe8/0xfb
=A0[<c1062361>] ? handle_irq_event+0x29/0x40
=A0[<c1064163>] ? handle_fasteoi_irq+0x67/0x90
=A0[<c1003957>] ? handle_irq+0x63/0x70
=A0[<c1003625>] ? do_IRQ+0x2e/0x83
=A0[<c1229829>] ? common_interrupt+0x29/0x30
handlers:
[<f8d09b75>] azx_interrupt [snd_hda_intel]
Disabling IRQ #17

Cheers,
Chris
