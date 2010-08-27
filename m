From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: explicit commandline control of speakers vs
 headphone output
Date: Fri, 27 Aug 2010 08:26:09 +0200
Message-ID: <4C775A81.6070606@ladisch.de>
References: <562109.6212.qm@web50708.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 02A04243FA
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 08:26:08 +0200 (CEST)
In-Reply-To: <562109.6212.qm@web50708.mail.re2.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Holstege <eric_holstege@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Eric Holstege wrote:
> My specific sound HW is "nVidia Corporation MCP79 High Definition Audio 
> (rev b1)"

This is the HDA controller, which can be combined with any HDA codec,
which actually controls mixing.

Please show the output of "amixer scontents".


Regards,
Clemens
