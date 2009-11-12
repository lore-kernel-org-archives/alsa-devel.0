From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: need support for insatllation of pci sound card.
Date: Thu, 12 Nov 2009 16:27:43 -0500
Message-ID: <604760770911121327w872f3dftfca7347322ed1743@mail.gmail.com>
References: <daf8bdba0911121306j3bb7b3ffo3efcf7c14793196f@mail.gmail.com>
	<daf8bdba0911121311j1f7be714w73b8aab1496c3788@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f190.google.com (mail-vw0-f190.google.com
	[209.85.212.190])
	by alsa0.perex.cz (Postfix) with ESMTP id 10C07103803
	for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2009 22:27:45 +0100 (CET)
Received: by vws28 with SMTP id 28so727578vws.16
	for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2009 13:27:44 -0800 (PST)
In-Reply-To: <daf8bdba0911121311j1f7be714w73b8aab1496c3788@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kunal Narkhede <kunal.narkhede@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 12, 2009 at 4:11 PM, Kunal Narkhede
<kunal.narkhede@gmail.com> wrote:
> alsa drivers with the provided one.My card seems to getting recognize but no
> sound is heard here is

This appears to be a mixer setting problem. What's unmuted/zeroed?

> I am usung* ubuntu 9.04 with 2.6.28-16-generic kerne*l installed through
> updates using update manager.

Please use your distribution's defect reporting mechanism. For Ubuntu
9.04, this would be opening Applications > Accessories > Terminal, and
using:

ubuntu-bug alsa-base

HTH,
Dan
