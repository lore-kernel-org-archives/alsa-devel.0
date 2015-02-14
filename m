From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: Add
	snd_soc_of_parse_audio_routing()
Date: Fri, 13 Feb 2015 21:49:44 -0800
Message-ID: <20150214054944.GB3305@Alpha>
References: <1423776602-28585-1-git-send-email-nicoleotsuka@gmail.com>
 <20150214043153.GC9110@finisterre.sirena.org.uk>
 <20150214050245.GA3305@Alpha>
 <20150214053212.GK9110@finisterre.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 by alsa0.perex.cz (Postfix) with ESMTP id E77EE2604C3
 for <alsa-devel@alsa-project.org>; Sat, 14 Feb 2015 06:49:49 +0100 (CET)
Received: by mail-pa0-f52.google.com with SMTP id ey11so23275381pad.11
 for <alsa-devel@alsa-project.org>; Fri, 13 Feb 2015 21:49:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20150214053212.GK9110@finisterre.sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, Feb 14, 2015 at 02:32:12PM +0900, Mark Brown wrote:
> On Fri, Feb 13, 2015 at 09:02:46PM -0800, Nicolin Chen wrote:
> > On Sat, Feb 14, 2015 at 01:31:53PM +0900, Mark Brown wrote:
> 
> > > How about having it just record that it should parse the given property
> > > when the table in the card is being handleed rather than overwrite that?
> 
> > You mean adding another pair of dapm_routes with num_dapm_routes for
> > Device Tree or something like that?
> 
> That should work, I had been thinking of just recording where to parse
> from and deferring the parse entirely.

Okay. I'll try both approaches and choose a comparatively neater one.

Thanks
Nicolin
