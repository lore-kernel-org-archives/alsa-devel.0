From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 0/3] alsa-lib: UCM - Use Case Manager
Date: Wed, 22 Sep 2010 16:20:28 +0100
Message-ID: <1285168828.3107.108.camel@odin>
References: <alpine.LNX.2.00.1008250925540.10278@eeebox2.perex-int.cz>
	<1282728400.2991.114.camel@odin>
	<alpine.LNX.2.00.1008251128140.10278@eeebox2.perex-int.cz>
	<1282732983.2991.161.camel@odin>
	<alpine.LNX.2.00.1008251831330.10278@eeebox2.perex-int.cz>
	<1283864698.3048.26.camel@odin>
	<alpine.LNX.2.00.1009071618230.10278@eeebox2.perex-int.cz>
	<i781vn$nhb$1@dough.gmane.org>
	<AANLkTin8fTA0CoUiPzASG4kepbSyWiDf7xrX-iJB8EQA@mail.gmail.com>
	<alpine.LNX.2.00.1009211938110.6226@eeebox2.perex-int.cz>
	<20100922132052.GC32476@sirena.org.uk>
	<alpine.LNX.2.00.1009221544480.6226@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 27D62103903
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Sep 2010 17:20:27 +0200 (CEST)
Received: by wyb32 with SMTP id 32so568387wyb.38
	for <alsa-devel@alsa-project.org>; Wed, 22 Sep 2010 08:20:26 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1009221544480.6226@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Chris Winter <elwintro@gmail.com>, ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-09-22 at 16:06 +0200, Jaroslav Kysela wrote:

> 
> I just finished the implementation for all functions in my GIT tree 
> (except card listing). Also, the "Value {}" section is implemented as I 
> proposed - it means that users can pass any read-only values to the API 
> user.
> 

Not had a good look yet, I assume all the functionality from the old API
is preserved ? 


> The code is not tested, I need to write a simple command line tool for 
> testing the API and also move the control/mixer ID and value handling 
> code from the alsa-utils/amixer utility to alsa-lib.
> 

Fwiw, there is some command line code for the old API that may be useful
here :-

git://git.slimlogic.co.uk/alsa-utils.git ucm-upstream

Liam
