From: Andrey Utkin <andrey_utkin@fastmail.com>
Subject: Doc.../sound/soc/platform.rst: snd_soc_platform_driver out of sync
Date: Fri, 1 Dec 2017 02:51:48 +0000
Message-ID: <20171201025148.GA7404@starlite>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-doc-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jonathan Corbet <corbet@lwn.net>, alsa-devel@alsa-project.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi maintainers of Sound and/or Docs.

Documentation/sound/soc/platform.rst quotes outdated definition of
"struct snd_soc_platform_driver". I spotted this because it shows like
there are suspend/resume function pointers while this is no longer true.

I don't have a good idea how to update the doc, I am just sure that mere
update of the struct definition is not the way to go.

Hope this report helps.
Thanks for you work!
