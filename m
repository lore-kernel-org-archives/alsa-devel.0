From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: ASoC: Failed to create component debugfs directory
Date: Tue, 20 Feb 2018 20:30:17 +0100
Message-ID: <99ce1244-6646-6292-2c50-151819b01cfa@metafoo.de>
References: <CAOMZO5D071pPr4fL7eLwWgX6h8Mppwic2u4mUCGzUZiss-+3MQ@mail.gmail.com>
 <CAOMZO5C3joR2QS+yFDmQUs1Q69PfuVw8tBMNd+F+cjDnUMEPSQ@mail.gmail.com>
 <5b591fd8-d4d5-27bb-0850-a376da20d7f3@metafoo.de>
 <CAOMZO5Ai-EtFo--OYLKhsB+63u6D+Vyjx_hKVeG3EGXbHkY5jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id C1FC2267502
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 20:30:33 +0100 (CET)
In-Reply-To: <CAOMZO5Ai-EtFo--OYLKhsB+63u6D+Vyjx_hKVeG3EGXbHkY5jw@mail.gmail.com>
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
To: Fabio Estevam <festevam@gmail.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

On 02/20/2018 08:26 PM, Fabio Estevam wrote:
> On Tue, Feb 20, 2018 at 11:24 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> 
>>> Any ideas why this second debugfs registration is being attempted?
>>
>> One for the DMA, one for the I2S?
> 
> but this second debugfs registration only happens in linux-next.
> 
> On master it tries to only register once and it succeeds.
> 
> On linux-next it succeeds the first time and it fails the second time
> as it tries to register the same debugfs entry.
> 

Because on linux-next they are all components now, before one was a
platform, the other a component. So they were created in different
sub-directories. Now they are created in the same sub-directory.
