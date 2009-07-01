From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] alsa/soc: add locking to mpc5200-psc-ac97
	driver
Date: Wed, 1 Jul 2009 08:44:58 -0600
Message-ID: <fa686aa40907010744i21beefb2pa088a63fc5bae3d1@mail.gmail.com>
References: <20090629234214.12670.9082.stgit@localhost.localdomain>
	<20090630061847.GA24164@pengutronix.de>
	<9e4733910906300642o4f1c0e2cn45423c426e3aff7e@mail.gmail.com>
	<20090701085633.GB3144@pengutronix.de>
	<9e4733910907010632g10706084o66720d4616e40865@mail.gmail.com>
	<20090701135547.GD3144@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f176.google.com (mail-pz0-f176.google.com
	[209.85.222.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 5337924488
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Jul 2009 16:45:20 +0200 (CEST)
Received: by pzk6 with SMTP id 6so2896pzk.16
	for <alsa-devel@alsa-project.org>; Wed, 01 Jul 2009 07:45:18 -0700 (PDT)
In-Reply-To: <20090701135547.GD3144@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 1, 2009 at 7:55 AM, Wolfram Sang<w.sang@pengutronix.de> wrote:
>
>> > Sorry, I didn't get it: Shall I test something specific?
>>
>> I don't own a touchscreen.
>>
>> AFAIK no one has ever plugged a touchscreen into the PCM-973 to see if
>> works since there hasn't been a driver previously.
>> Just do a general
>> test so that you can tell customers that it works.
>
> I am not sure, we have a suitable touchscreen. Also, I am afraid this is a bit
> too much to do besides my regular day work right now. Sorry.

I've now tested this on a client's board which uses the pcm030 with a
custom base board (based on the development board) which uses the same
codec.  It works there.  I don't have a discrete touchscreen to wire
up to the PCM-973 though.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
