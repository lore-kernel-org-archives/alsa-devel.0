From: "Strasser, Kevin" <kevin.strasser@intel.com>
Subject: RE: [PATCH] ASoC: Intel: fix possible acpi enumeration panic
Date: Thu, 11 Dec 2014 21:55:38 +0000
Message-ID: <51B6C3CD1F10FB47A5702881E0E230A74A0ECAE1@ORSMSX104.amr.corp.intel.com>
References: <1418282517-851-1-git-send-email-kevin.strasser@intel.com>
 <20141211132026.GY11764@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141211132026.GY11764@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, "Koul, Vinod" <vinod.koul@intel.com>, "Lin, Mengdong" <mengdong.lin@intel.com>, "Fang, Yang A" <yang.a.fang@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Thursday, December 11, 2014 5:20 AM> 
> On Wed, Dec 10, 2014 at 11:21:57PM -0800, Kevin Strasser wrote:
> 
> > A crash can occur on some platforms where adsp is enumerated but codec
> > is not matched. Check that the codec_id string is valid before
> > attempting to match.
> 
> > -	for (mach = machines; mach->codec_id; mach++)
> > +	for (mach = machines; mach->codec_id[0]; mach++)
> 
> This changes the check from verifying if a codec_id is present to verifying if
> the first character in the codec_id is non-NULL.  That doesn't seem obviously
> safer and the tables of machines seem to be terminated by having an entry
> with all fields set to zero (which is a common idiom in Linux) which would
> now crash with this change.

In this case mach->codec_id is non-NULL, even for the terminating element, because it
is defined to be a fixed width. So we have to take a look at the first character to see if it
has been initialized.

-Kevin
