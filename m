From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [GIT PULL] fixes for wrong DB_RANGE_HEADER sizes
Date: Mon, 21 Nov 2011 11:30:27 +0000
Message-ID: <20111121113027.GC3784@opensource.wolfsonmicro.com>
References: <4EC91ADF.30702@ladisch.de>
	<20111120210245.GD2976@opensource.wolfsonmicro.com>
	<4EC97783.60305@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CBD5D24485
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 12:30:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4EC97783.60305@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 20, 2011 at 10:56:19PM +0100, Clemens Ladisch wrote:

> This patch series fixes several drivers where TLV_DB_RANGE_HEAD() was
> used with a wrong number of entries, which resulted in a missing entry
> (in rt5631) or in some surplus entries with random data being returned
> (all other drivers).

Thanks, pulled now.
