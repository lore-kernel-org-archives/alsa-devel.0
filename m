From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: XRUN handling
Date: Tue, 6 Jul 2010 20:37:53 +0100
Message-ID: <AANLkTimFJEyTUS7kiinrn8e2NarRqtFj_DEPq0w6zENY@mail.gmail.com>
References: <AANLkTim_2xOjhFHcfyMvgceAQZEauWYIbY8QV-0jnBWw@mail.gmail.com>
	<AANLkTikRHAHhDXEEcejT5BqiJXiIaQX-lhg3zqTljcnq@mail.gmail.com>
	<AANLkTim93O9PgptYEdBkAf_x7reIf_1DxbHCYjLdfVLB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 139C424691
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Jul 2010 21:37:54 +0200 (CEST)
Received: by fxm15 with SMTP id 15so5117795fxm.38
	for <alsa-devel@alsa-project.org>; Tue, 06 Jul 2010 12:37:53 -0700 (PDT)
In-Reply-To: <AANLkTim93O9PgptYEdBkAf_x7reIf_1DxbHCYjLdfVLB@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: melwyn lobo <linux.melwyn@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 6 July 2010 18:46, melwyn lobo <linux.melwyn@gmail.com> wrote:
> For software robustness, we need to ensure that even after an XRUN
> no data is missed.
>
Not possible. You can recover from the XRUN state but you will never
reach "no data is missed".
