From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: Re: [PATCH] hda_proc - Add a number of new settings to
	proc codec output
Date: Fri, 18 Jan 2008 02:08:42 -0500
Message-ID: <76366b180801172308x6339f88ake1202b1523b4e714@mail.gmail.com>
References: <b86f0a07dd7d689a34ff.1200639943@am2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.185])
	by alsa0.perex.cz (Postfix) with ESMTP id C9B68247F3
	for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2008 08:08:46 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so656167rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2008 23:08:43 -0800 (PST)
In-Reply-To: <b86f0a07dd7d689a34ff.1200639943@am2>
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
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Takashi,

Please refer to the second post of the patch and disregard the first
one. I noticed the EAPD status was being printed in the wrong location
(my chipset doesn't have EAPD, so I didn't realize until it was too
late), so I changed it in the second post.

Thanks,
-Andrew
