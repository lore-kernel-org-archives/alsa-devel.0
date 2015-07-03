From: Antonio Ospite <ao2@ao2.it>
Subject: Re: Intel Baytrail Linux Audio
Date: Fri, 3 Jul 2015 14:36:08 +0200
Message-ID: <20150703143608.7afb34c985d82982e929484e@ao2.it>
References: <8D3F6266AEB6384E807C6FFC6FE195E30B49AE39@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp205.alice.it (smtp205.alice.it [82.57.200.101])
 by alsa0.perex.cz (Postfix) with ESMTP id D62F1264F09
 for <alsa-devel@alsa-project.org>; Fri,  3 Jul 2015 14:36:19 +0200 (CEST)
In-Reply-To: <8D3F6266AEB6384E807C6FFC6FE195E30B49AE39@BGSMSX101.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Nikula,
 Jarkko" <jarkko.nikula@intel.com>, Nicolas George <george@nsup.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, Tyler Yeomans <tyeo098@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 3 Jul 2015 12:10:42 +0000
"Koul, Vinod" <vinod.koul@intel.com> wrote:

> 
> On 3 Jul 2015 4:43 pm, Nicolas George <george@nsup.org> wrote:
> >
[...]
> > [   95.164749]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
> 
> This is dpcm enabled driver
> 
> So please route the FE to BE and it should work...
> 

Nicolas, this can be done by using the commands from here:
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-June/094080.html

In particular:
amixer -c0 sset 'codec_out0 mix 0 pcm0_in' on
amixer -c0 sset 'media0_out mix 0 media1_in' on

Ciao,
   Antonio

P.S. Vinod, please check your email client, it looks like sometimes
there is no In-Reply-To header in messages from you and the threading
of messages gets broken.

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
