From: Daniel Mack <zonque@gmail.com>
Subject: Re: Clock generators in ASoC setups
Date: Thu, 02 Aug 2012 22:50:13 +0200
Message-ID: <501AE805.1060309@gmail.com>
References: <500FABD0.4040001@gmail.com>
 <20120725105258.GH3099@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 26BBA26522E
 for <alsa-devel@alsa-project.org>; Thu,  2 Aug 2012 22:50:14 +0200 (CEST)
Received: by bkcjk13 with SMTP id jk13so3667732bkc.38
 for <alsa-devel@alsa-project.org>; Thu, 02 Aug 2012 13:50:16 -0700 (PDT)
In-Reply-To: <20120725105258.GH3099@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 25.07.2012 12:52, Mark Brown wrote:
> On Wed, Jul 25, 2012 at 10:18:24AM +0200, Daniel Mack wrote:
> 
>> some board I'm working on feature chips (connected via I2C) that are in
>> charge of generating clocks for both the CPU DAI and the codecs.
>> Previously, I configured them manually in platform specific code, but I
>> wonder if there's a better, more generic way to get the job done,
>> especially with regards to DT driven boards?
> 
> The problem here is that we don't have a usable clock API to work with.
> 

Hmm, could you elaborate a bit about the background here? So the idea is
to have the clock framework that handles all system clocks also take
care for clocks related to audio?

What would such a framework need to accomplish, and what missing in -
for example - the common clock framework in that regard?

If there's a discussion thread about that topic, a pointer to that would
suffice.


Thanks,
Daniel
