From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] ASoC: core: cache index fix
Date: Sun, 7 Aug 2011 04:02:23 +0100
Message-ID: <20110807030223.GA9579@sirena.org.uk>
References: <65EE16ACC360FA4D99C96DC085B3F7721F427D@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5hy5zcnlu8.wl%tiwai@suse.de>
	<65EE16ACC360FA4D99C96DC085B3F7721F43AA@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5hoc08nk7t.wl%tiwai@suse.de>
	<65EE16ACC360FA4D99C96DC085B3F7721F443D@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5hlivcnhe2.wl%tiwai@suse.de>
	<65EE16ACC360FA4D99C96DC085B3F7721F45A8@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5haabsnfg2.wl%tiwai@suse.de>
	<20110802154815.GE25884@opensource.wolfsonmicro.com>
	<4E3D8F73.40902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C534F2417B
	for <alsa-devel@alsa-project.org>;
	Sun,  7 Aug 2011 05:02:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E3D8F73.40902@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: preetam <preetamsashankreddy@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 07, 2011 at 12:31:07AM +0530, preetam wrote:

Don't start a new thread by replying to completely unrelated mails,
write a new mail to the list.

> I am writing an SoC driver. I have the need to power up the Playback and 
> Capture parts of the device separately depending on the call to codec 
> structure. How can I identify the stream as playback or capture in 
> set_bias call back. It only gets a codec pointer and a state.

You can't.  You should be using DAPM for this, not set_bias_level().
