From: Matteo Sasso <matteo.sasso@gmail.com>
Subject: Re: Problem with intel-hda integrated audio
Date: Fri, 23 May 2008 10:50:00 +0200
Message-ID: <200805231050.00854.matteo.sasso@gmail.com>
References: <200805222138.35409.matteo.sasso@gmail.com>
	<1211496699.8312.155.camel@razman>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 55D9C24601
	for <alsa-devel@alsa-project.org>;
	Fri, 23 May 2008 10:50:06 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so312172fgg.44
	for <alsa-devel@alsa-project.org>; Fri, 23 May 2008 01:50:05 -0700 (PDT)
In-Reply-To: <1211496699.8312.155.camel@razman>
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
To: Tobin Davis <tdavis@dsl-only.net>
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Friday 23 May 2008 00:51:39 Tobin Davis wrote:
> IF this is the same issue as previously posted in alsa-user, then i have
> an idea what may be going on.  Try rebooting the system with "acpi=off"
> in the kernel boot parameters.  If this makes audio work, you have an
> issue with your acpi tables.

Hey, that worked like a charm! I didn't know ACPI could do that, so it didn't 
cross my mind to try fiddling with anything else other than the ALSA driver.

Thanks a lot, Tobin! ;)
