From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: Baytrail init file for alsa-utils
Date: Mon, 03 Nov 2014 11:11:13 +0000
Message-ID: <1415013073.2471.11.camel@loki>
References: <1415008294.2406.107.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id B778D260441
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 12:11:16 +0100 (CET)
In-Reply-To: <1415008294.2406.107.camel@hadess.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bastien Nocera <hadess@hadess.net>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Nikula,
 Jarkko" <jarkko.nikula@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2014-11-03 at 10:51 +0100, Bastien Nocera wrote:
> Hey,
> 
> I've done some work on the community generated "alsa state" file for
> Baytrail tablets, and shrunk it massively:
> https://github.com/AdamWill/baytrail-m/blob/master/alsa/t100_B.state
> 
> Are there any tools, or hints as to how I might convert that to an
> "init" file that alsactl could run to set the default state of the
> mixer?

"alsactl store" should write it to the correct system directory.

> 
> Or have any Intel folks already done that work?
> 

Jarkko has been working on Baytrail so best for him to answer.

> I'll have a few more sound-related questions for that tablet, for which
> I could do with a few hints as to where to direct the questions/bug
> reports:
> - no jack sensing support (driver problem?)
> - left/right headphones output is inverted (another driver bug?)
> - HDMI audio is not detected (Intel video driver bug?)
> 

Liam
