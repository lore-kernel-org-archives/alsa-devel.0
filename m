From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v6 0/1] A codec driver for the TI WL1273 FM
	Radio.
Date: Tue, 17 Aug 2010 12:43:36 +0100
Message-ID: <20100817114336.GC18179@rakim.wolfsonmicro.main>
References: <1282045280-16696-1-git-send-email-matti.j.aaltonen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D06972414D
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Aug 2010 13:43:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1282045280-16696-1-git-send-email-matti.j.aaltonen@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Cc: alsa-devel@alsa-project.org, peter.ujfalusi@nokia.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 17, 2010 at 02:41:19PM +0300, Matti J. Aaltonen wrote:

> I didn't get any comments to the latest patch set. But now I've had
> a change to test the codec in multi component environment. I had
> to change the get_format function because the number of channels couldn't
> be used for determining the format. Also I added a few audio related 
> defines to the header file.

This seems to be some sort of Nokia thing but if you're sending a single
patch there's rarely any reason to include a cover mail.  Either include
your comments in the commit message if they're useful there, or include
them after the --- otherwise.
