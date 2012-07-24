From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 1/2] ALSA: ASoC: add DT bindings for cs4270
Date: Tue, 24 Jul 2012 22:26:53 +0200
Message-ID: <500F050D.6080505@gmail.com>
References: <1343161248-27557-1-git-send-email-zonque@gmail.com>
 <500F0407.8090807@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 by alsa0.perex.cz (Postfix) with ESMTP id B34AB265D3E
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2012 22:26:54 +0200 (CEST)
Received: by weyx10 with SMTP id x10so4970018wey.38
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2012 13:26:56 -0700 (PDT)
In-Reply-To: <500F0407.8090807@freescale.com>
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

On 24.07.2012 22:22, Timur Tabi wrote:
> Daniel Mack wrote:
> 
>> +/*
>> + * cs4270_of_match - the device tree bindings
>> + */
>> +static const struct of_device_id cs4270_of_match[] = {
>> +	{ .compatible = "cirrus,cs4270", },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, cs4270_of_match);
>> +
> 
> Why is this necessary?  The CS4270 driver works just fine on our
> device-tree enabled boards.
> 

How do you instanciate it then? Somehow the DT core must know which
device to probe for a node, right?



Daniel
