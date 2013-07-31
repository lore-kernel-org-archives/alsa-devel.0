From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: No need to use strncmp()
Date: Wed, 31 Jul 2013 12:59:29 +0100
Message-ID: <20130731115929.GA26438@opensource.wolfsonmicro.com>
References: <1375260253-23376-1-git-send-email-dp@opensource.wolfsonmicro.com>
 <20130731090726.GF9858@sirena.org.uk>
 <20130731094814.GA7231@opensource.wolfsonmicro.com>
 <20130731110147.GI9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9CC7526162E
 for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2013 13:59:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130731110147.GI9858@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 31, 2013 at 12:01:47PM +0100, Mark Brown wrote:
> On Wed, Jul 31, 2013 at 10:48:14AM +0100, Dimitris Papastamos wrote:
> > On Wed, Jul 31, 2013 at 10:07:26AM +0100, Mark Brown wrote:
> > > On Wed, Jul 31, 2013 at 09:44:13AM +0100, Dimitris Papastamos wrote:
> > > > Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> 
> > > Why?
> 
> > Hm, strncmp() suggests that we might not care about the entire string.
> > Although trivial, I thought strcmp() is clearer in this context.
> 
> One of the reasons we use strncmp() here is to avoid going beyond the
> end of the fixed size buffer.

Right, surely though the kcontrol names are always null terminated?
In any case, looks more safe to strncmp().
