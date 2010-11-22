From: torbenh <torbenh@gmx.de>
Subject: Re: [PATCH] jack: use eventfd which never blocks.
Date: Mon, 22 Nov 2010 16:04:31 +0100
Message-ID: <20101122150431.GO4646@siel.b>
References: <1290176549-31258-1-git-send-email-torbenh@gmx.de>
	<4CE8F14C.4040003@gmail.com> <20101122121518.GM4646@siel.b>
	<1290431349.2382.2.camel@patrakov-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by alsa0.perex.cz (Postfix) with SMTP id C61B024158
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 16:04:35 +0100 (CET)
Received: from torbenh by siel.b with local (Exim 4.72)
	(envelope-from <torbenh@gmx.de>) id 1PKXwV-0005P5-Rh
	for alsa-devel@alsa-project.org; Mon, 22 Nov 2010 16:04:31 +0100
Content-Disposition: inline
In-Reply-To: <1290431349.2382.2.camel@patrakov-desktop>
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
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 22, 2010 at 06:09:09PM +0500, Alexander E. Patrakov wrote:
> torbenh wrote:
> > i think in the case of mmap, there are one byte written -> advance one
> > period rules. these promises are not kept, when the write end is made
> > non-blocking.
> 
> I was not aware of such rules. So, please disregard my review.

(i am not aware of them either....
 but this is the only real explanation i have, why things go wrong.
 with the O_NONBLOCK patch and flash)
 and also why the read does not eat all data thats in the pipe)


> 
> -- 
> Alexander E. Patrakov
> 

-- 
torben Hohn
