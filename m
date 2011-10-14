From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [pulseaudio-discuss] alsa ucm in pulseaudio
Date: Fri, 14 Oct 2011 13:01:45 +0100
Message-ID: <20111014120145.GE2966@opensource.wolfsonmicro.com>
References: <CAJ4+uhUoBqTfDdDGEo_cKpzpdOmCPODfts7Afij1vafW+hwG=w@mail.gmail.com>
	<4E97D81E.4080607@canonical.com>
	<CAJ4+uhUL-mR_=Tot4XBbQuMRgbg45raL+058prXgEmrpG5Jukg@mail.gmail.com>
	<4E97F964.4080701@canonical.com>
	<CAJ4+uhUGgcFtZrYdu4-kzd8Er5tr0rFuAu4foY04Ku2JyQaeyw@mail.gmail.com>
	<4E980CC9.2050303@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 69EEC103836
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Oct 2011 14:01:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E980CC9.2050303@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org, linaro-dev@lists.linaro.org, General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>, Colin Guthrie <gmane@colin.guthr.ie>, Feng Wei <feng.wei@linaro.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 14, 2011 at 12:19:53PM +0200, David Henningsson wrote:
> On 10/14/2011 11:42 AM, Feng Wei wrote:

> >Actually we must map the concepts because ucm is designed for abstract
> >the complicated kcontrol. In my mind, if we use ucm in pa, the
> >original profile configuration files and mixer configuration files
> >will be replaced by ucm configuration files.

> Removing the original profile configuration files might be possible
> in an embedded scenario, but for all hundreds of different
> snd-hda-intel/AC'97/etc configurations out there, writing UCM
> configurations to fit all of them is just not scalable. (If so, one
> would have to write an auto-UCM tool that autogenerates UCM profiles
> based on present hardware.)

Yes, writing UCM files for PCs which have reasonably regular and
discoverable audio is silly - if UCM is used at all on most desktops it
should be with automatically generated configuration.
