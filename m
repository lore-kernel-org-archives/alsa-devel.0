From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: ALSA SOC Driver (mxs-wm8753)
Date: Fri, 18 Jul 2014 15:28:30 +0100
Message-ID: <20140718142830.GC12049@opensource.wolfsonmicro.com>
References: <3c1cd0154ea542b992e00dce1cfc0a9a@DB4PR07MB252.eurprd07.prod.outlook.com>
 <20140718084415.GA12049@opensource.wolfsonmicro.com>
 <d387ffb22ab74e87aff415badb8b4dca@DB4PR07MB252.eurprd07.prod.outlook.com>
 <20140718105323.GB12049@opensource.wolfsonmicro.com>
 <f889954bfaf244cab1b9eb096c66fa81@DB4PR07MB252.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8A09E265649
 for <alsa-devel@alsa-project.org>; Fri, 18 Jul 2014 16:28:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f889954bfaf244cab1b9eb096c66fa81@DB4PR07MB252.eurprd07.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kevin Startup <kevin@awcsl.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

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

Looks like probably the i2c transactions are not being acked,
afraid I don't know much about the i2c driver in question so not
really sure. I assume this is the i2c link to the CODEC, so I
would check the CODECs reset lines and supplies to make sure it
has everything it needs to respond.

Thanks,
Charles
