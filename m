From: pl bossart <bossart.nospam@gmail.com>
Subject: multiple devices or one device w/ multiple subdevices?
Date: Mon, 24 Aug 2009 12:26:01 -0500
Message-ID: <6160a5130908241026g574282cuc878346df2ff31ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 81EDB243AD
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Aug 2009 19:26:02 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c37so911517anc.2
	for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2009 10:26:01 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
I have a piece of custom hardware that provides 7 independent PCM
outputs. This is not intended for multichannel playback, the content
on each output can be completely different; playback will not be
synchronized and will start separately. The only restriction is that
all outputs rely on the same baserate and share the same bitclock,
i.e. all the outputs work at 48kHz.

>From the mailling list archives, subdevices seem to be relevant when
doing hw mixing or when lots of streams are handled. None of this
applies to my case. Also it looks like PulseAudio knows nothing about
subdevices in its detection loop, meaning the user would need to
manually add some load-module commands in the PulseAudio configuration
files. And last but not least, I didn't see very many lines of code
(and no documentation) that showed how subdevices are
registered/handled, etc.

My conclusion is that multiple devices would seem like a much better
option. But I wanted to check with the community that I am on the
right track. Thanks for your feedback!
- P
