From: Nicolas Schichan <nschichan@freebox.fr>
Subject: Re: [PATCH 1/4] cs42l52: use same init values for
	MASTERA_VOL/MASTERB_VOL.
Date: Thu, 23 May 2013 15:17:24 +0200
Message-ID: <519E16E4.1030604@freebox.fr>
References: <1369243167-28700-1-git-send-email-nschichan@freebox.fr>
 <1369243167-28700-2-git-send-email-nschichan@freebox.fr>
 <20130522183425.GW1627@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ns.iliad.fr (ns.iliad.fr [212.27.33.1])
 by alsa0.perex.cz (Postfix) with ESMTP id 20C58261A22
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2013 15:17:25 +0200 (CEST)
In-Reply-To: <20130522183425.GW1627@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Georgi Vlaev <joe@nucleusys.com>
List-Id: alsa-devel@alsa-project.org

On 05/22/2013 08:34 PM, Mark Brown wrote:
> On Wed, May 22, 2013 at 07:19:24PM +0200, Nicolas Schichan wrote:
>>
>> Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>
>
> Why?
>
>> -	{ CS42L52_MASTERB_VOL, 0x00 },	/* r21 Master B Volume */
>> +	{ CS42L52_MASTERB_VOL, 0x88 },	/* r21 Master B Volume */
>
> Note that the register defaults need to reflect the default value
> for the registers.

I was not aware of that, The solution would be then to fix MASTERB_VOL default 
value to 0x00 instead to 0x88. Shall I just send an updated version of the 
patch or the whole serie ?

Regards,

-- 
Nicolas Schichan
Freebox SAS
