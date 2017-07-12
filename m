From: Natanael Copa <ncopa@alpinelinux.org>
Subject: Re: [PATCH v2 - alsa-lib] cleanup: Use uint*_t instead
 of u_int*_t everythwere
Date: Wed, 12 Jul 2017 15:59:17 +0200
Message-ID: <20170712155917.624ebce1@ncopa-desktop.copa.dup.pw>
References: <s5h60eykloy.wl-tiwai@suse.de>
 <20170712115048.28872-1-ncopa@alpinelinux.org>
 <s5hy3rtkes2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.tetrasec.net (mx1.tetrasec.net [74.117.190.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 16082266C21
 for <alsa-devel@alsa-project.org>; Wed, 12 Jul 2017 15:59:28 +0200 (CEST)
In-Reply-To: <s5hy3rtkes2.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 12 Jul 2017 14:42:21 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> On Wed, 12 Jul 2017 13:50:48 +0200,
> Natanael Copa wrote:
> > 
> > Use the standard uint{8,16,32,64}_t everywhere instead of the
> > non-standard u_int{8,16,32,64}_t.  
> 
> Note that, since it changes the types in the public header, it's no
> trivial "cleanup".  It has even a risk of breakage, in theory.

Yes.

> So, this has to be carried with a care, and it needs a better
> clarification why the change has to be applied.
> Could you give more background?

The intention was just to clean up code and to not add custom data
types when there are standard ones to use.

The standard uint{8,32,64}_t are also used various places in alsa-lib
code, so I thought it was better to be consistent to avoid
unintentional side-effects and breakages.

If you have a system where you rely on u_int8_t != uint8_t etc, then
you have system which is so weird that you probably know how to handle
it.

If you on the other hand unintentionally have u_int8_t != uint8_t then
you probably want things to break early and at minimum give a compiler
warning.

The thinking is, if things breaks due to this, then it probably
*should* break.

If there are any plans for ABI breakage in near future, then it might
be an idea to do this at that point.

Thanks!

-nc
