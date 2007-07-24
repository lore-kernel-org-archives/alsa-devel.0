From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: Query regarding ALSA control interface
Date: Tue, 24 Jul 2007 20:02:37 +0530
Message-ID: <61445c750707240732jbe7bca0sf4881ed57e20ff13@mail.gmail.com>
References: <61445c750707231616s1936fda3p4fa0677cc187860c@mail.gmail.com>
	<1185260250.4021.1201714071@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 981EC1037FE
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Jul 2007 16:32:38 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so2579112wag
	for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2007 07:32:37 -0700 (PDT)
In-Reply-To: <1185260250.4021.1201714071@webmail.messagingengine.com>
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
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 7/24/07, Clemens Ladisch <cladisch@fastmail.net> wrote:
>
> Pharaoh . wrote:
> > Now, I have to implement a control which takes four different
> values..namely
> > 0,1.100 and 101. In this case what shoud be the type of control? It
> should
> > be ENUMERATED or INTEGER? I am confused here since the values are not
> > exactly in a range.
>
> An INTEGER control takes numeric values in a specific range, while an
> ENUMERATED control takes values that are not numerically related (but
> that are _internally_ represented as integers in a specific range).
>
> In your case, you'd probably want to use an enumerated control with the
> range 0..3, which maps to the four names "0", "1", "100" and "101".
>
>
> HTH
> Clemens



Thanks Clemens, I had implemented it using  ENUM type. It works.

-pharaoh.
