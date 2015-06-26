From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [alsa-devel] [V2 PATCH] ALSA: hda - Enable mute/mic-mute LEDs
 for more Thinkpads with Conexant codec
Date: Fri, 26 Jun 2015 19:49:47 -0300
Message-ID: <20150626224946.GA11254@khazad-dum.debian.net>
References: <53B51B63.8060809@canonical.com>
 <53B51CF3.8090102@web.de>
 <53B52146.9050300@canonical.com>
 <55603F22.8070103@web.de>
 <CAN8cciZYZ4setSj7dgPqQUVrBrr98tSvofLrD_0zvyQqkWfd2Q@mail.gmail.com>
 <5560A93E.7060607@web.de>
 <558A4216.8010401@web.de>
 <558A6E80.7010003@canonical.com>
 <558BDFD4.9060301@web.de>
 <558CB778.5020307@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <558CB778.5020307@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hui Wang <hui.wang@canonical.com>
Cc: Jan Kiszka <jan.kiszka@web.de>, Raymond Yau <superquad.vortex2@gmail.com>, alex.hung@canonical.com, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Hui Wang <jason77.wang@gmail.com>, tiwai@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

On Fri, 26 Jun 2015, Hui Wang wrote:
> >Again, I'm on a X121e, and that has only a single physical LED for
> >signaling the power state. The mute button is behind key combination of
> >the keyboard.
> >
> >Jan
> There is no reason to change a power button to a reset button after
> accessing the acpi device "SSMS", the "SSMS" is for the mute led instead of
> the power management.
> 
> I think it is better you login to the lenovo website and look for the latest
> BIOS image, then upgrade the BIOS on your machine to see if it can solve the
> problem or not.

Hmm, I think I am missing something here.

Please explain _in detail_ what you mean with "changing a power button to a
reset button by acessing the SSMS ACPI method in a X121e".

Are we trigering a bug somewhere that crashes the x121e and causes it to
reboot?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
