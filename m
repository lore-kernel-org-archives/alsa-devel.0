From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: [PATCH] ASoC: soc-core: Remove display_register()
	callback
Date: Wed, 2 Feb 2011 09:50:40 -0500
Message-ID: <AANLkTing5zryWWt4HZHGUd15-6mrxpnRwA8EEiE8DGem@mail.gmail.com>
References: <1296642054-10485-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<20110202102335.GM12743@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B78510380B
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2011 15:50:41 +0100 (CET)
Received: by gyg8 with SMTP id 8so8566gyg.38
	for <alsa-devel@alsa-project.org>; Wed, 02 Feb 2011 06:50:41 -0800 (PST)
In-Reply-To: <20110202102335.GM12743@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 2, 2011 at 5:23 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Feb 02, 2011 at 10:20:54AM +0000, Dimitris Papastamos wrote:
>> Remove the display_register() callback as there are no users of it
>> in the upstream kernel and makes it difficult to unify the format
>> of the codec_reg file.
>
>> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
>
> This was rather strongly requested for some devices with extremely large
> registers (128 bits at least IIRC) which may eventually make it to
> mainline. =A0It seems better to just have some sort of fallback for those
> devices, if it causes output problems people can always fix those.
>

TI Codec devices have two problems:
1) large registers - up to 128 bits
2) sparse register maps - big gaps between valid register addresses.



-- =

Jon Smirl
jonsmirl@gmail.com
