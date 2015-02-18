From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: baytrail-pcm-audio: audio broken on Lenovo
 Thinkpad Tablet 10
Date: Wed, 18 Feb 2015 16:51:05 +0200
Message-ID: <54E4A6D9.30005@linux.intel.com>
References: <54E2DE80.1060308@m-labs.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 79F8526007E
 for <alsa-devel@alsa-project.org>; Wed, 18 Feb 2015 15:51:22 +0100 (CET)
In-Reply-To: <54E2DE80.1060308@m-labs.hk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastien Bourdeauducq <sb@m-labs.hk>, alsa-devel@alsa-project.org
Cc: "oder_chiou@realtek.com >> Oder Chiou" <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

Hi

On 02/17/2015 08:24 AM, Sebastien Bourdeauducq wrote:
> Hi,
>
> the Thinkpad Tablet 10 has an impressive amount of problems under Linux,
> among which the audio is completely broken.
>
> The kernel log is:
> [    7.532413] rt5640 i2c-10EC5640:00: Device with ID register 6271 is
> not rt5640/39

Bard, Oder: Is this codec even from RT564x family? To me it looks RT567x 
based on RT5670_DEVICE_ID 0x6271 in sound/soc/codecs/rt5670.c.

At least sound/soc/codecs/rt5640.c: rt5640_i2c_probe() appears to find 
above same value 0x6271 from the register RT5640_VENDOR_ID2.

If that's the case then one might want to ask Lenovo why they are using 
completely wrong ACPI ID for the codec.

-- 
Jarkko
