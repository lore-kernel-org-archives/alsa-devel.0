From: Pete Clements <clem@clem.clem-digital.net>
Subject: Re: 2.6.22-rc1 lost snd_4236 device
Date: Tue, 15 May 2007 09:48:47 -0400 (EDT)
Message-ID: <200705151348.l4FDmlD7001813@clem.clem-digital.net>
References: <s5hy7jqgymj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760801AbXEONtS@vger.kernel.org>
In-Reply-To: <s5hy7jqgymj.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Rene Herman <rene.herman@gmail.com>, Pete Clements <clem@clem.clem-digital.net>, linux-kernel <linux-kernel@vger.kernel.org>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Quoting Takashi Iwai
  > At Tue, 15 May 2007 07:42:41 +0200,
  > Rene Herman wrote:
  > > 
  > > [1  <text/plain; ISO-8859-15 (7bit)>]
  > > On 05/13/2007 06:23 PM, Pete Clements wrote:
  > > 
  > > > Fyi:
  > > > With 2.6.22-rc1 get following when loading sound device module. Introduced
  > > > with 2.6.21-git16.
  > > > 
  > > > FATAL: Error inserting snd_cs4236 (/lib/modules/2.6.22-rc1/kernel/sound/isa/cs423x/snd-cs4236.ko): No such device
  > > > FATAL: Error running install command for snd_cs4236
  > > 
  > > Yup; the conversion of the mixed legacy/pnp ALSA drivers to the isa_bus 
  > > framework is not quite right. Wants the attached.
  > 
  > Grr, forgot about the error return at probe.
  > 
  > > Takashi, this needs to go to Linus. Can you make sure it gets there? This is 
  > > against -linus HEAD.
  > > 
  > > Signed-off-by: Rene Herman <rene.herman@gmail.com>
  > 
  > Thanks.  I applied it to ALSA tree so that it will be queued in the
  > next push round.
  > 
  > 
  > Takashi
  > -

Applied patch. Module loads.

-- 
Pete Clements 
