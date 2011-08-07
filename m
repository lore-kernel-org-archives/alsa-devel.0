From: preetam <preetamsashankreddy@gmail.com>
Subject: Re: [PATCH 1/1] ASoC: core: cache index fix
Date: Sun, 07 Aug 2011 09:42:05 +0530
Message-ID: <4E3E1095.3090809@gmail.com>
References: <65EE16ACC360FA4D99C96DC085B3F7721F427D@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5hy5zcnlu8.wl%tiwai@suse.de>
	<65EE16ACC360FA4D99C96DC085B3F7721F43AA@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5hoc08nk7t.wl%tiwai@suse.de>
	<65EE16ACC360FA4D99C96DC085B3F7721F443D@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5hlivcnhe2.wl%tiwai@suse.de>
	<65EE16ACC360FA4D99C96DC085B3F7721F45A8@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5haabsnfg2.wl%tiwai@suse.de>
	<20110802154815.GE25884@opensource.wolfsonmicro.com>
	<4E3D8F73.40902@gmail.com> <20110807030223.GA9579@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f43.google.com (mail-pz0-f43.google.com
	[209.85.210.43]) by alsa0.perex.cz (Postfix) with ESMTP id 1106024382
	for <alsa-devel@alsa-project.org>;
	Sun,  7 Aug 2011 06:12:11 +0200 (CEST)
Received: by pzk1 with SMTP id 1so343485pzk.2
	for <alsa-devel@alsa-project.org>; Sat, 06 Aug 2011 21:12:10 -0700 (PDT)
In-Reply-To: <20110807030223.GA9579@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sunday 07 August 2011 08:32 AM, Mark Brown wrote:
> On Sun, Aug 07, 2011 at 12:31:07AM +0530, preetam wrote:
>
> Don't start a new thread by replying to completely unrelated mails,
> write a new mail to the list.
>
>> I am writing an SoC driver. I have the need to power up the Playback and
>> Capture parts of the device separately depending on the call to codec
>> structure. How can I identify the stream as playback or capture in
>> set_bias call back. It only gets a codec pointer and a state.
> You can't.  You should be using DAPM for this, not set_bias_level().
Then what is the ideal use case of set_bias_level ?
