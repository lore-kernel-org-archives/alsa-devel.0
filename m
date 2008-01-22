From: "Claudio Matsuoka" <cmatsuoka@gmail.com>
Subject: Re: how do you people debug ALSA?
Date: Tue, 22 Jan 2008 10:14:05 -0200
Message-ID: <5f52f6d70801220414p52dda529p73681799295d420b@mail.gmail.com>
References: <012120082025.22241.4794FFC1000089D6000056E122243651029B0A02D2089B9A019C04040A0DBF050C079D0E960E03@att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.189])
	by alsa0.perex.cz (Postfix) with ESMTP id BB12F24AE2
	for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2008 13:14:09 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so1756967rvb.32
	for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2008 04:14:05 -0800 (PST)
In-Reply-To: <012120082025.22241.4794FFC1000089D6000056E122243651029B0A02D2089B9A019C04040A0DBF050C079D0E960E03@att.net>
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
To: mazarick@bellsouth.net
Cc: wavepro-driver-developers@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Jan 21, 2008 6:25 PM,  <mazarick@bellsouth.net> wrote:

> 2.  The GL card is powered from an Altera PLD (FPGA) (it has similar function as the Envy ICE chip once it's loaded).   For the card to function at all, the Altera PLD has to be loaded when power is applied
> to the computer.   Should the 'load the Altera' function be part of the alsa driver, part of alsa firmware, or
> should we just load it up when the computer boots (not in alsa)?

You could check how the wireless card drivers (e.g. ipw2200) install
their firmware code during module loading. I think it's the most
common instance of firmware loading, I would also investigate the
kernel firmware subsystem to see how it works.
