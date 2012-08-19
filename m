From: David Dillow <dave@thedillows.org>
Subject: Re: [PATCH 7/9] sound/pci/sis7019.c: fix error return code
Date: Sun, 19 Aug 2012 19:04:16 -0400
Message-ID: <1345417456.5651.4.camel@obelisk.thedillows.org>
References: <1345359780-18647-1-git-send-email-Julia.Lawall@lip6.fr>
	 <1345359780-18647-5-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1345359780-18647-5-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Jaroslav Kysela <perex@perex.cz>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2012-08-19 at 09:02 +0200, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Initialize rc before returning on failure, as done elsewhere in the
> function.

> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Acked-by: David Dillow <dave@thedillows.org>
