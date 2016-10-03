From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/5] ASoC: tas571x: fix missing bias save
 level
Date: Mon, 3 Oct 2016 19:09:48 +0200
Message-ID: <505a8248-dcc6-ee31-b381-72c661d1b373@metafoo.de>
References: <1475505650-8572-1-git-send-email-brain@jikos.cz>
 <1475505650-8572-2-git-send-email-brain@jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F46C266C4B
 for <alsa-devel@alsa-project.org>; Mon,  3 Oct 2016 19:09:55 +0200 (CEST)
In-Reply-To: <1475505650-8572-2-git-send-email-brain@jikos.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <brain@jikos.cz>, broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/03/2016 04:40 PM, Petr Kulhavy wrote:
> The tas571x_set_bias_level() was not saving the new bias level to
> codec->dapm.bias_level. This had the effect that bias was switching between
> standby and off levels and never entered the on level.
> 
> This fix saves the bias level before returning from the function.
> 

This is done by the ASoC core after the function completes, so this should
not be necessary.
