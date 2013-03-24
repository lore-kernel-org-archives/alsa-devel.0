From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: need help for PCM constraint/rules
Date: Sun, 24 Mar 2013 20:12:16 +0100
Message-ID: <514F5010.5000707@ladisch.de>
References: <514F0696.1030109@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 4DE022602C6
 for <alsa-devel@alsa-project.org>; Sun, 24 Mar 2013 20:13:35 +0100 (CET)
In-Reply-To: <514F0696.1030109@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> My device (AudioFirePre8) changes its channels according to sampling rate. For example:
> 32.0  - 48.0kHz  : 16ch: efw->channels_sets[0]
> 88.2  - 96.0kHz     : 12ch: efw->channels_sets[1]
> 176.4 - 192.0kHz : 10ch: efw->channels_sets[2] (but not available)
>
> I managed to write this rule refering to rme9652.c but I cannot achieve my purpose.

These functions should be essentially identical with dice_*_constraint().


Regards,
Clemens
