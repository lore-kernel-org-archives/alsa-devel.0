From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH 1/4] cs42l52: use same init values for
 MASTERA_VOL/MASTERB_VOL.
Date: Wed, 22 May 2013 18:42:51 +0000
Message-ID: <5B689238-AB18-487A-B87E-1CA691DA3272@cirrus.com>
References: <1369243167-28700-1-git-send-email-nschichan@freebox.fr>
 <1369243167-28700-2-git-send-email-nschichan@freebox.fr>,
 <20130522183425.GW1627@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A8C82608ED
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2013 20:43:03 +0200 (CEST)
In-Reply-To: <20130522183425.GW1627@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Georgi Vlaev <joe@nucleusys.com>, Nicolas Schichan <nschichan@freebox.fr>
List-Id: alsa-devel@alsa-project.org



On May 22, 2013, at 8:34, "Mark Brown" <broonie@kernel.org> wrote:

> On Wed, May 22, 2013 at 07:19:24PM +0200, Nicolas Schichan wrote:
>> 
>> Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>
> 
> Why?
> 
>> -    { CS42L52_MASTERB_VOL, 0x00 },    /* r21 Master B Volume */
>> +    { CS42L52_MASTERB_VOL, 0x88 },    /* r21 Master B Volume */
> 
> Note that the register defaults need to reflect the default value
> for the registers.

Your right Mark. I missed that. These registers should be default of 0x00.

Thanks
