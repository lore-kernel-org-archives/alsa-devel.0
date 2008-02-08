From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: HG vs GIT
Date: Fri, 8 Feb 2008 00:42:23 +0000
Message-ID: <20080208004222.GA14698@sirena.org.uk>
References: <Pine.LNX.4.58.0802070440430.9968@shell4.speakeasy.net>
	<s5hbq6szylg.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0802070538120.9968@shell4.speakeasy.net>
	<s5h8x1wzxl0.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0802071450530.8113@tm8103.perex-int.cz>
	<s5h63x0zwtv.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0802070731570.9968@shell4.speakeasy.net>
	<s5hwspgycso.wl%tiwai@suse.de>
	<20080207194624.GB30831@sirena.org.uk>
	<s5hve5033nk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id EFB6D24683
	for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2008 01:42:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hve5033nk.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, Trent Piepho <xyzzy@speakeasy.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 07, 2008 at 09:36:15PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > 	make M=${PWD} -C /lib/modules/$(uname -r)/build

> The external build itself is relatively easy.  We have already such
> stuff in alsa-driver tree.  Just needs a slight change to remap the
> directories properly in linux kernel tree instead of alsa-kernel
> tree.

> What I mentioned is to merge changesets properly from one tree to
> another old tree.  Maybe a kind of cherry picking would do that.

The thing I was thinking of above was taking a vanilla kernel tree and
building a subdirectory of that as though it were out of tree.  This
lets you use a vanilla git tree with the headers and config of a second
kernel tree (eg, a distro supplied one), meaning that from a revision
control point of view there's nothing fancy going on.
