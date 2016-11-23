From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] crec: Add option to specify codec ID
Date: Wed, 23 Nov 2016 10:21:58 +0000
Message-ID: <1479896518.4317.7.camel@rf-debian.wolfsonmicro.main>
References: <1479296649-18278-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <20161116130508.GZ3000@localhost>
 <1479301675.18450.18.camel@rf-debian.wolfsonmicro.main>
 <20161116134835.GW1575@localhost.localdomain>
 <1479308001.18450.25.camel@rf-debian.wolfsonmicro.main>
 <20161118035333.GG2698@localhost>
 <1479463868.18450.29.camel@rf-debian.wolfsonmicro.main>
 <20161118102903.GS2698@localhost>
 <fe7dcb27-fda9-47bc-7766-2896e1954218@linux.intel.com>
 <20161118161737.GB1575@localhost.localdomain>
 <20161123034103.GZ2698@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FFC6266B22
 for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2016 11:22:04 +0100 (CET)
In-Reply-To: <20161123034103.GZ2698@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2016-11-23 at 09:11 +0530, Vinod Koul wrote:
> On Fri, Nov 18, 2016 at 04:17:37PM +0000, Charles Keepax wrote:
> > On Fri, Nov 18, 2016 at 08:39:38AM -0600, Pierre-Louis Bossart wrote:
> > > 
> > > >>If you're debugging you may not care about the file format, you're
> > > >>actually interested in the raw data you get from the codec so dumping
> > > >>the output to a raw file would be useful even if you can't load that
> > > >>file into a music player.
> > > >
> > > >While I agree with you on this, am worried that adding codecs may make
> > > >people think that we can record mp3 file for exmaple, which is not the case.
> > > >
> > > >I think we can add pcm and bespoke as formats supported and allow any format to
> > > >be dumped to stdio. That way it is pretty clear to people ...
> > > 
> > > Crec as is it is pretty useless with PCM only...If we added the profile
> > > selection and things like bitrate information it'd be straightforward to
> > > support elementary bitstreams like MP3 or AAC ADTS, you just dump the data
> > > to a file. Things that require a header or MP4 integration would require
> > > additional libraries, this is no longer 'tiny'.
> > 
> > What about this as a suggestion, if we remove the code that adds
> > the WAV header. Then all the output from crecord is raw data and
> > the addition of any headers or additional wrapping is up to the
> > user. That keeps crecord 'tiny' and allows us to support all the
> > formats in a consistent way so no one gets confused.
> 
> Naah, crecord is a utility. If you need to do above you have tinycompress
> APIs to get the data and pack it the way you like.. You don't and shouldn't
> use crecord for that.
> 

But you can't call APIs from a shell command line, it needs a tool. For
debugging and testing we need a utility that can extract the raw data
from a codec. It's not the case that you _must_ have this data wrapped
in a file format just because normally it would be - for debugging the
raw dump may be sufficient, you aren't necessarily only interested in
playing it in a music app, for debugging you are likely to be more
interested in the actual bytes and in fact it could be preferable to
have it raw and not modified into a container file.

> > We haven't actually used the WAV header stuff since the very
> > early versions of our firmware that didn't use compression on the
> > stream and actually did output PCM data and I don't think anyone
> > else has ever used the compressed interface for PCM.
> 
> Thats fine by me. The only reason we have a WAV header is that we can pack
> PCM files, for rest of the formats it become tricky as Pierre mention so lets
> not go that road :)
> 

I'm confused now about what you want.
If we don't want to allow raw dumps in crecord we need another tool -
say cdump - that can dump raw, but obviously it would be 99% identical
to crecord except that it's blessed with the ability to dump raw, and I
don't see the point of having two near-identical tools.

The alternative is that Cirrus maintains its own branched version of
tinycompress with useful tools but that doesn't seem like a sensible
road to go down either.
