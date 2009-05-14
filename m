From: "Tomas 'Sleep_Walker' Cech" <sleep_walker@suse.cz>
Subject: Re: AC97 reset fail after suspend
Date: Thu, 14 May 2009 13:30:31 +0200
Message-ID: <200905141330.31299.sleep_walker@suse.cz>
References: <200905080148.20137.sleep_walker@suse.cz>
	<200905140357.35682.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <200905140357.35682.marek.vasut@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

> The following patch fixes the issue and should be correct. It's indeed a 
> regression that's not in wm9713, but is in wm9712. Please consider applying.

I already tried to add these lines, but it didn't help. I can't confirm that problem is gone.
But I agree that this patch should be applied.

Tomas Cech

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
