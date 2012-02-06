From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [patch] ALSA: hda/realtek - cleanup a condition
Date: Mon, 06 Feb 2012 09:06:11 +0100
Message-ID: <4F2F89F3.4060301@canonical.com>
References: <20120206075218.GA14304@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 021731039B7
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 09:06:17 +0100 (CET)
In-Reply-To: <20120206075218.GA14304@elgon.mountain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 02/06/2012 08:52 AM, Dan Carpenter wrote:
> Sparse complains that "spec->multiout.dac_nids" is a pointer.
>
> sound/pci/hda/patch_realtek.c:2321:37: error: incompatible types for operation (>)
> sound/pci/hda/patch_realtek.c:2321:37:    left side has type unsigned short const [usertype] *dac_nids
> sound/pci/hda/patch_realtek.c:2321:37:    right side has type int
>
> I think the intent here was just to check if it was non-NULL, but please
> double check.

It could also have meant to be "if (spec->multiout.num_dacs > 0)", but 
either way, it seems very unlikely that the condition is false.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
