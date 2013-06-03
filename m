From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: cplay error "Can't find sync world"
Date: Mon, 3 Jun 2013 17:20:04 +0100
Message-ID: <20130603162004.GC31108@opensource.wolfsonmicro.com>
References: <51AC55B4.5080105@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 811FD261B15
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2013 18:29:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <51AC55B4.5080105@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Keyon.Jey" <yang.jie@linux.intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, lakshmi.n.vinnakota@intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 03, 2013 at 04:37:08PM +0800, Keyon.Jey wrote:
> when I try use clpay -c 1 -d 2 test.mp3 to use tinycompress hwdec on my  
> phone, "Can't find sync world" always occurred, no matter what mp3 music  
> I try to play.

I believe the issue here is cplay does not currently handle MP3s
with meta data, such as track naming etc. You will need to strip
anything like this from the start of the MP3 file before playing.

Charles
