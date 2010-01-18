From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: How much of the X-Fi (emu20k1) chip has Creative
	documented?
Date: Mon, 18 Jan 2010 14:21:57 -0800 (PST)
Message-ID: <506940.60549.qm@web52907.mail.re2.yahoo.com>
References: <20100118155155.0f954199@darius>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web52907.mail.re2.yahoo.com (web52907.mail.re2.yahoo.com
	[206.190.49.17]) by alsa0.perex.cz (Postfix) with SMTP id 8D9E8103841
	for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2010 23:21:58 +0100 (CET)
In-Reply-To: <20100118155155.0f954199@darius>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brendan Pike <spike@spykes.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--- On Mon, 18/1/10, Brendan Pike <spike@spykes.net> wrote:
> The matrix is horribly out of date. Yes PCIe cards
> (emu20k2) are supported. HWMix also exists and works perfectly,
That's interesting! Can you post the output of

/proc/asound/<X-Fi card>/pcm0p/info

please?
 
> I use an Auzentech X-Fi Forte myself, which works great.

Are the emu20k1 cards equally well supported? It looks like emu20k2 cards are exclusively PCIe, whereas I'd probably be looking for a PCI card.

Thanks,
Chris
