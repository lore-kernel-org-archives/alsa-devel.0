From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH v2 3/3] ASoC: cs42l73: Add Device Tree
 support for CS42L73
Date: Sun, 20 Oct 2013 22:00:22 +0000
Message-ID: <096B5FB2-DFF9-4F95-9839-0DFF3090448D@cirrus.com>
References: <1382124601-3317-1-git-send-email-brian.austin@cirrus.com>,
 <20131020173039.GQ2443@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 by alsa0.perex.cz (Postfix) with ESMTP id 500C12619E7
 for <alsa-devel@alsa-project.org>; Mon, 21 Oct 2013 00:01:11 +0200 (CEST)
In-Reply-To: <20131020173039.GQ2443@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org



> On Oct 20, 2013, at 12:30, "Mark Brown" <broonie@kernel.org> wrote:
> 
>> On Fri, Oct 18, 2013 at 02:30:01PM -0500, Brian Austin wrote:
>> This patch adds support for device tree for the CS42L73 CODEC
> 
> Applied, thanks, though this really ought to have been sent to the DT
> folks.
> 
Ok, so pretty much when it's device tree related it goes there?


>> +  - chgfreq    : Charge Pump Frequency values 0x00-0x0F
> 
> Can you please send a followup patch explaining what these values mean
> (eg, "Value written to register X")?
Thanks, I'll add more explaination
