From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Bug in 3.10 alsa routing?
Date: Mon, 15 Aug 2016 11:51:39 +0200
Message-ID: <8b60301c-eb4c-a172-8069-d4760089aac6@metafoo.de>
References: <CAES_P+9SAvzrquMHm1kVsK7Dm__R_2LRmAohV7LmQcJCZyZgog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 697F2265D81
 for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2016 11:51:42 +0200 (CEST)
In-Reply-To: <CAES_P+9SAvzrquMHm1kVsK7Dm__R_2LRmAohV7LmQcJCZyZgog@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: noman pouigt <variksla@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 08/13/2016 08:39 PM, noman pouigt wrote:
> Hello folks,
> 
> I am working on enabling a new alsa codec driver and
> I am stuck with this below routing problem.
> 
> SND_SOC_DAPM_AIF_OUT("AIF1TX1",)
> 
>         { "AIF3RX1", NULL, "AIF3 Playback" },
>         { "AIF1TX1 Input 1", NULL, "AIF3RX1" },
>         { "AIF1TX1", AIF1TX1, "AIF1TX1 Input 1" },
>         { "AIF1TX1", AIF1TX2, "AIF1TX1 Input 1" },
>         { "AIF1 Capture", NULL, "AIF1TX1" },
> 
> AIF3 Playback and AIF1 Capture is stream name of AIF3
> and AIF1 dai respectively.
> 
> After setting the paths using mixer command and triggering
> AIF3 playback dai, I see that it is not powering AIF3 Playback widget.
> 
> After debugging I found the problem to be that ALSA core searches
> for physically connected or active widget path before it
> can power on the widget. So I think the codec developer wanted
> me start the AIF1 capturing to turn on the whole path. However in our
> system we just want to connect AIF3RX1 to AIF1TX1.

Hi,

DAPM will power up a path if there is a connection between an active sink
and a active source. The playback widget is a source, the capture widget is
a sink. So if both of them are active you should see them power up. If only
one of them is active the system will stay powered down.

Maybe this presentation is also helpful:
http://events.linuxfoundation.org/sites/events/files/slides/dapm.pdf

- Lars
