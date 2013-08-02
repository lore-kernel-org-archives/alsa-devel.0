From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: dapm: Fix empty list check in
	dapm_new_mux()
Date: Fri, 02 Aug 2013 09:43:50 -0600
Message-ID: <51FBD3B6.4050403@wwwdotorg.org>
References: <1375374638-28305-1-git-send-email-lars@metafoo.de>
 <20130801184427.GX9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 555362617A6
 for <alsa-devel@alsa-project.org>; Fri,  2 Aug 2013 17:43:55 +0200 (CEST)
In-Reply-To: <20130801184427.GX9858@sirena.org.uk>
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
Cc: Olof Johansson <olof@lixom.net>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 08/01/2013 12:44 PM, Mark Brown wrote:
> On Thu, Aug 01, 2013 at 06:30:38PM +0200, Lars-Peter Clausen
> wrote:
>> list_first_entry() will always return a valid pointer, even if
>> the list is empty. So the check whether path is NULL will always
>> be false. So we end up calling
>> dapm_create_or_share_mixmux_kcontrol() with a path struct that
>> points right in the middle of the widget struct and by trying to
>> modify the path the widgets memory will become corrupted. Fix
>> this by using list_emtpy() to check if the widget doesn't have
>> any paths.
> 
> Applied, thanks - looking at this I'm surprised we've not been
> running into problems before.

I don't see this in the ASoC git tree, in either for-next, fix/dapm,
or topic/dapm.
