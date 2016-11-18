From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] crec: Add option to specify codec ID
Date: Fri, 18 Nov 2016 15:59:03 +0530
Message-ID: <20161118102903.GS2698@localhost>
References: <1479296649-18278-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <20161116130508.GZ3000@localhost>
 <1479301675.18450.18.camel@rf-debian.wolfsonmicro.main>
 <20161116134835.GW1575@localhost.localdomain>
 <1479308001.18450.25.camel@rf-debian.wolfsonmicro.main>
 <20161118035333.GG2698@localhost>
 <1479463868.18450.29.camel@rf-debian.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 03A4A266B17
 for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2016 11:19:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1479463868.18450.29.camel@rf-debian.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 18, 2016 at 10:11:08AM +0000, Richard Fitzgerald wrote:
> On Fri, 2016-11-18 at 09:23 +0530, Vinod Koul wrote:
> > On Wed, Nov 16, 2016 at 02:53:21PM +0000, Richard Fitzgerald wrote:
> > > On Wed, 2016-11-16 at 13:48 +0000, Charles Keepax wrote:
> > > > On Wed, Nov 16, 2016 at 01:07:55PM +0000, Richard Fitzgerald wrote:
> > > > > On Wed, 2016-11-16 at 18:35 +0530, Vinod Koul wrote:
> > > > > > On Wed, Nov 16, 2016 at 11:44:09AM +0000, Richard Fitzgerald wrote:
> > > > > > > This patch adds a -I command line option to set the codec ID,
> > > > > > > either from a defined set of string values or as a number.
> > > > > > 
> > > > > > Can you explain why you want to add this? The utility cant really record a
> > > > > > mp3 file!
> > > > > 
> > > > > You need to be able to pass a codec ID that the driver supports, and to
> > > > > indicate which codec you're trying to use. It's not useful to only be
> > > > > able to open the "PCM" codec. It doesn't really matter whether crec
> > > > > understands the content of the data, we're just pulling raw data, most
> > > > > likely for test/debug.
> > > > > 
> > > > > The wm_adsp driver on Wolfson/Cirrus codecs uses the new BESPOKE stream
> > > > > ID so we need a way to pass that. And we'd also need it for any drivers
> > > > > that had streams using other codec IDs.
> > 
> > Ah that was my guess too.
> > 
> > I am okay to be able to add bespoke format and use that to dump raw data.
> > But I am not okay to add codec formats which we dont support..
> > 
> 
> Well a raw dump would support MP3 because that is doesn't require any
> header and the framing is part of the data stream. So no special
> handling needed there. This may also apply to some of the other formats
> (I'm not an expert on them) so I'd rather have the option to be able to
> raw-dump any format and leave it to the user to decide whether that's
> sensible.
> 
> If you're debugging you may not care about the file format, you're
> actually interested in the raw data you get from the codec so dumping
> the output to a raw file would be useful even if you can't load that
> file into a music player.

While I agree with you on this, am worried that adding codecs may make
people think that we can record mp3 file for exmaple, which is not the case.

I think we can add pcm and bespoke as formats supported and allow any format to
be dumped to stdio. That way it is pretty clear to people ...

Thanks
-- 
~Vinod
