From: Jamie Heilman <jamie@audible.transient.net>
Subject: Re: [Bisected] ALSA: snd-usb: New streaming logic causes distortions
 on Burr-Brown DAC
Date: Fri, 8 Jun 2012 17:50:43 +0000
Message-ID: <20120608175043.GA5109@cucamonga.audible.transient.net>
References: <20120608164004.GA580@x4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120608164004.GA580@x4>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, zonque@gmail.com, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Markus Trippelsdorf wrote:
> I hear distortions on my Burr-Brown USB DAC whenever the (software)
> volume is set to some value lower than 100% in mpd. The lower the volume
> the bigger are the resulting distortions.

see patch: http://marc.info/?l=linux-kernel&m=133905533312625&w=2

You're probably getting distortion because mpd decided it would use
a stream format that's only 8bit.


-- 
Jamie Heilman                     http://audible.transient.net/~jamie/
