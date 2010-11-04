From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: soc-cache: Add support for
 rbtree based register caching
Date: Thu, 4 Nov 2010 14:50:29 -0400
Message-ID: <20101104185029.GF6088@opensource.wolfsonmicro.com>
References: <1288880564-31957-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<1288880564-31957-5-git-send-email-dp@opensource.wolfsonmicro.com>
	<20101104184948.GE6088@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B479024417
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2010 19:50:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20101104184948.GE6088@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 04, 2010 at 02:49:48PM -0400, Mark Brown wrote:

> Hrm, dirty handling is kind of interesting.  It is unconditionally set
> in the write function and never cleared so we'll always rewrite a
> register if it's ever been touched.  Is it worth remembering the default
> values and just comparing with them, the memory overhead will probably
> be low since we only have one bitfield value here...  (and remember that
> we'll be unlikely to allocate memory in 21 byte packed hunks with no
> overhead...).

BTW, this does look like a very nice win overall.
