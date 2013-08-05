From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: rt5640: change widget sequence for
 depop
Date: Mon, 05 Aug 2013 19:21:21 +0200
Message-ID: <51FFDF11.5020106@metafoo.de>
References: <1375676343-13891-1-git-send-email-bardliao@realtek.com>
 <20130805144808.GG9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-190.synserver.de (smtp-out-190.synserver.de
 [212.40.185.190])
 by alsa0.perex.cz (Postfix) with ESMTP id 473B226508F
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 19:20:18 +0200 (CEST)
In-Reply-To: <20130805144808.GG9858@sirena.org.uk>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, swarren@nvidia.com, swarren@wwwdotorg.org, lgirdwood@gmail.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

On 08/05/2013 04:48 PM, Mark Brown wrote:
> On Mon, Aug 05, 2013 at 12:19:03PM +0800, bardliao@realtek.com wrote:
>> From: Bard Liao <bardliao@realtek.com>
>>
>> Add mute/unmute control in widget event and modify the power on/off sequence to avoid pop noise.
> 
> This looks like you should be using Lars-Peter's patch for controls that
> are disabled while a widget isn't powered - as far as I can tell from a
> quick read through all this does is keep the speaker/headphone muted
> while the outputs are powered down.

The driver is using stereo controls though. So either support for stereo
controls needs to be added to DAPM (which shouldn't be too hard) or the
control needs to be split into two mono controls.

- Lars
