From: "Jarkko Nikula" <jhnikula@gmail.com>
Subject: Re: [PATCH] tlv320aic3x: control additions and cleanups
Date: Thu, 4 Dec 2008 20:32:56 +0200
Message-ID: <bd7b27490812041032l254ac347l2f85186dda7a87b4@mail.gmail.com>
References: <20081204175121.GD21010@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 649131037F6
	for <alsa-devel@alsa-project.org>; Thu,  4 Dec 2008 19:32:58 +0100 (CET)
Received: by rn-out-0910.google.com with SMTP id j67so4644756rne.21
	for <alsa-devel@alsa-project.org>; Thu, 04 Dec 2008 10:32:57 -0800 (PST)
In-Reply-To: <20081204175121.GD21010@buzzloop.caiaq.de>
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
To: Daniel Mack <daniel@caiaq.org>
Cc: alsa-devel@alsa-project.org, u.luckas@road.de
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 4, 2008 at 7:51 PM, Daniel Mack <daniel@caiaq.org> wrote:

> Some minor updates for sound/soc/codecs/tlv320aic3x.c:
>
> - removed "DAC" from name for "Mono playback switch", "HP playback
>  switch" and "HPCOM playback switch". The registers used in the macro
>  don't have anything to do with the DAC but mute the whole output,
>  hence the names were misleading.


 Hi Daniel!

This is true, I found it also sometime ago that muting those DAC playback
switches muted the whole output even there were bypass paths active but
didn't find time to look it any deeper yet.

I think by quick look, that your fix changing "x DAC Playback Switch" to "x
Playback Switch" separating it thus from "x DAC Playback Volume" is likely
correct one.

I'll try to look this tomorrow or monday and give you a note. Generally I
would say, this should go as a separate fix patch and changes below into
another.


> - split "Line Playback Switch" into "LineL Playback Switch" and "LineR
>  Playback Switch"
> - split "Line PGA Bypass Playback Volume" into "LineL Left PGA Bypass
>  Playback Volume" and "LineR Right PGA Bypass Playback Volume"
> - split "Line Line2 Bypass Playback Volume" into "LineL Line2 Bypass
>  Playback Volume" and "LineR Line2 Bypass Playback Volume"
> - Added "HP Right PGA Bypass Playback Volume"
>


Jarkko
