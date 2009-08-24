From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: multiple devices or one device w/ multiple
 subdevices?
Date: Mon, 24 Aug 2009 21:07:44 +0100
Message-ID: <1251144464.5773.214.camel@odin>
References: <6160a5130908241026g574282cuc878346df2ff31ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f220.google.com (mail-ew0-f220.google.com
	[209.85.219.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E8FA244BA
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Aug 2009 22:07:49 +0200 (CEST)
Received: by ewy20 with SMTP id 20so3056867ewy.46
	for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2009 13:07:48 -0700 (PDT)
In-Reply-To: <6160a5130908241026g574282cuc878346df2ff31ef@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Pierre-Louis,

On Mon, 2009-08-24 at 12:26 -0500, pl bossart wrote:
> Hi,
> I have a piece of custom hardware that provides 7 independent PCM
> outputs. This is not intended for multichannel playback, the content
> on each output can be completely different; playback will not be
> synchronized and will start separately. The only restriction is that
> all outputs rely on the same baserate and share the same bitclock,
> i.e. all the outputs work at 48kHz.
> 
> >From the mailling list archives, subdevices seem to be relevant when
> doing hw mixing or when lots of streams are handled. None of this
> applies to my case. Also it looks like PulseAudio knows nothing about
> subdevices in its detection loop, meaning the user would need to
> manually add some load-module commands in the PulseAudio configuration
> files. And last but not least, I didn't see very many lines of code
> (and no documentation) that showed how subdevices are
> registered/handled, etc.
> 
> My conclusion is that multiple devices would seem like a much better
> option. But I wanted to check with the community that I am on the
> right track. Thanks for your feedback!
> - P

Fwiw, I worked on a similar piece of hardware a few years back (WM9713).
It too had a shared 48kHz clock (AC97) and 3 independent outputs. I
found creating a single card with 3 pcms worked very well in this case
and kept the code simple. 

I could independently play different audio data to each pcm with
different start/stop times.

There is some example code in the ASoC WM9713 codec driver and in
soc-core.c

HTH 

Liam 
