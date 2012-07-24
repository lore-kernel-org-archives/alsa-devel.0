From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 1/2] ALSA: ASoC: add DT bindings for cs4270
Date: Tue, 24 Jul 2012 22:32:38 +0200
Message-ID: <500F0666.3030707@gmail.com>
References: <1343161248-27557-1-git-send-email-zonque@gmail.com>
 <500F0407.8090807@freescale.com> <500F050D.6080505@gmail.com>
 <500F05CC.2000105@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id A1C602652C8
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2012 22:32:39 +0200 (CEST)
Received: by wgbed3 with SMTP id ed3so5489122wgb.20
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2012 13:32:41 -0700 (PDT)
In-Reply-To: <500F05CC.2000105@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On 24.07.2012 22:30, Timur Tabi wrote:
> Daniel Mack wrote:
>> How do you instanciate it then? Somehow the DT core must know which
>> device to probe for a node, right?
> 
> drivers/of/of_i2c.c
> 
> It scans the device tree looking for I2C devices and registers them.
> 

Yes, I'm aware of this, I just wonder how does your DT note looks like?

And are you ok with the 2nd patch?


Daniel
