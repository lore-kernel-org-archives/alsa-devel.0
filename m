From: Mikel =?utf-8?b?R2FyY8OtYQ==?= <mikelgate@gmail.com>
Subject: Re: Support new HDA codec
Date: Sun, 25 Aug 2013 09:44:09 +0000 (UTC)
Message-ID: <loom.20130825T113629-740@post.gmane.org>
References: <AB277FB27524F74C87ACAFF84F2767490D5205C4E2@NTMBOX.central.cirsa.com>
 <s5hehtkxma6.wl%tiwai@suse.de>
 <20120225115048.GD3167@opensource.wolfsonmicro.com>
 <s5hpqd23i5s.wl%tiwai@suse.de>
 <20120227135131.GD3191@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id CBDE32617A4
 for <alsa-devel@alsa-project.org>; Sun, 25 Aug 2013 11:50:05 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1VDWxQ-0003fk-E0
 for alsa-devel@alsa-project.org; Sun, 25 Aug 2013 11:50:04 +0200
Received: from 189.85-86-166.dynamic.clientes.euskaltel.es ([85.86.166.189])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sun, 25 Aug 2013 11:50:04 +0200
Received: from mikelgate by 189.85-86-166.dynamic.clientes.euskaltel.es with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sun, 25 Aug 2013 11:50:04 +0200
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

Mark Brown <broonie <at> opensource.wolfsonmicro.com> writes:

> 
> On Sat, Feb 25, 2012 at 07:02:55PM +0100, Takashi Iwai wrote:
> 
> > OK.  BTW, what is the name of the codec chip?  WM8800?
> 
> It'll be WM8850 or WM8860 - the two chips are indistinguishable from
> software.  WM8800 is another variant but it is not generally available,
> though I appreciate it is what the ID register reads back.
> 
> 
> On Sat, Feb 25, 2012 at 07:02:55PM +0100, Takashi Iwai wrote:
> 
> > OK.  BTW, what is the name of the codec chip?  WM8800?
> 
> It'll be WM8850 or WM8860 - the two chips are indistinguishable from
> software.  WM8800 is another variant but it is not generally available,
> though I appreciate it is what the ID register reads back.
> 

Hello, a this moment with a 3.7.10 kernel and debian wheezy I only have
control of the Master volume with the generic parser (wm8850). Only one
output can be controlled. No inputs are detected. What do you mean with
appropriate bios setup? Do you know if there is more compatibility in higher
kernels?

Thank you.
