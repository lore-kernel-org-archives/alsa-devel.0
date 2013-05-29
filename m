From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/2] ASoC: cs42l52: HP gain enum and PCM
 Mixer dB scale fixes.
Date: Wed, 29 May 2013 19:03:53 +0100
Message-ID: <20130529180353.GD5930@opensource.wolfsonmicro.com>
References: <1369850480-1772-1-git-send-email-nschichan@freebox.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0084A26504A
 for <alsa-devel@alsa-project.org>; Wed, 29 May 2013 20:03:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1369850480-1772-1-git-send-email-nschichan@freebox.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolas Schichan <nschichan@freebox.fr>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Georgi Vlaev <joe@nucleusys.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 29, 2013 at 08:01:18PM +0200, Nicolas Schichan wrote:
> Hi,
> 
> The two patches in the serie contains the following fixes:
> 
> - Use the correct shift value in hp_gain_enum, effectively allowing
>   the higher gain values to be effective and the correct gain value to
>   be reported to userland wrt what is written to the register.

To repeat what I said last time you should use my current e-mail
address.
