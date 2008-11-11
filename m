From: chri <chripell@gmail.com>
Subject: Re: [PATCH] ALSA SOC driver for s3c24xx with uda1341
Date: Tue, 11 Nov 2008 15:15:11 +0100
Message-ID: <cabda6420811110615tdb3b294yd4de2ad5239af654@mail.gmail.com>
References: <12261302352402-git-send-email-chripell@gmail.com>
	<20081110133451.GD12804@sirena.org.uk>
	<20081110185800.42b6c198.kristoffer.ericson@gmail.com>
	<cabda6420811101108od6fe848qc291135a2ba9d819@mail.gmail.com>
	<20081110212233.3d3bcc7c.kristoffer.ericson@gmail.com>
	<20081110221044.GI22835@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.191])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D7FB2414D
	for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2008 15:15:12 +0100 (CET)
Received: by nf-out-0910.google.com with SMTP id e27so1825661nfd.32
	for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2008 06:15:11 -0800 (PST)
In-Reply-To: <20081110221044.GI22835@trinity.fluff.org>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: alsa-devel@alsa-project.org, Kristoffer Ericson <kristoffer.ericson@gmail.com>, Mark Brown <broonie@sirena.org.uk>, zdevai@gmail.com, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 10, 2008 at 11:10 PM, Ben Dooks <ben-linux@fluff.org> wrote:

>>
>> It would be good if the driver could be used for both 1341/1344.
>> Some minor ifdef's should sort it out.
>> Please drop me a mail with the patches (missed the old one) and I'll start
>> testing them them out.
>
> eww, ifdefs...
>

I'll try to put the common code in a uda_common.c and the do 2 small drivers.

-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
