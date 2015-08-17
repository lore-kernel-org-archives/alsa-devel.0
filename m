From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: probe issue for Dice/OXFW drivers
Date: Tue, 18 Aug 2015 00:30:44 +0900
Message-ID: <55D1FE24.80707@sakamocchi.jp>
References: <55CA9C07.40702@sakamocchi.jp> <55CB0FF1.1040100@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id DA5A6260474
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 17:30:49 +0200 (CEST)
In-Reply-To: <55CB0FF1.1040100@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Etilem <contact@etilem.net>
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

On Aug 12 2015 18:20, Clemens Ladisch wrote:
>>                ROM header and bus information block
>> -----------------------------------------------------------------
>> 400  0404f507  bus_info_length 4, crc_length 4, crc 62727
>> 404  31333934  bus_name "1394"
>> 408  e0008102  irmc 1, cmc 1, isc 1, bmc 0, cyc_clk_acc 0, max_rec 8 (512)
>> 40c  000ff210  company_id 000ff2     |
>> 410  01800af7  device_id 1001800af7  | EUI-64 000ff21001800af7
>>
>>                root directory
>> -----------------------------------------------------------------
>> 414  000639d3  directory_length 6, crc 14803
>> 418  03000ff2  vendor
>> 41c  8100000a  --> descriptor leaf at 444
>> 420  17000006  model
>> 424  8100000d  --> descriptor leaf at 458
>> 428  0c0087c0  node capabilities per IEEE 1394
>> 42c  d1000001  --> unit directory at 430
>>
>>                unit directory at 430
>> -----------------------------------------------------------------
>> 430  00045246  directory_length 4, crc 21062
>> 434  12000ff2  specifier id
>> 438  13000001  version
>> 43c  17000006  model
>> 440  8100000b  --> descriptor leaf at 46c
> 
> The dice_interface_check() function then makes other checks:
> /*
>  * Check that GUID and unit directory are constructed according to DICE
>  * rules, i.e., that the specifier ID is the GUID's OUI, and that the
>  * GUID chip ID consists of the 8-bit category ID, the 10-bit product
>  * ID, and a 22-bit serial number.
>  */
> 
> These values are correct, except for the category ID.

Aha. I've overlooked this case. I assumed that we can see 'No such
device' in syslog, due to returning -ENODEV.

> The driver already has an category ID exception for Weiss devices.
> It would be possible to add another exception, but given that firmware
> writers apparently like to change this value without good reason, it
> might be a better idea to just remove the category ID check.

Sounds to work, while I've never read such a specification about the
Dice rule (I'm not so good at Dice itself). Is it possible that you post
patches for this issue?


Regards

Takashi Sakamoto
