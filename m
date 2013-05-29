From: Nicolas Schichan <nschichan@freebox.fr>
Subject: Re: [PATCH 0/2] ASoC: cs42l52: HP gain enum and PCM
 Mixer dB scale fixes.
Date: Wed, 29 May 2013 20:13:57 +0200
Message-ID: <51A64565.3010503@freebox.fr>
References: <1369850480-1772-1-git-send-email-nschichan@freebox.fr>
 <20130529180353.GD5930@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ns.iliad.fr (ns.iliad.fr [212.27.33.1])
 by alsa0.perex.cz (Postfix) with ESMTP id 9487B265004
 for <alsa-devel@alsa-project.org>; Wed, 29 May 2013 20:13:58 +0200 (CEST)
In-Reply-To: <20130529180353.GD5930@opensource.wolfsonmicro.com>
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
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Georgi Vlaev <joe@nucleusys.com>
List-Id: alsa-devel@alsa-project.org

On 05/29/2013 08:03 PM, Mark Brown wrote:
> On Wed, May 29, 2013 at 08:01:18PM +0200, Nicolas Schichan wrote:
>> Hi,
>>
>> The two patches in the serie contains the following fixes:
>>
>> - Use the correct shift value in hp_gain_enum, effectively allowing
>>    the higher gain values to be effective and the correct gain value to
>>    be reported to userland wrt what is written to the register.
>
> To repeat what I said last time you should use my current e-mail
> address.

Sorry about that, I had missed the message you send yesterday.

-- 
Nicolas Schichan
Freebox SAS
