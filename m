From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: cs4271.c: improve error handling
Date: Tue, 25 Jan 2011 15:12:32 +0000
Message-ID: <1295968352.3322.250.camel@odin>
References: <1295637727.1561.9.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 706A9103929
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 16:12:36 +0100 (CET)
Received: by wyi11 with SMTP id 11so5670252wyi.38
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 07:12:36 -0800 (PST)
In-Reply-To: <1295637727.1561.9.camel@r60e>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexander Sverdlin <subaparts@yandex.ru>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-01-21 at 22:22 +0300, Alexander Sverdlin wrote:
> From: Alexander Sverdlin <subaparts@yandex.ru>
> 
> CS4271 CODEC driver adapted to recently introduced error handling in
> snd_soc_update_bits().
> Added snd_soc_cache_sync() error handling.
> 
> Signed-off-by: Alexander Sverdlin <subaparts@yandex.ru>
> ---

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
