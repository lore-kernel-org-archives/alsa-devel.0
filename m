From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ASoC: Intel: fix sst firmware path
Date: Thu, 5 Feb 2015 11:56:06 +0000
Message-ID: <20150205115606.7ad3336f@lxorguk.ukuu.org.uk>
References: <1423078507-30032-1-git-send-email-kevin.strasser@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423078507-30032-1-git-send-email-kevin.strasser@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Strasser <kevin.strasser@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>, Mengdong Lin <mengdong.lin@intel.com>, linux-kernel@vger.kernel.org, Yang Fang <yang.a.fang@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed,  4 Feb 2015 11:35:07 -0800
Kevin Strasser <kevin.strasser@linux.intel.com> wrote:

> All sst firmware is provided under the intel directory of the linux-firmware
> tree. By default this directory structure is kept when installing on a target
> system. Change the path to expect a default linux-firmware installation.
> 
> Signed-off-by: Kevin Strasser <kevin.strasser@linux.intel.com>

You just broken existing systems. I agree entirely with your change - but
you need to search both paths for now and maybe in a few years time remove
the old path.

Alan
