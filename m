From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to inform application about sample rate
 changed from device.
Date: Mon, 3 Dec 2018 17:45:24 +0100
Message-ID: <36937bd6-2c0f-2f58-07ed-f67288104b3d@ladisch.de>
References: <CALW20Z03dWeGNjZJpPaN=aH2xwDtSJCi=VU0uKYw77Yx9ureqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 05A7D267ACE
 for <alsa-devel@alsa-project.org>; Mon,  3 Dec 2018 17:45:39 +0100 (CET)
Received: from olorin.ladisch.de (x2f7fac0.dyn.telefonica.de [2.247.250.192])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id F1D865583B27
 for <alsa-devel@alsa-project.org>; Mon,  3 Dec 2018 17:45:38 +0100 (CET)
In-Reply-To: <CALW20Z03dWeGNjZJpPaN=aH2xwDtSJCi=VU0uKYw77Yx9ureqg@mail.gmail.com>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Chakravarthi Pradeep wrote:
> When device is generating audio sample rate of 44.1KHz then how to
> inform VLC that use 44.1KHz sample rate(same is for 96KHz)

ALSA PCM devices have constraints that restrict what parameters
applications can configure.

Usually, the constraints are installed when the PCM device is opened.
Change runtime->hw.rate_min/_max to the same value.


Regards,
Clemens
