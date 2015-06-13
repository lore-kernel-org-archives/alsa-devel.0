From: Sergej Sawazki <ce3a@gmx.de>
Subject: Re: ASoC: How to declare volume TLV dB scale?
Date: Sat, 13 Jun 2015 12:45:21 +0200
Message-ID: <557C09C1.8060708@gmx.de>
References: <trinity-71513ec1-9daf-4f51-b0b3-8df7a0e9a7ec-1434110572856@3capp-gmx-bs58>	<557B08C6.7030300@ladisch.de>	<557B3260.30001@gmx.de>	<557B3762.20603@ladisch.de>	<s5hioas5ba2.wl-tiwai@suse.de>	<557C017D.5090604@gmx.de>
 <557C060F.3000209@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E0F2260515
 for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2015 12:45:25 +0200 (CEST)
In-Reply-To: <557C060F.3000209@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, 13 Jun 2015 12:29:35 +0200, Clemens Ladisch wrote:
> Sergej Sawazki wrote:
>> On Sat, 13 Jun 2015 09:15:49 +0200, Takashi Iwai wrote:

>>> And you need to implement the ctl get/put callback to revert the value
>>> as (0x3ff - raw value).  An decrement value isn't supposed to work.
>
> If you're using one of the SOC_xxx_TLV macros, you would set the 'invert'
> parameter.
>
>> I am getting the expected dB scaling with:
>> DECLARE_TLV_DB_MINMAX_MUTE(vol_tlv, -12800, 0)
>> does it make sense?
>
> Yes.  (-128 would have been -1.28 dB.)
>

Thanks.

Regards,
Sergej
