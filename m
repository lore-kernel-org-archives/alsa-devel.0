From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Intel SST on a Bay Trail tablet
Date: Mon, 24 Aug 2015 14:28:21 -0500
Message-ID: <55DB7055.2020104@linux.intel.com>
References: <20150824132904.GA665@acervm.homenet.telecomitalia.it>
 <20150824142625.GM13546@localhost> <20150824181731.GA471@asus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F9832608CF
 for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2015 21:28:18 +0200 (CEST)
In-Reply-To: <20150824181731.GA471@asus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michele Curti <michele.curti@gmail.com>, Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, ao2@ao2.it, jarkko.nikula@linux.intel.com, lk@bazdara.com
List-Id: alsa-devel@alsa-project.org

On 8/24/15 1:17 PM, Michele Curti wrote:
> On Mon, Aug 24, 2015 at 07:56:25PM +0530, Vinod Koul wrote:
>> On Mon, Aug 24, 2015 at 03:29:04PM +0200, Michele Curti wrote:
>>>
>>> Damn, completely missed..
>>>
>>> Hi Vinod,
>>> if it's possible, could you please generate a fw_sst_0f28_ssp1.bin
>>> also, so I can test my driver (mine was for the Asus X205TA laptop,
>>> where the codec is on SSP1 port)?
>>
>> Are you sure you ahve SSP1 port enabled. I have not seen anyone using that
>> one. Jarkko do you know about this?
>>
>> I will ask firmware folks for generation (i don't do that) and get back
>>
>
> Yes, I can confirm, SSP1 in under LPEA
>
>      Scope (_SB)
>      {
>          Device (LPEA)
>          {
>              Name (_ADR, Zero)  // _ADR: Address
>              Name (_HID, "80860F28" /* Intel SST Audio DSP */)  // _HID: Hardware ID
>
>              ... snip ...
>
>              Device (SSP1)
>              {
>                  Name (_ADR, Zero)  // _ADR: Address
>                  Name (_HID, "SSPX0000" /* Intel SSP Device */)  // _HID: Hardware ID
>                  Name (_CID, "SSPX0000" /* Intel SSP Device */)  // _CID: Compatible ID
>
> Full dsdt.dsl here:
> https://github.com/michelecurti/x205ta/blob/master/dsdt.dsl

No idea why the BIOS vendor thought here, we don't handle the SSPX0000 
(illegal) _HID and we have no driver to load against... This SSP1 entry 
will be ignored in Linux.
Probably only used by Windows for Bluetooth HFP, see the DSM that 
returns ("BLUET")

    Device (SSP1)
             {
                 Name (_ADR, Zero)  // _ADR: Address
                 Name (_HID, "SSPX0000" /* Intel SSP Device */)  // 
_HID: Hardware ID
                 Name (_CID, "SSPX0000" /* Intel SSP Device */)  // 
_CID: Compatible ID
                 Name (_DDN, "Intel(R) SSP Device")  // _DDN: DOS Device 
Name
                 Name (_UID, One)  // _UID: Unique ID
                 Method (_STA, 0, NotSerialized)  // _STA: Status
                 {
                     If ((OSSL & 0x80)) <<< OSSL==0x08, test fails
                     {
                         Return (0x0F)
                     }

                     Return (Zero) <<<<< device is not reported present 
to kernel
                 }
