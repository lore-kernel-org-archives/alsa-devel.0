From: Daniel Mack <daniel@caiaq.de>
Subject: Re: ALSA Control Questions (atomicity, error handling)
Date: Fri, 4 Dec 2009 13:06:51 +0100
Message-ID: <20091204120651.GI29442@buzzloop.caiaq.de>
References: <4B1803CE.3080501@gmx.de>
	<20091203195018.GK14091@buzzloop.caiaq.de>
	<4B18D6DA.6070809@gmx.de>
	<20091204113434.GR14091@buzzloop.caiaq.de>
	<4B18FA5B.8080600@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id BF70B103823
	for <alsa-devel@alsa-project.org>; Fri,  4 Dec 2009 13:06:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B18FA5B.8080600@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tobias Schneider <tobsnyder@gmx.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 04, 2009 at 01:02:35PM +0100, Tobias Schneider wrote:
> >One more thing: in case you intend to bring your code mainline, please
> >run scripts/checkpatch.pl on the patches before you submit. The sniplet
> >you posted has a number of style issues that should be fixed. In
> >particular, pay attention to indentation, comment style and parenthesis
> >positions - checkpatch.pl will help pointing out most if them.
> >
> >Daniel
> is there also any document (something like ALSA coding style guide)?

It's not ALSA specific but applies (or should apply) to all kernel code.
Read Documentation/CodingStyle :)

Daniel
