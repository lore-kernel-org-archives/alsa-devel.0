From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Question about Conversion to S24_LE from S24_3LE
Date: Mon, 18 Apr 2016 11:32:32 +0200
Message-ID: <5714A9B0.8060002@ladisch.de>
References: <61B6C8BF61481342973655BC8AB0FF355AE2F4@PGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 33989265019
 for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2016 11:34:12 +0200 (CEST)
In-Reply-To: <61B6C8BF61481342973655BC8AB0FF355AE2F4@PGSMSX101.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Tan, Seng Kai" <seng.kai.tan@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Tan, Seng Kai wrote:
> I am facing similar problem like this issue, hope to get your advice.
> http://mailman.alsa-project.org/pipermail/alsa-devel/2012-August/054241.html

And the answer is the same.

> I try to turn on S24_LE support for HDMI Audio using below patch.

Your hardware does not support S24_LE.

24-bit samples use the S32_LE format (unless you have very exotic
hardware, but HDA isn't).

> Back end  S24_LE :  0x00123456(in 4bytes, MSB 0 padding)

This is how S24_LE works.

> Can you advice how to tell the alsa plugin to pad in LSB instead of MSB?

Use S32_LE.


Regards,
Clemens
