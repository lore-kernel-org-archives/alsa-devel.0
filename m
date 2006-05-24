From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: Re: [PATCH 2.6.17-rc2] ALSA: PCMCIA sound devices shouldn't depend on ISA
Date: Wed, 24 May 2006 22:46:53 +0200
Message-ID: <20060524204653.GA11570@dominikbrodowski.de>
References: <20060419144008.GD24807@harddisk-recovery.com> <1148357665.12529.17.camel@mindpipe> <s5hbqtoyj5w.wl%tiwai@suse.de> <1148401671.12529.59.camel@mindpipe> <20060524145800.GA2621@stud.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from linta.de (isilmar.linta.de [213.239.214.66])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 89D51171
	for <alsa-devel@alsa-project.org>; Wed, 24 May 2006 22:52:51 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <20060524145800.GA2621@stud.ntnu.no>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>, Takashi Iwai <tiwai@suse.de>, Erik Mouw <erik@harddisk-recovery.com>, alsa-devel@alsa-project.org, =?iso-8859-1?B?QXNiavhybiBT5mL4?= <asbjs@q2s.ntnu.no>, Linux PCMCIA development <linux-pcmcia@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Wed, May 24, 2006 at 04:58:00PM +0200, Asbj=F8rn S=E6b=F8 wrote:
> Note that the vxpocket must be hotplugged to be recognised. =20
> Cold-plugging it (having it already in the computer when booting) is no=
t=20
> sufficient.

Seems the driver needs a firmware which it cannot find:

> pcmcia: registering new device pcmcia1.0
...
> ALSA /home/asbjorn/alsa/alsa_1.0.11/alsa-driver-1.0.11/drivers/vx/../..=
/alsa-kernel/drivers/vx/vx_hwdep.c:62: vx: can't load firmware vx/bx_1_vx=
p.b56
...
> pccard: card ejected from slot 1
> pccard: PCMCIA card inserted into slot 1
> pcmcia: registering new device pcmcia1.0

	Dominik


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
