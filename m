From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: RE: [alsa-devel] [RFC/RFT PATCH] ASoC: topology: Improve backwards
 compatibility with v4 topology files
Date: Fri, 25 May 2018 09:04:55 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F88276C0ED@SHSMSX103.ccr.corp.intel.com>
References: <20180522165842.233949-1-groeck@google.com>
 <s5hmuwqpjdd.wl-tiwai@suse.de> <20180523135609.GK4828@sirena.org.uk>
 <CABXOdTeCr-ExO9O3XAHK-DnNf5yLGO0TPkXgs60TB90jGNB2_Q@mail.gmail.com>
 <20180523155811.GO4828@sirena.org.uk>
 <CABXOdTePWquSQaFQsoNTrVNmYydZLqF534zeoTfz0RfLDHSseA@mail.gmail.com>
 <20180524141842.GW4828@sirena.org.uk>
 <CABXOdTfKXqgRecs3xuxb-XRodJkK7+h5V0hqt889CsD6vkm5yA@mail.gmail.com>
 <20180524151137.GY4828@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180524151137.GY4828@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Guenter Roeck <groeck@google.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "Patel, Chintan M" <chintan.m.patel@intel.com>, Guenter Roeck <groeck@chromium.org>, "Nc, Shreyas" <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-bounces@alsa-
> project.org] On Behalf Of Mark Brown
> Sent: Thursday, May 24, 2018 11:12 PM
 
> On Thu, May 24, 2018 at 07:55:06AM -0700, Guenter Roeck wrote:
> > On Thu, May 24, 2018 at 7:18 AM Mark Brown <broonie@kernel.org> wrote:
> 
> Your mail client formatting seems to be broken, the word wrapping is really
> funky (it looks like it's breaking longer than 80 column lines in the middle of
> paragraphs rather than flowing paragraphs within 80 columns).
> 
> > > > I don't mind adding the structures to
> > > > sound/soc/intel/skylake/skl-tplg-interface.h,
> > > > but it seems a bit out of scope to tie this with moving the file
> > > > to include/uapi/sound.
> > > > I think that should be a separate discussion.
> 
> > > Is there some reason not to just do it while we're looking at this?
> > > I don't see why we wouldn't want to do this.
> 
> > I don't mind doing this. However, keeping the change local and in a
> > single patch would make it easier to backport, and I think that the
> > ability to backport would be essential to get more than one-person
> > test coverage. I also would have liked feedback from someone at Intel,
> > at least for the Skylake specific structures.
> 
> Oh, of course - I'm just saying we should do this, not that everything needs to be
> in one patch.  Obviously the code motion would be a separate patch.
> 
> > Anyway, what file do you have in mind for the structure definitions,
> > both for the ones in soc-tolopogy.c and the ones needed in
> > skl-topology.c ? Everything into asoc.h, or something else ?
> 
> All of those that can appear in a firmware file, I don't super care where they end
> up but possibly a separate header file or files to the kernel specific ones as they
> might get used with Windows.

Please put the Skylake specific structures in a separate header file, not in asoc.h. 

The file asoc.h is for generic topology structures which are platform independent. The topology code in alsa-lib never parses the platform specific structures.

The Skylake specific structures are needed by vendor applications like Intel topology tool (ITT) to define topology for different platforms. The applications can include both asoc.h, skl-tplg-interface.h and other device specific headers.

Thanks
Mengdong
