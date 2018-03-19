From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH] ASoC: topology: Fix kcontrol name string
 handling.
Date: Mon, 19 Mar 2018 19:32:24 +0000
Message-ID: <1521487944.1923.71.camel@linux.intel.com>
References: <20180314204319.13919-1-liam.r.girdwood@linux.intel.com>
 <20180319070643.GD2186@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id B24F726720A
 for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2018 20:32:28 +0100 (CET)
In-Reply-To: <20180319070643.GD2186@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2018-03-19 at 15:06 +0800, Mark Brown wrote:
> On Wed, Mar 14, 2018 at 08:43:19PM +0000, Liam Girdwood wrote:
> > Fix the topology kcontrol string handling so that string pointer
> > references are strdup()ed instead of being copied. This fixes issues
> > with kcontrol templates on the stack or ones that are freed. Remember
> > and free the strings too when topology is unloaded.
> 
> This doesn't seem to apply against current code (I was going to apply it
> as a fix but it doesn't seem to apply against -next either).
> _______________________________________________
> 

Ok will do, Fwiw I did them against -next when you were at ELC, I guess there
have been some updates between now and then.

Thanks

Liam
