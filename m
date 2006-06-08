From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB sound card driver - Line6 Toneport UX1
Date: Thu, 08 Jun 2006 19:57:48 +0200
Message-ID: <20060608175748.GB5868@turing.informatik.uni-halle.de>
References: <160c13350606080943v3171dc13je7160710b847de29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-reply-to: <160c13350606080943v3171dc13je7160710b847de29@mail.gmail.com>
Content-disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Stefano D'Angelo <zanga.mail@gmail.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Stefano D'Angelo wrote:
> where do I actually have to submit urbs?  In which callback?

The first time in the trigger callback, then in the URB's completion
callback.


HTH
Clemens
