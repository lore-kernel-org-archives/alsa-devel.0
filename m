From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: sam9x5_wm8731: Remove redundant
 of_match_ptr helper
Date: Sat, 21 Dec 2013 14:14:28 +0000
Message-ID: <20131221141428.GB30815@sirena.org.uk>
References: <1387613985-23420-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 13F6B262632
 for <alsa-devel@alsa-project.org>; Sat, 21 Dec 2013 15:14:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1387613985-23420-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: alsa-devel@alsa-project.org, nicolas.ferre@atmel.com
List-Id: alsa-devel@alsa-project.org

On Sat, Dec 21, 2013 at 01:49:45PM +0530, Sachin Kamat wrote:
> 'sam9x5_wm8731_of_match' is always compiled in. Hence the
> helper macro is not needed.

Same here - the idea is to avoid needing to explicitly compile it out.
