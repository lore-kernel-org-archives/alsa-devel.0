From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH v5] ASoC: add RT286 CODEC driver
Date: Fri, 21 Mar 2014 05:57:49 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D73A3762@RTITMBSV03.realtek.com.tw>
References: <1394521896-27721-1-git-send-email-bardliao@realtek.com>
 <20140314191244.GZ366@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D73A0212@RTITMBSV03.realtek.com.tw>
 <20140318130137.GZ11706@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 17E73265313
 for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2014 06:57:55 +0100 (CET)
In-Reply-To: <20140318130137.GZ11706@sirena.org.uk>
Content-Language: zh-TW
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Tuesday, March 18, 2014 9:02 PM
> To: Bard Liao
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; Flove; Oder Chiou;
> Gustaw Lewandowski
> Subject: Re: [PATCH v5] ASoC: add RT286 CODEC driver
> 
> On Tue, Mar 18, 2014 at 12:41:41PM +0000, Bard Liao wrote:
> 
> Please fix your mailer to word wrap within paragraphs, this will make your mail
> more legible.

Now I set 80 characters to wrap the text. Hope it can work.

> 
> > A verb command contains three parts, NID, VID, and PID.
> > For example, if I want to unmute headphone, I should set:
> > VID = 3'h (Set Amplifier Gain)
> > NID = 22'h (headphone)
> > PID = b000'h (Set left, right output unmute)
> 
> So VID+NID is an address and PID is a value?

For I2C write, yes.
But for I2C read, I think PID is also a part of address. Because PID is meaningful in the I2C read protocol.
For example, if we need to get the mute/unmute status of headphone, we need to set:
VID = b'h (Get Amplifier Gain)
NID = 22'h (Headhoone)
PID = a000'h (Left output amplifier gain is requested)
And we can get response from rt286.

I am trying to implement my reg_write and reg_read to:
reg_write: address: VID+NID, value: PID
reg_read: address: VID+NID+PID, value: the responding data from rt286.

Thanks.
