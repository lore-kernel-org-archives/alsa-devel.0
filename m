From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 01/10] ASoC: blackfin: Remove unused
 bf5xx-{i2s, tdm, ac97}-pcm.h
Date: Thu, 30 May 2013 09:47:14 +0200
Message-ID: <51A70402.2070901@metafoo.de>
References: <1369761738-29503-1-git-send-email-lars@metafoo.de>
 <20130529192726.GA5180@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-231.synserver.de (smtp-out-231.synserver.de
 [212.40.185.231])
 by alsa0.perex.cz (Postfix) with ESMTP id 751322650BE
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2013 09:47:23 +0200 (CEST)
In-Reply-To: <20130529192726.GA5180@sirena.org.uk>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, Scott Jiang <scott.jiang.linux@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Steven Miao <realmz6@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 05/29/2013 09:27 PM, Mark Brown wrote:
> On Tue, May 28, 2013 at 07:22:09PM +0200, Lars-Peter Clausen wrote:
>> The structs defined in these files are completely unused, so remove both the
>> structs and the files.
> 
> This series doesn't appear to apply cleanly to my topic/blackfin or the
> merge of that and v3.10-rc3 - can you please check what's going on
> there?

Hm, where exactly are you getting conflicts? If I download the patches as
they are in the ml-archive and run git am on them on top of topic/blackfin
everything applies cleanly.

Thanks,
- Lars
