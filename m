From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 0/7] Modernize vga_switcheroo by using
 device link for HDA
Date: Mon, 12 Mar 2018 17:54:47 +0100
Message-ID: <20180312165447.GJ8589@phenom.ffwll.local>
References: <cover.1520068884.git.lukas@wunner.de>
 <20180306102940.GG22212@phenom.ffwll.local>
 <20180311155549.GA11806@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C8FE267172
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 17:54:51 +0100 (CET)
Received: by mail-wm0-f53.google.com with SMTP id s206so14285758wme.0
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 09:54:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180311155549.GA11806@wunner.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lukas Wunner <lukas@wunner.de>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, alsa-devel@alsa-project.org, Martin Lopatar <lopin@dataplex.cz>, Hans de Goede <hdegoede@redhat.com>, linux-pci@vger.kernel.org, Gustavo Padovan <gustavo@padovan.org>, Maik Freudenberg <hhfeuer@gmx.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Daniel Drake <dan@reactivated.net>, dri-devel@lists.freedesktop.org, Denis Lisov <dennis.lissov@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Mike Lothian <mike@fireburn.co.uk>, Sean Paul <seanpaul@chromium.org>, Peter Wu <peter@lekensteyn.nl>, Daniel Vetter <daniel@ffwll.ch>, nouveau@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, Lyude Paul <lyude@redhat.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 11, 2018 at 04:55:49PM +0100, Lukas Wunner wrote:
> On Tue, Mar 06, 2018 at 11:29:40AM +0100, Daniel Vetter wrote:
> > On Sat, Mar 03, 2018 at 10:53:24AM +0100, Lukas Wunner wrote:
> > > Modernize vga_switcheroo by using a device link to enforce a runtime PM
> > > dependency from an HDA controller to the GPU it's integrated into, v2.
> > > 
> > > https://github.com/l1k/linux/commits/switcheroo_devlink_v2
> > 
> > This all looks really reasonable and like a good cleanup, but it's a bit
> > too much detail so I'll punt review to someone else with more clue.
> 
> Patches [3/7] to [7/7] were reviewed by Peter Wu, the HDA bits in
> patch [5/7] additionally by Takashi.
> 
> Patch [2/7] was acked by Bjorn.  There was no ack for patch [1/7]
> (authored by Rafael), but it adressed the objection Bjorn raised
> against my original patch, so I'm assuming Bjorn is okay with it.
> (Bjorn, please let me know if that isn't the case.)

Since it's written by someone else your s-o-b counts as full review (wrt
drm-misc rules at least as implemented by dim). So sounds like you have
review for all the bits.

> The series has been tested on 5 systems, which raises the confidence:
> 2x AMD PowerXpress (Mike Lothian, Kai Heng Feng)
> 2x Nvidia Optimus (Denis Lisov, Peter Wu)
> 1x MacBook Pro
> 
> The issues found during Peter Wu's thorough testing appear to all
> be unrelated to this series, as per my e-mail yesterday.
> 
> If there are no objections, I plan to push the series to
> drm-misc-next by the middle of the coming week so that it
> would still catch the last train to 4.17.

Please make sure all maintainers of other bits are ok with that and have
given their formal ack for merging through drm-misc. With that you have
until end of this week (but don't cut it too short) to sneak it into 4.17.
Otherwise just push and it'll land in 4.18.

I think you've got all the other pieces.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
