From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/2] ASoC: bf5xx-ac97: Remove unused extern
	declaration
Date: Tue, 30 Jul 2013 13:54:00 +0200
Message-ID: <51F7A958.9010106@metafoo.de>
References: <1375184050-21514-1-git-send-email-lars@metafoo.de>
 <1375184050-21514-2-git-send-email-lars@metafoo.de>
 <20130730115025.GR9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-230.synserver.de (smtp-out-231.synserver.de
 [212.40.185.231])
 by alsa0.perex.cz (Postfix) with ESMTP id 56BF626158D
 for <alsa-devel@alsa-project.org>; Tue, 30 Jul 2013 13:53:00 +0200 (CEST)
In-Reply-To: <20130730115025.GR9858@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 07/30/2013 01:50 PM, Mark Brown wrote:
> On Tue, Jul 30, 2013 at 01:34:10PM +0200, Lars-Peter Clausen wrote:
>> The blackfin ac97 driver never defines nor uses a global ac97 struct. So remove
>> the extern declaration for it.
> 
> This is a duplicate of my patch from yesterday...
> 

No, this is a different one. Your patch removed the extern declaration for
bf5xx_ac97_ops this one removes it for ac97, which was on the next line.

- Lars
