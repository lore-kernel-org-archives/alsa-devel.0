From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Implementing sync start
Date: Mon, 10 Aug 2009 08:41:20 -0400
Message-ID: <9e4733910908100541y495f491cy7a25351a8c36f3dd@mail.gmail.com>
References: <9e4733910908081116p221e606cma31a95b06d9b5be6@mail.gmail.com>
	<9e4733910908082007n5d2e7f48g453b1f2e3c6eb23e@mail.gmail.com>
	<9e4733910908091913j63debfefja44e8e04e278e087@mail.gmail.com>
	<9e4733910908091919o617eb1b8r44436cd87a6873ff@mail.gmail.com>
	<4A7FCF0A.1000806@ladisch.de>
	<9e4733910908100445u3ea02395y9dc39b73ad41cb6b@mail.gmail.com>
	<4A800B47.6020201@ladisch.de>
	<9e4733910908100524w510ba17ep2d6482cdfad57597@mail.gmail.com>
	<4A8012B4.5000009@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f203.google.com (mail-yw0-f203.google.com
	[209.85.211.203])
	by alsa0.perex.cz (Postfix) with ESMTP id C33DC103896
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Aug 2009 14:41:21 +0200 (CEST)
Received: by ywh41 with SMTP id 41so4317151ywh.23
	for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2009 05:41:21 -0700 (PDT)
In-Reply-To: <4A8012B4.5000009@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 10, 2009 at 8:29 AM, Clemens Ladisch<clemens@ladisch.de> wrote:
> Jon Smirl wrote:
>> If I didn't use sync start wouldn't I be vulnerable to user space
>> getting delayed between the start calls?
>
> Linked substreams are handled by ALSA's kernel part with a loop inside
> a spinlock.

Linking via  snd_soc_dai_link or is there another way to link?

static struct snd_soc_dai_link dspeak01_fabric_dai[] = {
{
	.name = "I2S-0",
	.stream_name = "I2S-0",
	.codec_dai = &pcm1690_dai,
	.ops = &dspeak01_fabric_ops,
},
{
	.name = "I2S-1",
	.stream_name = "I2S-1",
	.codec_dai = &pcm1690_dai,
	.ops = &dspeak01_fabric_ops,
},
};



>
>
> Best regards,
> Clemens
>



-- 
Jon Smirl
jonsmirl@gmail.com
