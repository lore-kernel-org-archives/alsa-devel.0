From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] RFC: ASoC: Davinci: Fix data_type divide
	by zero
Date: Mon, 14 Sep 2009 15:04:16 -0700
Message-ID: <87ws41uqsf.fsf@deeprootsystems.com>
References: <1252547830-16585-1-git-send-email-troy.kisky@boundarydevices.com>
	<20090911103139.GA19204@sirena.org.uk>
	<4AAAC0B6.2010904@boundarydevices.com>
	<20090912121917.GA4633@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f198.google.com (mail-pz0-f198.google.com
	[209.85.222.198])
	by alsa0.perex.cz (Postfix) with ESMTP id E285C24400
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Sep 2009 00:04:20 +0200 (CEST)
Received: by pzk36 with SMTP id 36so3015124pzk.2
	for <alsa-devel@alsa-project.org>; Mon, 14 Sep 2009 15:04:19 -0700 (PDT)
In-Reply-To: <20090912121917.GA4633@sirena.org.uk> (Mark Brown's message of
	"Sat\, 12 Sep 2009 13\:19\:17 +0100")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> On Fri, Sep 11, 2009 at 02:27:18PM -0700, Troy Kisky wrote:
>> Mark Brown wrote:
>
>> >> +	 * dma_params must be first because rtd->dai->cpu_dai->private_data
>> >> +	 * is cast to an array of struct davinci_pcm_dma_params ** in
>> >> +	 * davinci_pcm_open.
>> >> +	 */
>
>> > Is it not possible to deal with this by going through the types
>> > properly?  The comment sets off all sorts of alarm bells.
>
>> private_data will be either struct davinci_mcbsp_dev or
>> struct davinci_audio_dev
>
> Hrm.  Might be nice to change that :/
>
>> Btw, I'm about to submit another rev of this against your for32
>> branch. But your branch currently give compile errors, so it
>> my compile test just doesn't generate new errors.
>
> You'll need to merge it with Kevin's branch to build - or wait for -rc1
> when everything should've made it into mainline.  Kevin's git has a
> branch temp/asoc with the merge done in it.

Also, I just pushed a new temp/asoc which is a simple merge of current
davinci git master and Mark's for-2.6.32 branch.

Kevin
