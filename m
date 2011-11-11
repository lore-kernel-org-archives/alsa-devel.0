From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Need help with "BUG: key e69d3aac not in .data!"
Date: Fri, 11 Nov 2011 13:18:14 +0100
Message-ID: <4EBD1286.4080805@ladisch.de>
References: <4EBC6DDA.2010900@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id E0C6D244DB
	for <alsa-devel@alsa-project.org>; Fri, 11 Nov 2011 13:16:55 +0100 (CET)
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id BBCF320C1D
	for <alsa-devel@alsa-project.org>; Fri, 11 Nov 2011 07:16:54 -0500 (EST)
In-Reply-To: <4EBC6DDA.2010900@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Timur Tabi wrote:
> I turned on some mutex debugging options, and now I'm getting this in my audio driver:
> 
> Freescale Synchronous Serial Interface (SSI) ASoC Driver                        
> BUG: key e69d3aac not in .data!                                                 
> 
> Is there something wrong with the way I'm calling device_create_file()?

When you have a dynamically allocated sysfs attribute, you must
initialize it with sysfs_(bin_)attr_init().


Regards,
Clemens
