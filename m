From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [ALSA] hda-codec - Fix laptop models for Cxt5045
Date: Tue, 1 Jul 2008 09:07:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0807010906240.20581@tm8103-a.perex-int.cz>
References: <871w2ea4ek.fsf@ixod.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id D5E0424809
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Jul 2008 09:07:33 +0200 (CEST)
In-Reply-To: <871w2ea4ek.fsf@ixod.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Mark T.B. Carroll" <mtbc@ixod.org>
Cc: ALSA development <alsa-devel@alsa-project.org>, Marc Boucher <marc@linuxant.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 30 Jun 2008, Mark T.B. Carroll wrote:

> Greetings. I thought I should mention that your patch
> http://kerneltrap.org/mailarchive/git-commits-head/2008/2/1/670694
> broke headphone sound for me on a Toshiba Satellite P105-S6197,
> sound card PCI ID 8086:27d8 with Conexant CX20549 codec. The speakers
> silence when I plug the headphones in but no sound comes from them.
> 
> Details are at http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=488063
> but half of my Debian bug reports go ignored for years.
> 
> A sufficient workaround for me is to comment out the `default:' in the
> `switch (board_config)' in the function `patch_cxt5045' in
> sound/pci/hda/patch_conexant.c. Then everything works fine again.
> 
> The same problem appears to be reported by evilviper77 at
> http://bbs.archlinux.org/viewtopic.php?pid=373770 - they have a
> Toshiba P105-9339.

CCing to alsa-devel mailing list.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
