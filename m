From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Confused about 'default' device
Date: Wed, 24 Oct 2007 14:41:55 +0200
Message-ID: <1193229715.5138.1217568855@webmail.messagingengine.com>
References: <471E4E2A.9090105@freescale.com> <s5h4pggevv8.wl%tiwai@suse.de>
	<1193225838.26984.1217558213@webmail.messagingengine.com>
	<471F3C23.2000401@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 761132441A
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Oct 2007 14:41:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <471F3C23.2000401@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

Rene Herman wrote:
> On 10/24/2007 01:37 PM, Clemens Ladisch wrote:
> > In this case, it uses only the "default" PCM device.  There seems to be
> > some problem with its definition.
> 
> Just in case you guys missed it -- he posted:
> 
> ===
> alsa-init: using ALSA 1.0.8
> ===
> 
> Isn't 1.0.8 from before ALSA did any mixing by default?

The default "default" device would do automatic sample format
conversion even in that version.


Regards,
Clemens
