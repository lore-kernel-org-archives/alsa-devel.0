From: Stephen Warren <swarren@nvidia.com>
Subject: Automatically disabling internal speakers when
 headphones are plugged in
Date: Thu, 20 Jan 2011 11:17:08 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310955716@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 529B524340
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 20:17:18 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Mark Brown (broonie@opensource.wolfsonmicro.com)" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I'm working on jack plug detect for Tegra Harmony, and have a question about
automatically disabling speakers when a headphone jack is plugged in.

For test purposes, I implemented this as follows:

static struct snd_soc_jack_pin harmony_hp_jack_pins[] = {
        {
	    .pin = "Headphone Jack",
	    .mask = SND_JACK_HEADPHONE,
	},
        {
	    .pin = "Int Spk",
	    .mask = SND_JACK_HEADPHONE,
	    .invert = 1,
	},
};

... following the example of:

omap/ams-delta.c
samsung/rx1950_uda1380.c
samsung/h1940_uda1380.c

However, I wonder if that's the correct approach; should the plug detect
logic only control the headphone output (i.e. only include the first array
entry in jack_pins[] above), and leave it up to user-space whether to
disable the speaker in this case, using a custom Speaker Function control
created by the machine driver, as I see many other drivers expose?

Do the jack reports make it up to user-space so that could be implemented?

Thanks.

-- 
nvpublic
