From: Kevin Startup <kevin@awcsl.com>
Subject: Re: ALSA SOC Driver (mxs-wm8753)
Date: Wed, 23 Jul 2014 08:40:47 +0000
Message-ID: <70b465c86c5f4e868db55b1d08211e1f@DB4PR07MB252.eurprd07.prod.outlook.com>
References: <3c1cd0154ea542b992e00dce1cfc0a9a@DB4PR07MB252.eurprd07.prod.outlook.com>
 <20140718084415.GA12049@opensource.wolfsonmicro.com>
 <d387ffb22ab74e87aff415badb8b4dca@DB4PR07MB252.eurprd07.prod.outlook.com>
 <20140718105323.GB12049@opensource.wolfsonmicro.com>
 <f889954bfaf244cab1b9eb096c66fa81@DB4PR07MB252.eurprd07.prod.outlook.com>
 <20140718142830.GC12049@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from emea01-am1-obe.outbound.protection.outlook.com
 (mail-am1lp0017.outbound.protection.outlook.com [213.199.154.17])
 by alsa0.perex.cz (Postfix) with ESMTP id E167D265635
 for <alsa-devel@alsa-project.org>; Wed, 23 Jul 2014 10:40:49 +0200 (CEST)
In-Reply-To: <20140718142830.GC12049@opensource.wolfsonmicro.com>
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
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Charles

Thanks, we've started having a look at this but still not sure what the issue is, I'm hoping to employ some help from the i.MX manufacturer's support (it's quite expensive though!) but what is worrying us at the moment is that one of our suppliers is marking the WM8753 as "Obsolete" ?  I wonder if you knew what the lifetime for manufacturing this chip might be from Wolfson themselves?

Cheerz
Kevin

Kevin Startup
A.W. Communication Systems Ltd. 
email: kevin@awcsl.com
Tel: +44(0)1697 748717
Fax: +44(0)1697 748778

A.W. Communication Systems Ltd
VAT No. GB 827 4389 00
Registered No. 4891652
Registered Office Crook Barn, The Crook, Roweltown, Carlisle, UK

-----Original Message-----
From: Charles Keepax [mailto:ckeepax@opensource.wolfsonmicro.com] 
Sent: 18 July 2014 15:29
To: Kevin Startup
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] ALSA SOC Driver (mxs-wm8753)

On Fri, Jul 18, 2014 at 01:02:41PM +0000, Kevin Startup wrote:
> Hi Charles
> 
> Thanks very much, the pointers you gave me have helped a lot.  I have changed the reference to .codec_dai_name to "wm8753-hifi" in the mxs-wm8753.c program which has made my CPU recognise the WM8753 as a valid ALSA device!
> This makes me very happy as I have been trying to get this to happen for several weeks now!
> 
> I still don't seem to be able to send sound to the device though.
> I am now receiving this message:
> 
> mxs-i2c 80058000.i2c: PIO: Failed to finish WRITE cmd!
> 
> This happens a dozen times or so on bootup and any time that I try to write to one of the PCM devices ....
> I wonder if you could give me any more pointers?
> 
> Many Thanks
> Kevin

Looks like probably the i2c transactions are not being acked, afraid I don't know much about the i2c driver in question so not really sure. I assume this is the i2c link to the CODEC, so I would check the CODECs reset lines and supplies to make sure it has everything it needs to respond.

Thanks,
Charles
