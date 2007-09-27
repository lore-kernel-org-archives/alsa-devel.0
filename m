From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Creative Labs XFi drivers.
Date: Thu, 27 Sep 2007 09:11:12 +0200
Message-ID: <1190877072.11003.1212854455@webmail.messagingengine.com>
References: <1190870997.30667.140.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id E73422459B
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Sep 2007 09:11:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1190870997.30667.140.camel@razman.gruemaster.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tobin Davis <tdavis@dsl-only.net>, ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Tobin Davis wrote:
> What I don't understand, is are they allowed to use our code to build
> their drivers?  They use alsa core modules to interoperate (from what I
> can tell in the Readme.txt).

The GPL disallows distributing binaries of GPL-derived code.  Creative
doesn't do that; AFAICS all files interfacing with ALSA are distributed
as source code.

> Also, this line in the License.txt is especially troubling:
> 
> > In the event that the Software includes Linux code or drivers, then,
> > unless expressly stated to the contrary, such Linux code and drivers
> > are proprietary to Creative and all rights therein are reserved.

What's troubling about that?

All code in the package is Creative's, and not licensed under the GPL.
If they'd include some GPL code by somebody else, it would be expressly
stated as such.


Regards,
Clemens
