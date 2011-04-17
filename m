From: "Sebastian H." <vand2@gmx.de>
Subject: Re: alsa-lib: snd_mixer_selem_is_active changes
 -	which event?
Date: Sun, 17 Apr 2011 14:09:42 +0200
Message-ID: <4DAAD886.8090202@gmx.de>
References: <4D5ACED8.5030707@gmx.de>	<BANLkTimkDFUybYQK+AzDpq_n0LDH86oYGQ@mail.gmail.com>
	<4DAAD7B9.1010205@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by alsa0.perex.cz (Postfix) with SMTP id 443591037FF
	for <alsa-devel@alsa-project.org>;
	Sun, 17 Apr 2011 14:09:44 +0200 (CEST)
In-Reply-To: <4DAAD7B9.1010205@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Am 17.04.2011 14:06, schrieb Sebastian H.:

> Mask 3 seems to be
> SND_CTL_EVENT_MASK_VALUE & SND_CTL_EVENT_MASK_INFO ( 1 & 2 )
Better
SND_CTL_EVENT_MASK_VALUE | SND_CTL_EVENT_MASK_INFO ( 1 | 2 )
