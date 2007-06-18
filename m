From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Query regarding pcm->private_data
Date: Mon, 18 Jun 2007 09:43:20 +0200
Message-ID: <1182152600.10064.1195675067@webmail.messagingengine.com>
References: <61445c750706160713u3fe57101ic524fe20d4b5eee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 8F9EF2417B
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Jun 2007 09:43:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <61445c750706160713u3fe57101ic524fe20d4b5eee@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Pharaoh ." <pharaoh137@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pharaoh . wrote:
> I am reading 'Wring an alsa driver'.  It says following about the
> private_data:
> 
> You can allocate a record for the substream and store it in
> runtime->private_data. Usually, this is done in the open callback.
> Don't mix this with pcm->private_data. The pcm->private_data usually
> points the chip instance assigned statically at the creation of PCM, while the
> runtime->private_data points a dynamic data created at the PCM open callback.
> 
> What does static and dynamic mean here?

Nothing much.  "Static" just means that this is not allocated/freed
together with a stream's runtime.  The my_chip data is usually allocated
from the heap, but the runtime->private_data is _more_ dynamic because
it is allocated every time a stream is opened.


HTH
Clemens
