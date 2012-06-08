From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: [Bisected] ALSA: snd-usb: New streaming logic causes distortions
 on Burr-Brown DAC
Date: Fri, 8 Jun 2012 20:11:54 +0200
Message-ID: <20120608181154.GA267@x4>
References: <20120608164004.GA580@x4>
 <20120608175043.GA5109@cucamonga.audible.transient.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120608175043.GA5109@cucamonga.audible.transient.net>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, zonque@gmail.com, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

On 2012.06.08 at 17:50 +0000, Jamie Heilman wrote:
> Markus Trippelsdorf wrote:
> > I hear distortions on my Burr-Brown USB DAC whenever the (software)
> > volume is set to some value lower than 100% in mpd. The lower the volume
> > the bigger are the resulting distortions.
> 
> see patch: http://marc.info/?l=linux-kernel&m=133905533312625&w=2
> 
> You're probably getting distortion because mpd decided it would use
> a stream format that's only 8bit.

Yes. The patch fixes the issue. Many thanks.

-- 
Markus
