From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH] Sound, Cirrus: Remove redundant check
Date: Sat, 20 Aug 2011 00:16:57 +0000
Message-ID: <CAOZdJXUOLmT1eGZ7wEtk_UacYCPVz_caZwsnOPE_jFNq5svc-g@mail.gmail.com>
References: <alpine.LNX.2.00.1108192358510.31857@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE004.bigfish.com (am1ehsobe004.messaging.microsoft.com
	[213.199.154.207])
	by alsa0.perex.cz (Postfix) with ESMTP id 0D7CD10381A
	for <alsa-devel@alsa-project.org>;
	Sat, 20 Aug 2011 02:17:36 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.1108192358510.31857@swampdragon.chaosbits.net>
Content-Language: en-US
Content-ID: <03857FCAF66FB8489DA0F53167FB72D9@freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jesper Juhl <jj@chaosbits.net>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Stephen Warren <swarren@nvidia.com>, Takashi Iwai <tiwai@suse.de>, Vince Weaver <vweaver1@eecs.utk.edu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Edgar (gimli)
	Hucek" <gimli@dark-green.com>, Tim Howe <tim.howe@cirrus.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 19, 2011 at 6:00 PM, Jesper Juhl <jj@chaosbits.net> wrote:
> The variable 'idxp' is a pointer to 'unsigned int', so the value
> obtained when dereferencing it is always greater than or equal to
> 0. Testing this is redundant.

snd_hda_get_conn_index() can return a negative number, so maybe *idxp
should be a pointer to a signed int?

-- 
Timur Tabi
Linux kernel developer at Freescale
