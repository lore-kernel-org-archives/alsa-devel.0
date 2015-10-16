From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: DP1.2 MST audio support discussion
Date: Fri, 16 Oct 2015 08:51:30 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D1974F6DD@SHSMSX103.ccr.corp.intel.com>
References: <96A12704CE18D347B625EE2D4A099D1974C250@SHSMSX103.ccr.corp.intel.com>
 <561CA911.7070405@canonical.com>
 <96A12704CE18D347B625EE2D4A099D1974C304@SHSMSX103.ccr.corp.intel.com>
 <s5hlhb7ktum.wl-tiwai@suse.de>
 <CAN8cciZJ_YJhHEoU9HovR=P7FsxiKMDQ7johrmFGEWHQK_ZYNg@mail.gmail.com>
 <s5htwpuj6f5.wl-tiwai@suse.de>
 <CAN8cciYqLBH=kXvPjrGTgGPg9p7euU5w9z=UYdvKk4Vnxf-YFw@mail.gmail.com>
 <s5h7fmngvxu.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 798FD26062F
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2015 10:51:36 +0200 (CEST)
In-Reply-To: <s5h7fmngvxu.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, "airlied@linux.ie" <airlied@linux.ie>, "Lin,
 Mengdong" <mengdong.lin@intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "tanuk@iki.fi" <tanuk@iki.fi>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Friday, October 16, 2015 2:38 PM
> To: Raymond Yau
> Cc: Yang, Libin; ALSA Development Mailing List; airlied@linux.ie; Lin,
> Mengdong; Girdwood, Liam R; tanuk@iki.fi; David Henningsson
> Subject: Re: [alsa-devel] DP1.2 MST audio support discussion
> 
> On Fri, 16 Oct 2015 02:32:50 +0200,
> Raymond Yau wrote:
> >
> > > >
> > > > Do it mean that only one DP MST port and no HDMI port on the
> same
> > graphic
> > > > card ?
> > >
> > > No.
> >
> > If there is only one HDMI and one Display Port, this mean that there
> are
> > two pin complexes
> 
> Yes, and the mapping doesn't change in this case as before.
> 
> > How about the name of jack detection kctl of three Display Port
> monitors
> > which are created on the same pin complex but different dev_index ?
> 
> It's one of the models we've considered.  Basically the number of
> devices can be up to 64 (or such) per pin.  For Intel case, due to the
> limitation of converters, it's up to 3.  For other GPUs that may drive
> more simultaneous outputs, the number increases in square.  If a GPU
> may handle 16 outputs, it'll be 256 entries.
> 
> Although the 256 entries are certainly manageable as kctl, whether
> this is the best representation for user-space is a question.

This is what I concern. Each device entry should have one tag
for unsol event. This means each device entry will create a jack?

> 
> > Will three three display port monitor playback devices always play
> > different stream even when the displays are in clone mode ?
> 
> The clone mode is another messy part...
> 
> > > > If DP MST are dasiy chained, the unplug of the first monitor from
> > Display
> > > > Port will cause all DP monitor in the dasiy chain disconnect
> > >
> > > Yes.
> > >
> >
> > Do the power off of the Display Port in the middle of the dasiy chain
> also
> > affect the last display port mointor in the dasiy chain ?
> 
> Possibly.  But it's not what we really care, as this is the thing the
> graphics side should handle.
> 
> 
> Takashi
