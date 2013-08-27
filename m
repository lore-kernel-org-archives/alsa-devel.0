From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 3/8] ASoC: tlv320aic32x4: Convert table
 based control and DAPM setup
Date: Tue, 27 Aug 2013 16:41:21 +0200
Message-ID: <521CBA91.4020102@metafoo.de>
References: <1377611461-3638-1-git-send-email-lars@metafoo.de>
 <1377611461-3638-3-git-send-email-lars@metafoo.de>
 <20130827143558.GO10783@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-185.synserver.de (smtp-out-186.synserver.de
 [212.40.185.186])
 by alsa0.perex.cz (Postfix) with ESMTP id 631932652EC
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 16:39:51 +0200 (CEST)
In-Reply-To: <20130827143558.GO10783@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Javier Martin <javier.martin@vista-silicon.com>
List-Id: alsa-devel@alsa-project.org

On 08/27/2013 04:35 PM, Mark Brown wrote:
> On Tue, Aug 27, 2013 at 03:50:56PM +0200, Lars-Peter Clausen wrote:
>> Let the core take care of instantiating the controls and DAPM widgets and
>> routes, this makes the code a bit shorter.
> 
> Applied, thanks.
> 
> Please don't submit a bunch of unrelated patches as a series, submit
> them separately.

The last patch in the series depends on all the other patches in this series
(maybe except for the mark dirty fix).

- Lars
