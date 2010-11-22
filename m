From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [PATCH] jack: use eventfd which never blocks.
Date: Mon, 22 Nov 2010 18:09:09 +0500
Message-ID: <1290431349.2382.2.camel@patrakov-desktop>
References: <1290176549-31258-1-git-send-email-torbenh@gmx.de>
	<4CE8F14C.4040003@gmail.com>  <20101122121518.GM4646@siel.b>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D189103820
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 14:09:23 +0100 (CET)
Received: by wyg36 with SMTP id 36so7009709wyg.38
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 05:09:22 -0800 (PST)
In-Reply-To: <20101122121518.GM4646@siel.b>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: torbenh <torbenh@gmx.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

torbenh wrote:
> i think in the case of mmap, there are one byte written -> advance one
> period rules. these promises are not kept, when the write end is made
> non-blocking.

I was not aware of such rules. So, please disregard my review.

-- 
Alexander E. Patrakov
