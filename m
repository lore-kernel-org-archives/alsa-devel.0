From: Daniel Mack <zonque@gmail.com>
Subject: Re: Connecting two Codecs to the same CPU DAI
Date: Tue, 16 Jul 2013 19:07:33 +0200
Message-ID: <51E57DD5.5040307@gmail.com>
References: <51E55925.5080208@gmail.com>
 <20130716162043.GS22506@sirena.org.uk> <51E575E3.3040409@gmail.com>
 <20130716165708.GT22506@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f45.google.com (mail-ee0-f45.google.com [74.125.83.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FECB265094
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 19:07:06 +0200 (CEST)
Received: by mail-ee0-f45.google.com with SMTP id c1so515263eek.4
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 10:07:05 -0700 (PDT)
In-Reply-To: <20130716165708.GT22506@sirena.org.uk>
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
Cc: ALSA development <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 16.07.2013 18:57, Mark Brown wrote:
> On Tue, Jul 16, 2013 at 06:33:39PM +0200, Daniel Mack wrote:
>> On 16.07.2013 18:20, Mark Brown wrote:
> 
>>> No, no feature here.  Off the top of my head I'd suggest soc-pcm plus a
>>> virtual DAI for the second link.
> 
>> That would still require userspace to open and configure both
>> subdevices, right?
> 
> Shouldn't.

How so? As each link exposes its own PCM subdevice, how would codec of
link #1 get a hw_params call if an application just opens PCM subdevice
#0 for playback? This is the case I want to address.

>> Do you think it's a good idea to teach DAI links support for more than
>> one codec? At a glance, it seems quite possible: the modes and rates
>> would be limited down to the intersection of those of each codec, and
>> the PCM callbacks would be relayed to all codecs in the list.
> 
> In principal yet but we want better DAPM integration I think - having an
> unused device on the link probably ought not have any impact on other
> devices for example.

Well, if a link references two codecs, then both would be used in
parallel, and none of it is unused. But maybe I don't get your point :)

By naive approach atm would be to just add .codec_names,
.codec_dai_names and .codec_of_node to snd_soc_dai_link, and make their
use mutually exclusive to the existing ones. That way, we don't need to
touch any existing user.


Daniel
