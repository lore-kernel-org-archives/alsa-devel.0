From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: Testing SAI with mainline
Date: Mon, 7 Mar 2016 12:51:09 -0800
Message-ID: <20160307205109.GA10095@Asurada-Nvidia>
References: <CAOMZO5DnC7NGd1+QPzeaVQ0GMY_yxq3KZBQSAOoj+QKQ8W+HfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E12826154F
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2016 21:50:51 +0100 (CET)
Received: by mail-pa0-f53.google.com with SMTP id bj10so84989145pad.2
 for <alsa-devel@alsa-project.org>; Mon, 07 Mar 2016 12:50:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAOMZO5DnC7NGd1+QPzeaVQ0GMY_yxq3KZBQSAOoj+QKQ8W+HfQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Zidan Wang <zidan.wang@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 07, 2016 at 05:44:08PM -0300, Fabio Estevam wrote:
> Hi,
> 
> I am trying to get SAI to work on a mx6sx sdb board.
> 
> Here are the changes I made:
> http://pastebin.com/aq32B24v

Can't access your link.
 
> I can see the driver getting probed:
> 
> [    2.198276] fsl-asoc-card sound: wm8962 <-> 21d4000.sai mapping ok
> 
> ,but when attempting a playback it fails:
> 
> $ aplay clarinet.wav
> [  110.843619] fsl-sai 21d4000.sai: isr: Transmit underrun detected
> [  110.849841] fsl-sai 21d4000.sai: isr: Transmit underrun detected
> [  110.855995] fsl-sai 21d4000.sai: isr: Transmit underrun detected
> 
> (repeats forever).
> 
> Any ideas as to how to get SAI working on this platform?

You need a dts patch to configure SDMA channels via GPR. I don't have
it on hand. May send you after I get home.

> 
> Zidan,
> 
> How have you tested SAI when you usptream the driver?
> 
> Thanks
