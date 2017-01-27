From: John Rigg <aldev2@jrigg.co.uk>
Subject: Re: Cannot combine audio devices with more than
	64	channels
Date: Fri, 27 Jan 2017 20:25:22 +0000
Message-ID: <20170127202521.GA23636@localhost.localdomain>
References: <CAKw=HF0hbhxJ1YGjukjFr72xtEh2FjtH6k0Bh+rFcMwejgwcUg@mail.gmail.com>
 <1cdef19b-a458-7441-2ede-2ba8984ec7cd@ladisch.de>
 <s5hh94khiao.wl-tiwai@suse.de>
 <CAKw=HF1H6BCrvgm_8eL3f-L0yoKrqTqBib0kE4z0o73yzGqPKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vm2962.vps.tagadab.com (vm2962.vps.tagadab.com [95.172.24.202])
 by alsa0.perex.cz (Postfix) with ESMTP id D37FA267AC0
 for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2017 21:55:05 +0100 (CET)
Received: from m0 by vm2962.vps.tagadab.com with local (Exim 4.69)
 (envelope-from <noreply@jrigg.co.uk>) id 1cXD5G-00069W-0X
 for alsa-devel@alsa-project.org; Fri, 27 Jan 2017 20:25:22 +0000
Content-Disposition: inline
In-Reply-To: <CAKw=HF1H6BCrvgm_8eL3f-L0yoKrqTqBib0kE4z0o73yzGqPKg@mail.gmail.com>
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

On Fri, Jan 27, 2017 at 02:03:16PM +0100, J=F6rg M=FCller wrote:
> So I want to apply that patch to my system (Ubuntu Studio 14.04). How
> do I proceed? I guess, the patch wont be available via apt-get soon,
> right?
> So I'd have to compile from source.
> 1. What source code packages do I need to download?
> 2. I'm familiar with the usual "/.configure", "make" and "sudo make
> install" but in the case of this specific alsa-module, is there
> anything more I'd need to do?

One method is to download alsa-lib source, apply the patch, compile
and install over the top of the existing Ubuntu libasound2 files.

Another method is to build your own patched libasound2 .deb
package to replace the standard Ubuntu one.

I'll be applying the patch here on Debian using the first method.
If you need instructions on how to do that, feel free to email
me off list at 'john.rigg.audio at gmail.com' (gmail doesn't like
my own mail server so I need to use that address to send mail to
gmail users).

John
