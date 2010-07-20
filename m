From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH - alsa-lib 2/3] tlv: Handle 'holes' in
 SND_CTL_TLVT_DB_RANGE array
Date: Tue, 20 Jul 2010 09:59:54 +0100
Message-ID: <20100720085954.GJ10222@rakim.wolfsonmicro.main>
References: <1279523646-4987-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100719170947.GA5950@rakim.wolfsonmicro.main>
	<s5hbpa3z5lz.wl%tiwai@suse.de>
	<201007200953.22169.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 773B21038E8
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jul 2010 10:59:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201007200953.22169.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: ext Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 20, 2010 at 09:53:22AM +0300, Peter Ujfalusi wrote:

> I don't really know how many of these driver would require new TLV entry, but 
> the twl4030, and tpa6130a2 (for tpa6140a2 chip) does not needed new entry, just 
> modification of the TLV items.

If we're going to go down this road all of them will at least require
modification.

> I agree with Mark in regards, that the decision making is strictly 
> policy/userspace stuff, but I also think that the drivers should also provide as 
> much, and as accurate information to user space to make this decision (if it is 
> in form of overlapped mapping, than like that).

I agree here, I just think that the overlapping ranges don't add
anything to the information that's being provided.
