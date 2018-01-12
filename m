From: "Kumar, Abhijeet" <abhijeet.kumar@intel.com>
Subject: Re: [PATCH] ASoC: hdac_hdmi: Ensuring proper setting
 of output widget power state
Date: Fri, 12 Jan 2018 10:37:28 +0000
Message-ID: <60213CA7255C53479ADE3BCF0360117F02E7124F@PGSMSX104.gar.corp.intel.com>
References: <1515670468-9198-1-git-send-email-abhijeet.kumar@intel.com>
 <20180112054638.GL18649@localhost>
 <d84bdde7-2eda-ab2b-adce-b689b4222838@intel.com>
 <s5hefmvpgwe.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 185B8266D71
 for <alsa-devel@alsa-project.org>; Fri, 12 Jan 2018 11:37:33 +0100 (CET)
In-Reply-To: <s5hefmvpgwe.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Koul,
 Vinod" <vinod.koul@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Singh,
 Guneshwor O" <guneshwor.o.singh@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Kp, Jeeja" <jeeja.kp@intel.com>, "Tayal,
 SandeepX" <sandeepx.tayal@intel.com>, "Prusty,
 Subhransu S" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

> It's better, but doesn't guarantee that the node reached the given power state.  codec_read assures that the verb is sent and the codec gives the response.  But it means only the target state gets updated, and doesn't mean that the actual state reached.

Thanks Takashi for replying. I guess, I  should make use of return value from codec_read and retry if power state is not set properly! I'll make those changes and update again. And just wondering, how does hdmi_codec_prepare() and hdmi_codec_complete() gurantee while powering up and down the afg ?

Warm Regards,
Abhijeet
