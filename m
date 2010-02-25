From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [alsa-cvslog] alsa-kernel: Official ALSA project
	GIT repository for Linux 2.6 branch,
	master now at v2.6.31-rc8-407-gfc9e4a3
Date: Fri, 26 Feb 2010 07:52:09 +0800
Message-ID: <4f3252891002251552v17057febg83e039a8e9159175@mail.gmail.com>
References: <20091006063609.B06E110381F@alsa0.perex.cz>
	<s5hab05role.wl%tiwai@suse.de> <4ACAF4AC.3000608@ladisch.de>
	<s5h4oqdrlys.wl%tiwai@suse.de> <4ACDCAAB.2060609@ladisch.de>
	<s5h1vlexesm.wl%tiwai@suse.de> <4ACDDD22.1050309@ladisch.de>
	<4B84EE72.4060707@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id CA40110399C
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 00:52:16 +0100 (CET)
Received: by pwi9 with SMTP id 9so5414999pwi.38
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 15:52:15 -0800 (PST)
In-Reply-To: <4B84EE72.4060707@ladisch.de>
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

2010/2/24 Clemens Ladisch <clemens@ladisch.de>

> I wrote:
> > > > jmal8295 wrote:
> > > > > And I _will_ be regarding it as regression if I lose possibility to
> > > > > change volume of the four streams independently.
> >
> > Okay, I'll see if I can extend alsamixer ...
>
> Well, those controls are quite hardware-specific, and I always wanted to
> try out the Python wrappers, so I wrote a separate application.
>
> Honza, if you have a new kernel and the latest released alsa-lib and
> alsa-python packages, please try downloading the latest alsa-tools
> snapshot from <http://www.alsa-project.org/snapshot/> and check the
> hwmixvolume tool.
>
>
> Regards,
> Clemens
>

The characteristic of the VXS Volume controls are changed after the type of
the controls are changed from IFACE_MIXER to IFACE_PCM

extend alsamixer seem break the definition of those  IFACE_PCM PCM Playback
Volume control since the driver should reset IFACE_PCM PCM playback volume
to 0dB whenever the subdevice is opened since most of the alsa applications
don't check whether the sound card support hardware mixing
