From: Tanu Kaskinen <tanuk@iki.fi>
Subject: Re: How to package the smixer modules?
Date: Wed, 09 Nov 2016 16:39:26 +0200
Message-ID: <1478702366.1952.1.camel@iki.fi>
References: <1478522629.1939.3.camel@iki.fi> <s5hlgwu9gtx.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 313C7266802
 for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2016 15:39:30 +0100 (CET)
In-Reply-To: <s5hlgwu9gtx.wl-tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2016-11-08 at 15:39 +0100, Takashi Iwai wrote:
> The simple mixer is another layer in ALSA mixer API, and actually it's
> mandatory.  So, at least, sbase plugin should be provided always when
> alsa-lib mixer API is used.  Other plugins are basically never used
> practically.
> 
> It doesn't matter whether to package them separately or not.  The only
> point is that sbase plugin should be available when alsa-lib mixer API
> is used.

Thanks for the explanation! If the sbase plugin is essentially a
mandatory accompaniment of libasound, I'll move it to the libasound
package, and since I don't see much benefit in keeping the hda and ac97
plugins in a separate package either, I'll move those too and get rid
of the whole smixer plugin package.

Out of curiosity, in what situation are the hda and ac97 plugins used?
You said that they are practically never used, but surely they have
some purpose?

-- 
Tanu

https://www.patreon.com/tanuk
