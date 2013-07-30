From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 08/10] ASoC: dapm: Add
 snd_soc_dapm_add_path() helper function
Date: Tue, 30 Jul 2013 13:35:02 +0200
Message-ID: <51F7A4E6.3030708@metafoo.de>
References: <1375110845-8069-1-git-send-email-lars@metafoo.de>
 <1375110845-8069-8-git-send-email-lars@metafoo.de>
 <20130729174517.GA9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-226.synserver.de (smtp-out-230.synserver.de
 [212.40.185.230])
 by alsa0.perex.cz (Postfix) with ESMTP id C7D052652A2
 for <alsa-devel@alsa-project.org>; Tue, 30 Jul 2013 13:34:01 +0200 (CEST)
In-Reply-To: <20130729174517.GA9858@sirena.org.uk>
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

On 07/29/2013 07:45 PM, Mark Brown wrote:
> On Mon, Jul 29, 2013 at 05:14:02PM +0200, Lars-Peter Clausen wrote:
>> snd_soc_dapm_add_path() is similar to snd_soc_dapm_add_route() except that it
>> expects the pointer to the source and sink widgets instead of their names. This
>> allows us to simplify the case where we already have a pointer to widgets. (E.g.
>> as we have in snd_soc_dapm_link_dai_widgets()). snd_soc_dapm_add_route() will be
>> updated to just look up the widget and then use snd_soc_dapm_add_path() to
>> handle everything else.
> 
> I've applied everything up to patch 9, this is all really good stuff.
> This one would've been a bit easier to review if the refactoring were
> split out from the changes to the users (who could've continued to use
> add_route() for the time being).
> 
> Patch 10 I want to have a bit more of a think about and probably try
> using it in something.

I do have a driver that uses the auto-disable feature. The plan is to submit
the driver soonish. I can resend patch 10 as part of the patch series that
adds the driver if necessary.

- Lars
