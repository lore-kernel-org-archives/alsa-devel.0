From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v2 3/3] ALSA: SoC: Updating jack implementation according
 new ALSA Jacks
Date: Mon, 29 Jul 2013 09:03:40 -0600
Message-ID: <51F6844C.7030109@wwwdotorg.org>
References: <1374878713-11922-1-git-send-email-eu@felipetonello.com> <1374878713-11922-4-git-send-email-eu@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1374878713-11922-4-git-send-email-eu@felipetonello.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Felipe F. Tonello" <eu@felipetonello.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, David Henningsson <david.henningsson@canonical.com>, Wang Xingchao <xingchao.wang@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

On 07/26/2013 04:45 PM, Felipe F. Tonello wrote:
> Updating the ASoC jack support to add the ability to specify a
> jack index when creating it.

This also appears to rename a number of jacks. If that's intentional,
presumably it should be mentioned in the commit description?
