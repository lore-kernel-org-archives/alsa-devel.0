From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Should codec suspend when no paths are marked to
 be active across a suspend action?
Date: Fri, 7 Sep 2012 07:56:07 +0800
Message-ID: <20120906235606.GC4400@opensource.wolfsonmicro.com>
References: <CAFM_0b8xAuth0DGzNTMRpBy1VZ5vUJKPNEo2gRO+5Z7G+2CAUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1C1D02615F2
 for <alsa-devel@alsa-project.org>; Fri,  7 Sep 2012 01:56:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAFM_0b8xAuth0DGzNTMRpBy1VZ5vUJKPNEo2gRO+5Z7G+2CAUQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Taylor Hutt <thutt@google.com>
Cc: alsa-devel@alsa-project.org, Dylan Reid <dgreid@google.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 06, 2012 at 12:55:00PM -0700, Taylor Hutt wrote:

> Shouldn't the codec be suspended if there are no paths set to remain
> active across the suspend?

Yes.  If you're using an analogue bypass path there's a very recent
commit in -next from me which should help, previously we weren't ever
really suspending bypass paths at all (even before the changes to keep
some paths active) though we might end up doing so by accident.  Nobody
noticed since essentially nobody uses analogue bypass any more.
