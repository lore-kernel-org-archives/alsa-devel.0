From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: probe issue for Dice/OXFW drivers
Date: Wed, 12 Aug 2015 11:20:49 +0200
Message-ID: <55CB0FF1.1040100@ladisch.de>
References: <55CA9C07.40702@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id AEE4B260438
 for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2015 11:20:55 +0200 (CEST)
In-Reply-To: <55CA9C07.40702@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Etilem <contact@etilem.net>
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> Recently, I received an issue from a user of Mackie Onyx-i series.
> According to the user, snd-dice is not applied to his Dice model.
> [...] According to the log, I cannot find the first
> transaction which snd-dice performs. Additionally, no error messages in
> syslog.

There are some checks performed before the first actual transaction.

The kernel loads the driver if an entry in dice_id_table[] matches, i.e.,
if version==1.  This values indeed is in the unit directory:

>                ROM header and bus information block
> -----------------------------------------------------------------
> 400  0404f507  bus_info_length 4, crc_length 4, crc 62727
> 404  31333934  bus_name "1394"
> 408  e0008102  irmc 1, cmc 1, isc 1, bmc 0, cyc_clk_acc 0, max_rec 8 (512)
> 40c  000ff210  company_id 000ff2     |
> 410  01800af7  device_id 1001800af7  | EUI-64 000ff21001800af7
>
>                root directory
> -----------------------------------------------------------------
> 414  000639d3  directory_length 6, crc 14803
> 418  03000ff2  vendor
> 41c  8100000a  --> descriptor leaf at 444
> 420  17000006  model
> 424  8100000d  --> descriptor leaf at 458
> 428  0c0087c0  node capabilities per IEEE 1394
> 42c  d1000001  --> unit directory at 430
>
>                unit directory at 430
> -----------------------------------------------------------------
> 430  00045246  directory_length 4, crc 21062
> 434  12000ff2  specifier id
> 438  13000001  version
> 43c  17000006  model
> 440  8100000b  --> descriptor leaf at 46c

The dice_interface_check() function then makes other checks:
/*
 * Check that GUID and unit directory are constructed according to DICE
 * rules, i.e., that the specifier ID is the GUID's OUI, and that the
 * GUID chip ID consists of the 8-bit category ID, the 10-bit product
 * ID, and a 22-bit serial number.
 */

These values are correct, except for the category ID.

The driver already has an category ID exception for Weiss devices.
It would be possible to add another exception, but given that firmware
writers apparently like to change this value without good reason, it
might be a better idea to just remove the category ID check.


Regards,
Clemens
