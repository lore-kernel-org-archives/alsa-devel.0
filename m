From: Ben Zhang <benzh@chromium.org>
Subject: Re: [PATCH] ASoC: rt5645: Add Mono ADC Boost Gain
	control
Date: Tue, 3 Nov 2015 00:56:27 -0500
Message-ID: <CAOV7ByLGQUjUdoWCy92WvseG5NWvGv=-w0+qMQq7zPhpfnV-mw@mail.gmail.com>
References: <1446525434-17922-1-git-send-email-benzh@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f175.google.com (mail-yk0-f175.google.com
 [209.85.160.175])
 by alsa0.perex.cz (Postfix) with ESMTP id E552F264F53
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2015 06:56:28 +0100 (CET)
Received: by ykft191 with SMTP id t191so6304044ykf.0
 for <alsa-devel@alsa-project.org>; Mon, 02 Nov 2015 21:56:28 -0800 (PST)
In-Reply-To: <1446525434-17922-1-git-send-email-benzh@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, Ben Zhang <benzh@chromium.org>, Bard Liao <bardliao@realtek.com>, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 2, 2015 at 11:37 PM, Ben Zhang <benzh@chromium.org> wrote:
> "Mono ADC Boost Gain" (MX-20h) is a coarse capture volume
> control with a step of 12dB on the Mono audio path. It is
> similar to the "STO1 ADC Boost Gain" control on the Stereo1
> audio path.
>
> Signed-off-by: Ben Zhang <benzh@chromium.org>

Please ignore this patch. The control has already been added by commit
8c1a9d6323ab
("ASoC: rt5645: Correct the naming and setting of ADC Boost Volume Control")

Oder, thanks for pointing me to the existing patch.
