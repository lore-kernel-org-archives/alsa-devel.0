From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 3/4] ASoC: simple-card: add multi-CODECs
	in DT
Date: Mon, 10 Nov 2014 09:39:57 +0100
Message-ID: <3271244.uSgBKXChSS@wuerfel>
References: <cover.1415605716.git.moinejf@free.fr>
 <d49d348da24fbd96e7be51ba2839ee8bc821ddec.1415605717.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BB39260650
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 09:39:59 +0100 (CET)
In-Reply-To: <d49d348da24fbd96e7be51ba2839ee8bc821ddec.1415605717.git.moinejf@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sunday 09 November 2014 12:22:21 Jean-Francois Moine wrote:
> -- sound-dai                            : phandle and port of CPU/CODEC
> +either
> +  - sound-dai                          : phandle and port of CPU/CODEC
> +or
> +  - sound-dais                         : list of phandle and port of CODECs

Is it really necessary to change the property name here? I woudl think
that you can make it all work more consistently with just the existing
'sound-dai' property, just extend it to allow multiple codecs

	Arnd
