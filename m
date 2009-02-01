From: Florian Faber <faber@faberman.de>
Subject: Re: RME HDSP rev 37 does not work on 64-bit linux
Date: Sun, 1 Feb 2009 18:03:10 +0100
Message-ID: <200902011803.10924.faber@faberman.de>
References: <70a871c80902010708s2a10ff8bobe79622949da62fe@mail.gmail.com>
	<70a871c80902010846i1059ab26t63c1d7e530126caf@mail.gmail.com>
	<4985D442.50509@klingt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from india820.server4you.de (india820.server4you.de [85.25.152.101])
	by alsa0.perex.cz (Postfix) with ESMTP id D5D0A24395
	for <alsa-devel@alsa-project.org>; Sun,  1 Feb 2009 18:03:11 +0100 (CET)
In-Reply-To: <4985D442.50509@klingt.org>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sunday 01 February 2009 17:56:34 Tim Blechmann wrote:
> >>> under 32-bit ubuntu 8.10 with the same kernel 2.6.27-11-generic and
> >>> the same version of alsa-*: 1.0.17-0ubuntu1,
> >>> everything works fine both with cold boot + hdsploader and winxp ->
> >>> reboot-> no hdsploader.
> >>
> >> It works fine with 64 bit linux, I have pure 64 bit machines and all
> >> hdsp(e) cards work as they should. Must be something else then.
> >
> > Which distribution/kernel(s) do you use?
> >
> > I just revived my 64-bit Gentoo partition, and vanilla 2.6.28.2 says
> > No Multiface or Digiface found, disabling the card.
>
> i have the same issue with my hdsp on a 64-bit kernel, using the
> standard firmware (whatever is shipped with alsa). once i tried to debug
> this issue, finding, that the card actually has the register value that
> the card is not connected, although it is.
>
> usually, unloading/reloading the kernel module should resolve it,
> though. maybe the hardware is not initialized correctly? are there some
> more detailed information about the hdsp hardware available or did the
> developers of the kernel module receive some specification under nda
> restrictions?

Ok, you two, please mail me the relevant contents of dmesg and the contents 
of /proc/asound/cardX/hdsp together with a 'uname -a'.

All I can say is that it works fine with all 2.6 kernels so far and I have 
never used anything else but 64bit.


Flo
-- 
Machines can do the work, so people have time to think.
public key 6C002249          x-hkp://wwwkeys.eu.pgp.net
