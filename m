From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: alsa-lib not installing plugins
Date: Mon, 22 Oct 2007 08:42:44 +0200
Message-ID: <1193035364.14319.1217095905@webmail.messagingengine.com>
References: <471A2784.6000205@cs.ttu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 6492024896
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Oct 2007 08:58:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <471A2784.6000205@cs.ttu.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Larry D. Pyeatt" <pyeatt@cs.ttu.edu>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Larry D. Pyeatt wrote:
>   I wrote a new plugin for alsa-lib.  After running make, there
> are .o and .lo files in src/pcm.  However, when I run make
> install, nothing gets put into /usr/lib/alsa-lib.

The plugins in alsa-lib/src/pcm/ are compiled into libasound.so.2 so
that they are available without dynamic linking.

To create a separate plugin, have a look at the alsa-plugins package.


HTH
Clemens
