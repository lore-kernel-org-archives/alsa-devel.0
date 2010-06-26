From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [RFC 02/16] ASoC: multi-component - cs4720,
 cs42l51 	and da7210 CODECs
Date: Sat, 26 Jun 2010 18:36:15 +0100
Message-ID: <1277573775.3110.18.camel@odin>
References: <1277488383-31287-1-git-send-email-lrg@slimlogic.co.uk>
	<1277488383-31287-3-git-send-email-lrg@slimlogic.co.uk>
	<AANLkTinmu4myhe1dGuG_fEdQUpYKQ4bbN1xDCSWzmNWC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id B380D2438A
	for <alsa-devel@alsa-project.org>;
	Sat, 26 Jun 2010 19:36:22 +0200 (CEST)
Received: by wyf23 with SMTP id 23so658729wyf.38
	for <alsa-devel@alsa-project.org>; Sat, 26 Jun 2010 10:36:22 -0700 (PDT)
In-Reply-To: <AANLkTinmu4myhe1dGuG_fEdQUpYKQ4bbN1xDCSWzmNWC@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-06-25 at 13:29 -0500, Timur Tabi wrote:
> On Fri, Jun 25, 2010 at 12:52 PM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> 
> >  /* Private data for the CS4270 */
> >  struct cs4270_private {
> > -       struct snd_soc_codec codec;
> > +       enum snd_soc_control_type control_type;
> > +       void *control_data;
> 
> Because of this change, there is a comment later in the file that is
> no longer valid:
> 
> 	/* Allocate enough space for the snd_soc_codec structure
> 	   and our private data together. */
> 	cs4270 = kzalloc(sizeof(struct cs4270_private), GFP_KERNEL);
> 	if (!cs4270) {
> 		dev_err(&i2c_client->dev, "could not allocate codec\n");
> 		return -ENOMEM;
> 	}
> 
> Other than that ...
> 
> CS4270 portions:
> Acked-by: Timur Tabi <timur@freescale.com>
> 


Thanks, fixed.

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
