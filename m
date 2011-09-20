From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 1/1] ymfpci - enable rear device and dup4ch
 control when ac97 support 4 channels
Date: Tue, 20 Sep 2011 14:41:26 +0800
Message-ID: <CAN8cciaF-D-E8gzYNqNdcDK=jZ1RqsSWs8zRbYV=-OGb0fo2Bw@mail.gmail.com>
References: <CAN8cciZR6U-7ctVRsA72RFjU-3d6RLnLkbc2Ac2cb7YPy5=tjg@mail.gmail.com>
	<s5h8vpjsp7f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 93132103857
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Sep 2011 08:41:26 +0200 (CEST)
Received: by fxe22 with SMTP id 22so233647fxe.38
	for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2011 23:41:26 -0700 (PDT)
In-Reply-To: <s5h8vpjsp7f.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

2011/9/20 Takashi Iwai <tiwai@suse.de>:
> At Mon, 19 Sep 2011 21:51:11 +0800,
> Raymond Yau wrote:
>>
>> ymfpci - enable rear device and dup4ch control when ac97 support 4 channels
>
> You mean _only_ when ac97 supports, right?
> A bit more patch description would be helpful.
> There are more free spaces in the changelog area :)
>


http://thread.gmane.org/gmane.linux.alsa.devel/89391

I want to remove "rear" device from my mf724f since it only has three
jacks, (i.e. blue , pink and green) and stac9704

It seem that those ymf7xx does not support I2S Output

According to 744 and 754 datasheet , it support multiple ac97 but
snd-ymfpci does not support secodary ac97 , so the patch only check
the sdac bit the primary ac97 codec
