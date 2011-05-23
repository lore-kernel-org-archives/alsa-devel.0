From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] ALSA: HDA: Add jack detection for HDMI
Date: Mon, 23 May 2011 14:49:15 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0498A480B7@HQMAIL01.nvidia.com>
References: <4DD27C43.3050509@canonical.com> <s5hfwod5nz0.wl%tiwai@suse.de>
	<4DD4E909.80108@canonical.com> <s5htycr0zuf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 60FB4244BE
	for <alsa-devel@alsa-project.org>;
	Mon, 23 May 2011 23:49:25 +0200 (CEST)
In-Reply-To: <s5htycr0zuf.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, David Henningsson <david.henningsson@canonical.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote at Thursday, May 19, 2011 4:06 AM:
> At Thu, 19 May 2011 11:55:21 +0200,
> David Henningsson wrote:
> >
> > On 2011-05-17 17:46, Takashi Iwai wrote:
> > > At Tue, 17 May 2011 15:46:43 +0200,
> > > David Henningsson wrote:
> > >>
> > >> Just as for headphones and microphone jacks, this patch adds reporting
> > >> of HDMI jack status through the input layer.
> > >>
>...
> 
> OK, as the jack report itself doesn't play a big role yet so far for
> HD-audio, let's get it in, and give pressure to graphics guys :)

I've been testing a preliminary fix for this internally. I found that
the /proc ELD files correctly report monitor_present and eld_valid when
we hot unplug a monitor, but the other fields in the ELD file are not
cleared out to their default state. As best I can tell, this is an ALSA
driver issue, since our display driver only fills in the other fields
when ELDV==1.

-- 
nvpublic
