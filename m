From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 3/3] ALSA SoC: Add
	Texas	Instruments	TLV320AIC26 codec	driver
Date: Tue, 15 Jul 2008 13:46:43 +0100
Message-ID: <20080715124642.GO25448@sirena.org.uk>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080712083939.15025.31192.stgit@trillian.secretlab.ca>
	<1216108672.9701.5.camel@dinesh.dua>
	<20080715103333.GM25448@sirena.org.uk>
	<1216125499.9701.16.camel@dinesh.dua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 004F724423
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Jul 2008 14:46:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1216125499.9701.16.camel@dinesh.dua>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: dinesh <dinesh.dua@coraltele.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 15, 2008 at 06:08:19PM +0530, dinesh wrote:
> thanks for your response but there is no /dev/snd directory in my file
> structure is there any special method to create it please tell in
> detail.

The devices appear via the standard kernel interfaces so if you are
using udev or mdev they should be created automatically.  Otherwise
you'll need to create them statically using whatever method you usually
use (eg, a MAKEDEV script supplied by your distribution or manually by
reference to the device numbers exposed in /sys/class/sound/*/dev).

The ALSA devices use the standard Linux mechanisms to create their
devices so whatever you normally use to create devices should work for
ALSA too.
