From: hong zhang <henryzhang62@yahoo.com>
Subject: Re: asoc: no valid backend routes for PCM: SDP4430
	Media
Date: Thu, 9 Jun 2011 10:52:07 -0700 (PDT)
Message-ID: <507506.95203.qm@web161717.mail.bf1.yahoo.com>
References: <4DF1076B.70308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm18-vm0.bullet.mail.bf1.yahoo.com
	(nm18-vm0.bullet.mail.bf1.yahoo.com [98.139.213.138])
	by alsa0.perex.cz (Postfix) with SMTP id AE508103BE1
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Jun 2011 19:52:09 +0200 (CEST)
In-Reply-To: <4DF1076B.70308@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



--- On Thu, 6/9/11, Liam Girdwood <lrg@ti.com> wrote:

> From: Liam Girdwood <lrg@ti.com>
> Subject: Re: [alsa-devel] asoc: no valid backend routes for PCM: SDP4430 Media
> To: "hong zhang" <henryzhang62@yahoo.com>
> Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
> Date: Thursday, June 9, 2011, 12:48 PM
> On 09/06/11 18:45, hong zhang wrote:
> > Liam,
> > 
> > Arecord gets data from DMIC! Using following
> commands.
> > 
> > "arecord -f dat -D plughw:0,0 dmic.wav" with "amixer
> cset numid=61 1 and
> > amixer cset numid=60 2" to get data from DMIC after
> turning off two analog captures.
> > 
> > Information from "arecrod -l" is not sync with ABE
> routing table. For example, "arecord -l" indicates hw:0,10
> is DMIC capture but 
> > ABE diagram indicates plughw:0,0 can be used for DMIC
> input.
> > 
> > Are "arecord -l" and "aplay -l" still useful?
> 
> Yes, but not for OMAP4 atm.

1. What is OMAP4 ATM?
2. Why "hw:0,10 DMIC capture" does not work for DMIC input?
 
> Thanks
> 
> Liam
> 
